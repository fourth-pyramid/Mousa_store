import 'package:flutter/material.dart';
import 'package:mousa_store/core/utils/context_extensions.dart';
import 'package:mousa_store/core/widgets/app_image.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({
    required this.isLogin,
    required this.onTabChanged,
    super.key,
  });
  final bool isLogin;
  final void Function({required bool isLogin}) onTabChanged;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: context.colors.headerGradient,
      ),
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
      boxShadow: context.shadows.card,
    ),
    child: SizedBox(
      width: double.infinity,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsetsDirectional.only(
            top: 14,
            bottom: 14,
            start: 20,
            end: 20,
          ),
          child: Column(
            children: [
              const Center(
                child: AppImage.asset(
                  'assets/images/mousa_store.png',
                  height: 80,
                  width: 80,
                  color: Colors.white,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 12),
              AnimatedSwitcher(
                duration: context.durations.fast,
                child: Text(
                  isLogin
                      ? context.l10n.auth_login
                      : context.l10n.auth_register,
                  key: ValueKey(isLogin),
                  style: context.typography.h1.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 44,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: const Color(0xFF222226),
                    borderRadius: context.radius.mdBorder,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.08),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final tabWidth = constraints.maxWidth / 2;
                        final isRtl =
                            Directionality.of(context) == TextDirection.rtl;

                        return Stack(
                          children: [
                            AnimatedPositioned(
                              duration: context.durations.normal,
                              curve: Curves.easeInOutCubic,
                              left: isRtl
                                  ? (isLogin ? tabWidth : 0)
                                  : (isLogin ? 0 : tabWidth),
                              width: tabWidth,
                              top: 0,
                              bottom: 0,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      context.colors.secondary,
                                      context.colors.error,
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                  borderRadius: context.radius.smBorder,
                                  boxShadow: [
                                    BoxShadow(
                                      color: context.colors.error.withValues(
                                        alpha: 0.35,
                                      ),
                                      blurRadius: 10,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => onTabChanged(isLogin: true),
                                    child: Center(
                                      child: AnimatedDefaultTextStyle(
                                        duration: context.durations.fast,
                                        style: context.typography.labelLarge
                                            .copyWith(
                                              color: isLogin
                                                  ? Colors.white
                                                  : const Color(0xFF9E9E9E),
                                              fontWeight: isLogin
                                                  ? FontWeight.bold
                                                  : FontWeight.w500,
                                              fontSize: 13,
                                            ),
                                        child: Text(context.l10n.auth_login),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    onTap: () => onTabChanged(isLogin: false),
                                    child: Center(
                                      child: AnimatedDefaultTextStyle(
                                        duration: context.durations.fast,
                                        style: context.typography.labelLarge
                                            .copyWith(
                                              color: !isLogin
                                                  ? Colors.white
                                                  : const Color(0xFF9E9E9E),
                                              fontWeight: !isLogin
                                                  ? FontWeight.bold
                                                  : FontWeight.w500,
                                              fontSize: 13,
                                            ),
                                        child: Text(context.l10n.auth_register),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
