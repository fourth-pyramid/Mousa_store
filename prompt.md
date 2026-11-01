# Task: Upgrade the Flutter internet-connection service to detect REAL internet access (captive portals, "mobile data on but no balance", dead uplinks)

You are working in an existing Flutter/Dart project (package name `mousa_store`). Read the existing code first, then implement the changes below. Do not ask questions unless something is truly blocking; make sensible decisions and list them at the end.

## 1. Context: what exists today

Files involved (find them with Glob/Grep, they are under `lib/core/...`):

1. `core/service/internet_connection_service.dart`
   - `enum NetworkState { checking, connected, unstable, disconnected }`
   - `abstract interface class IInternetConnectionService` (streams: `stateStream`, `connectivityRestoredStream`; methods: `hasConnection()`, `checkNow()`, `reportLatency(int ms)`, `dispose()`; getters: `currentState`, `isStable`)
   - `NetworkConfig` constants
   - `InternetConnectionService` (uses `connectivity_plus` + `internet_connection_checker_plus`, a 5-second periodic ping timer, `_slowHits` counter, `WidgetsBindingObserver` lifecycle handling)
2. A Dio interceptor `StabilityInterceptor` that measures request latency and calls `reportLatency`.
3. A widget `InternetConnectionWrapper` (+ private `_NetworkBanner`) that shows a banner (disconnected / unstable / restored) using `context.colors`, `context.typography`, `context.durations`, `context.l10n`, and `getIt<InternetConnectionService>()`.

## 2. Problems to solve (root causes)

- **Interface up != internet.** `connectivity_plus` reports WiFi/mobile as available even when the SIM has data enabled but no balance, or the WiFi router has no uplink, or a captive portal intercepts traffic. Carriers/portals often answer with a redirect or a `200` page, so a plain "status == 200" check gives false positives.
- **No active recovery while offline.** When state becomes `disconnected`, the periodic timer is stopped. If the user tops up their balance (no OS connectivity event fires), the banner stays stuck.
- **Shared `_slowHits` counter** is mutated by both the 5s ping and Dio latency reports, so they cancel each other (a fast ping resets slow HTTP hits, a fast request resets ping hits). "Unstable" flickers or never sticks.
- **`checkNow()` re-entrancy guard returns immediately** when a check is running, so `hasConnection()` can return `false` while state is still `checking` (false negative at startup).
- **Interceptor pollution:** cancelled requests, fast errors and upload/download durations are reported as latency.
- **Timer phase reset:** `_updateState` restarts the periodic timer on every state change.
- **Stale results:** a check started on WiFi can finish after switching to mobile data and overwrite the state.
- `AppLifecycleState.inactive` (iOS permission dialogs, notification shade) wrongly pauses checks.

## 3. Required design

### 3.1 New public types (same file as the service)

```dart
enum NetworkIssue { none, noInterface, noInternet, captivePortal }
```
- `noInterface`: OS reports no WiFi/mobile interface.
- `noInternet`: interface is up but real internet unreachable (no balance, blocked, dead uplink).
- `captivePortal`: something answered but not the real endpoint (redirect, or 2xx with unexpected body).

Extend `IInternetConnectionService` with:
- `NetworkIssue get lastIssue;`
- `void reportRequestFailure();` // called by the Dio interceptor on real network failures

### 3.2 `NetworkConfig` (all const)

| name | value | meaning |
|---|---|---|
| `pingIntervalSeconds` | 5 | check interval while connected/unstable |
| `recoveryBackoffSeconds` | `[2, 4, 6, 10, 15]` | check interval while disconnected; last value repeats |
| `slowPingThresholdMs` | 700 | probe latency counted as slow (TLS handshake makes 450 too strict) |
| `slowDioThresholdMs` | 2800 | real request latency counted as slow |
| `maxSlowHits` | 3 | |
| `slowHttpDecay` | 30 s | slow HTTP hits are forgotten after this long without a new slow request |
| `failuresBeforeDisconnect` | 2 | consecutive failed checks needed to leave connected/unstable |
| `requiredProbeSuccesses` | 2 | endpoints that must agree in a full check |
| `probeTimeout` | 4 s | |
| `failureCheckDebounce` | 3 s | min gap between failure-triggered checks |

### 3.3 `ReachabilityProbe` class (new, same file or a sibling file in `core/service/`)

Purpose: verify the REAL internet using HTTPS endpoints with STRICT response validation.

- Use `dart:io` `HttpClient` (no new dependency). Configure `connectionTimeout = probeTimeout`, `idleTimeout = 30s` (keep-alive so repeated probes avoid new TLS handshakes), custom userAgent.
- `ProbeTarget(Uri uri, bool Function(int statusCode, String body) isValid)`.
- Default targets (HTTPS only; cleartext HTTP is blocked by Android 9+/iOS ATS):
  1. `https://cp.cloudflare.com/generate_204` → valid iff status == 204
  2. `https://www.gstatic.com/generate_204` → valid iff status == 204
  3. `https://captive.apple.com/hotspot-detect.html` → valid iff status == 200 and body contains `Success`
- Targets must be injectable via constructor so the app can add its own backend health endpoint. Add a doc comment saying so.
- `Future<ProbeResult> run(ProbeTarget)`:
  - `followRedirects = false`, `Cache-Control: no-cache`, per-stage `.timeout(probeTimeout)`, call `request.abort()` on failure.
  - Measure latency = time until response headers arrive. Read at most ~4 KB of body, decode with `utf8.decode(..., allowMalformed: true)`.
  - Classification: 3xx → `portal`; `isValid` → `ok(latency)`; other 2xx (reachable but unexpected content) → `portal`; anything else / any exception (including TLS handshake failure, DNS failure, timeout) → `failed`.
- `Future<ProbeResult> runPrimary()`: probes only the endpoint that was fastest in the last successful full check (initially index 0).
- `Future<ProbeSummary> runAll()`: probe all targets in parallel. Success iff `okCount >= min(requiredProbeSuccesses, targets.length)`. On success: latency = **median** of ok latencies, and the fastest ok endpoint becomes the new primary. On failure: issue = `captivePortal` if any probe returned `portal`, else `noInternet`.
- `close()` → `HttpClient.close(force: true)`.
- Add a doc note: mobile/desktop only (not Flutter web).

### 3.4 `InternetConnectionService` behavior

Keep it implementing `IInternetConnectionService` and `WidgetsBindingObserver`. Constructor params (keep tests injectable): `ReachabilityProbe? probe`, `Connectivity? connectivity`, `Future<int?> Function()? pingChecker` (when provided it replaces the probe; returns latency ms or null on failure), `bool registerObserver = true`. **Remove** the `internet_connection_checker_plus` dependency/usage and its status-change listener (our own timer does recovery).

**Check pipeline (`_performCheck`)**
1. `connectivity.checkConnectivity()`; if empty or contains `none` → `lastIssue = noInterface`, state `disconnected` immediately (no hysteresis), return.
2. Reachability:
   - If state is `checking` or `disconnected`, or a "force consensus" flag is set (after network switch, app resume, request failure, or entering disconnected) → run `runAll()`.
   - Otherwise run the cheap `runPrimary()`; if it fails, fall back to `runAll()` (never trust one endpoint to declare offline).
3. On failure: `lastIssue = issue`, reset ping slow hits, `consecutiveFailures++`. Go `disconnected` when `consecutiveFailures >= (wasOnline ? failuresBeforeDisconnect : 1)`. Otherwise stay in the current state and re-check after ~1 s.
4. On success: `consecutiveFailures = 0`, clear force-consensus flag, `lastIssue = none`, reset recovery backoff. If latency >= `slowPingThresholdMs` → `slowPingHits++` else `slowPingHits = 0`. Then `_applyStability()`.

**Stability logic**
- Separate counters: `_slowPingHits` (from probes) and `_slowHttpHits` (from `reportLatency`). Store a timestamp for the last slow HTTP hit; in `_applyStability()` clear `_slowHttpHits` if older than `slowHttpDecay`.
- `_applyStability()`: if either counter >= `maxSlowHits` → `unstable`, else `connected`. Recovery from `unstable` therefore needs both counters clear.
- `reportLatency(ms)`: ignore when backgrounded/disposed or state is `disconnected`/`checking`. Slow → `_slowHttpHits++` + timestamp; fast → `_slowHttpHits = 0`. Then `_applyStability()`.
- `reportRequestFailure()`: ignore if backgrounded/disposed/`disconnected`; debounce with `failureCheckDebounce`; set force-consensus; `unawaited(checkNow())`.

**Scheduling (single self-rescheduling `Timer`, not `Timer.periodic`)**
- After every check run completes (in a `finally`), call `_scheduleNext()`: cancel the old timer, do nothing if backgrounded/disposed. Delay = `recoveryBackoffSeconds[min(attempt, len-1)]` (and `attempt++`) when `disconnected`; 1 s when `consecutiveFailures > 0`; otherwise `pingIntervalSeconds`.
- The timer MUST keep running while `disconnected` so balance top-ups / restored uplinks are detected without any OS event.
- Do not restart/reset the timer inside `_updateState`.

**Concurrency**
- Replace the `_pingRunning` bool with an in-flight future: `Future<void> checkNow() => _inFlight ??= _runChecks().whenComplete(() => _inFlight = null);`. Concurrent callers (including `hasConnection()` while `checking`) await the same check.
- `_runChecks()` loops `do { _recheck = false; await _performCheck(); } while (_recheck && !_isDisposed);`.
- Epoch guard: keep an `_epoch` int. Increment it on every `onConnectivityChanged` event (also set `_recheck = true` and force-consensus). `_performCheck` captures the epoch at start and discards its result if it changed (or if disposed) after any `await`.

**Connectivity listener**
- On event: bump epoch, set `_recheck`/force-consensus. If results are empty or contain `none` → `lastIssue = noInterface`, `_updateState(disconnected)`, `_scheduleNext()`. Else if not backgrounded → `unawaited(checkNow())`.

**`_updateState(next)`**
- No-op if disposed/closed/same state. Log the transition with `debugPrint`. When entering `disconnected`: reset both slow counters, reset recovery attempt, set force-consensus. Emit on `stateStream`. Emit on `connectivityRestoredStream` strictly for `disconnected → connected`.

**Lifecycle**
- `paused` and `hidden` → mark background, cancel timer. `resumed` → un-background, set force-consensus, `unawaited(checkNow())`. `inactive` and `detached` → ignore (do NOT treat `inactive` as background).

**`hasConnection()`**: if state is `checking`, `await checkNow()` (joins in-flight), then return `connected || unstable`.

**`dispose()`**: idempotent; remove observer (try/catch), cancel timer and subscriptions, close the probe, close both stream controllers.

### 3.5 `StabilityInterceptor` (Dio)

- Add `static const String skipKey = 'skipStability';`. If `options.extra[skipKey] == true`, report nothing (for uploads/downloads/long-polling).
- `onResponse`: report latency.
- `onError`, switch on `DioExceptionType`:
  - `cancel` → report nothing.
  - `connectionTimeout`, `sendTimeout`, `receiveTimeout` → `reportLatency(latency)` and `reportRequestFailure()`.
  - `connectionError` → `reportRequestFailure()` only (no latency).
  - `badResponse` → `reportLatency(latency)` (a 4xx/5xx is still a valid round trip).
  - `badCertificate`, `unknown` → nothing.
- Always `handler.next(...)` exactly once.

### 3.6 `InternetConnectionWrapper` / `_NetworkBanner`

1. Pass `issue: _service.lastIssue` into `_NetworkBanner`. For the disconnected style choose the message by issue (Arabic/English via the existing `isArabic` pattern, or better via ARB):
   - `captivePortal`: AR `الشبكة محتاجة تسجيل دخول أو الباقة منتهية — اضغط للفحص` / EN `Network needs sign-in or has no data balance — tap to check`
   - `noInternet`: AR `متصل بالشبكة لكن بدون إنترنت — تأكد من رصيد الباقة` / EN `Connected to the network but no internet — check your data balance`
   - default (`noInterface`/`none`): existing `${context.l10n.no_internet_title} — ${context.l10n.try_again_text}`
2. The wrapper must rebuild when the issue changes while already disconnected (the state didn't change, the issue might: e.g. `noInterface` → `captivePortal`). Either read `lastIssue` inside `build` on every setState, or have the stream listener call `setState` regardless of whether `_state` changed.
3. Remove the redundant `Directionality(textDirection: Directionality.of(context), ...)` wrapper.
4. Move the hardcoded Arabic/English strings (restored, unstable, and the two new ones) into the ARB files and use `context.l10n`, matching the project's l10n setup and generating code (`flutter gen-l10n` or whatever the project uses).
5. Replace `Colors.white` for banner content with a theme color (`context.colors.onError` / appropriate on-color) if it exists; if not, keep white but note it.
6. Avoid the double top inset: the banner uses `SafeArea(bottom: false)` and the child (Scaffold/AppBar) also pads for the status bar. While the banner is visible, wrap the child with `MediaQuery.removePadding(removeTop: true)`; to avoid losing the child's state when toggling, always wrap it in the same `MediaQuery`/`MediaQuery.removePadding` widget and only change the `removeTop` flag.

### 3.7 Housekeeping

- Remove `internet_connection_checker_plus` from `pubspec.yaml` ONLY if nothing else in the repo uses it (Grep first), then run `flutter pub get`.
- Update DI registration (`service_locator.dart`) if constructor parameters changed. Verify the interceptor is still registered with the same service instance.
- Android: confirm `INTERNET` and `ACCESS_NETWORK_STATE` permissions exist in `AndroidManifest.xml`. No cleartext config needed since only HTTPS is used.
- Follow the project's lint rules (`analysis_options.yaml`: trailing commas, `unawaited`, `on Object catch`, no `print`, etc.). Keep the existing code style and doc-comment style.

## 4. Tests to add/update (`test/...`, use `mocktail` or `flutter_test` fakes already used in the project)

Use a fake `Connectivity` (controllable stream + `checkConnectivity`) and a fake `ReachabilityProbe` / `pingChecker`; use `fakeAsync` for timers.

- Interface up + all probes fail → `disconnected` with `lastIssue == noInternet` (after first check from `checking`).
- Probes return `portal` → `lastIssue == captivePortal`.
- Connected, one failed check → still `connected`; second consecutive failure → `disconnected`.
- Disconnected → probe succeeds on a later timer tick (no connectivity event) → `connected` and `connectivityRestoredStream` fires exactly once.
- Backoff schedule while disconnected: ticks at 2, 4, 6, 10, 15, 15 s.
- Slow pings and slow HTTP hits are counted separately; a fast ping does not clear HTTP hits; HTTP hits decay after 30 s; `unstable → connected` only when both are clear.
- `hasConnection()` called during the initial check awaits and returns the correct result (no false negative); concurrent `checkNow()` calls share one in-flight future (probe called once).
- Network switch mid-check (connectivity event while a probe is pending): the stale result is discarded and a new check runs.
- `reportRequestFailure()` triggers a check, debounced within 3 s; ignored while disconnected.
- Lifecycle: `paused/hidden` cancel the timer; `resumed` triggers a check; `inactive` does nothing.
- `dispose()` is idempotent and closes streams.
- `ReachabilityProbe` strict validation (inject a local `HttpServer` or a fake `HttpClient`): 204 → ok; 302 → portal; 200 with wrong body → portal; 500 → failed; timeout → failed; consensus needs 2 of 3, median latency is returned.
- `StabilityInterceptor`: cancel → no report; timeout → latency + failure; connectionError → failure only; badResponse → latency; `skipStability` → nothing; `handler.next` called once in every case.
- Widget test for `InternetConnectionWrapper`: banner message changes for `captivePortal` / `noInternet` / `noInterface`, "restored" banner auto-hides after 1.8 s, no double top padding.

## 5. Acceptance criteria

- `flutter analyze` is clean; `flutter test` passes (including the new tests).
- Scenario "WiFi/mobile data connected but no internet or no balance" results in `disconnected` within ~6 seconds of startup/switch, with a banner explaining the likely cause; the banner clears automatically (with the green "restored" flash) within a few seconds after real internet returns, with no user action and no OS event.
- No flicker between connected/unstable/disconnected on a single timeout or single slow request.
- Healthy steady state costs one small HTTPS request every 5 s over a kept-alive connection.
- No public API removed except what is listed (the old `internetConnection` constructor parameter); all existing call sites compile.

## 6. Output expected from you

1. The implemented code and tests.
2. A short summary: files changed, any decisions you made where this spec was ambiguous, and anything you could not verify (e.g. real-device behavior with a no-balance SIM) with a manual test checklist (airplane mode, WiFi without uplink, mobile data with zero balance, captive portal WiFi, switching WiFi ↔ mobile mid-request, app background/resume).