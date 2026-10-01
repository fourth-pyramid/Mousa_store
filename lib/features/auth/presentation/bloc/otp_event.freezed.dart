// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OtpEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'OtpEvent()';
}


}

/// @nodoc
class $OtpEventCopyWith<$Res>  {
$OtpEventCopyWith(OtpEvent _, $Res Function(OtpEvent) __);
}


/// Adds pattern-matching-related methods to [OtpEvent].
extension OtpEventPatterns on OtpEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OtpTimerStarted value)?  started,TResult Function( OtpTimerTicked value)?  timerTicked,TResult Function( OtpCodeChanged value)?  codeChanged,TResult Function( OtpVerifySubmitted value)?  verifySubmitted,TResult Function( OtpResendSubmitted value)?  resendSubmitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OtpTimerStarted() when started != null:
return started(_that);case OtpTimerTicked() when timerTicked != null:
return timerTicked(_that);case OtpCodeChanged() when codeChanged != null:
return codeChanged(_that);case OtpVerifySubmitted() when verifySubmitted != null:
return verifySubmitted(_that);case OtpResendSubmitted() when resendSubmitted != null:
return resendSubmitted(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OtpTimerStarted value)  started,required TResult Function( OtpTimerTicked value)  timerTicked,required TResult Function( OtpCodeChanged value)  codeChanged,required TResult Function( OtpVerifySubmitted value)  verifySubmitted,required TResult Function( OtpResendSubmitted value)  resendSubmitted,}){
final _that = this;
switch (_that) {
case OtpTimerStarted():
return started(_that);case OtpTimerTicked():
return timerTicked(_that);case OtpCodeChanged():
return codeChanged(_that);case OtpVerifySubmitted():
return verifySubmitted(_that);case OtpResendSubmitted():
return resendSubmitted(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OtpTimerStarted value)?  started,TResult? Function( OtpTimerTicked value)?  timerTicked,TResult? Function( OtpCodeChanged value)?  codeChanged,TResult? Function( OtpVerifySubmitted value)?  verifySubmitted,TResult? Function( OtpResendSubmitted value)?  resendSubmitted,}){
final _that = this;
switch (_that) {
case OtpTimerStarted() when started != null:
return started(_that);case OtpTimerTicked() when timerTicked != null:
return timerTicked(_that);case OtpCodeChanged() when codeChanged != null:
return codeChanged(_that);case OtpVerifySubmitted() when verifySubmitted != null:
return verifySubmitted(_that);case OtpResendSubmitted() when resendSubmitted != null:
return resendSubmitted(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int seconds)?  started,TResult Function( int remainingSeconds)?  timerTicked,TResult Function( String code)?  codeChanged,TResult Function( String email)?  verifySubmitted,TResult Function( String email)?  resendSubmitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OtpTimerStarted() when started != null:
return started(_that.seconds);case OtpTimerTicked() when timerTicked != null:
return timerTicked(_that.remainingSeconds);case OtpCodeChanged() when codeChanged != null:
return codeChanged(_that.code);case OtpVerifySubmitted() when verifySubmitted != null:
return verifySubmitted(_that.email);case OtpResendSubmitted() when resendSubmitted != null:
return resendSubmitted(_that.email);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int seconds)  started,required TResult Function( int remainingSeconds)  timerTicked,required TResult Function( String code)  codeChanged,required TResult Function( String email)  verifySubmitted,required TResult Function( String email)  resendSubmitted,}) {final _that = this;
switch (_that) {
case OtpTimerStarted():
return started(_that.seconds);case OtpTimerTicked():
return timerTicked(_that.remainingSeconds);case OtpCodeChanged():
return codeChanged(_that.code);case OtpVerifySubmitted():
return verifySubmitted(_that.email);case OtpResendSubmitted():
return resendSubmitted(_that.email);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int seconds)?  started,TResult? Function( int remainingSeconds)?  timerTicked,TResult? Function( String code)?  codeChanged,TResult? Function( String email)?  verifySubmitted,TResult? Function( String email)?  resendSubmitted,}) {final _that = this;
switch (_that) {
case OtpTimerStarted() when started != null:
return started(_that.seconds);case OtpTimerTicked() when timerTicked != null:
return timerTicked(_that.remainingSeconds);case OtpCodeChanged() when codeChanged != null:
return codeChanged(_that.code);case OtpVerifySubmitted() when verifySubmitted != null:
return verifySubmitted(_that.email);case OtpResendSubmitted() when resendSubmitted != null:
return resendSubmitted(_that.email);case _:
  return null;

}
}

}

/// @nodoc


class OtpTimerStarted implements OtpEvent {
  const OtpTimerStarted({this.seconds = 600});
  

@JsonKey() final  int seconds;

/// Create a copy of OtpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpTimerStartedCopyWith<OtpTimerStarted> get copyWith => _$OtpTimerStartedCopyWithImpl<OtpTimerStarted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpTimerStarted&&(identical(other.seconds, seconds) || other.seconds == seconds));
}


@override
int get hashCode {
    return Object.hash(runtimeType,seconds);
}

@override
String toString() {
    return 'OtpEvent.started(seconds: $seconds)';
}


}

/// @nodoc
abstract mixin class $OtpTimerStartedCopyWith<$Res> implements $OtpEventCopyWith<$Res> {
  factory $OtpTimerStartedCopyWith(OtpTimerStarted value, $Res Function(OtpTimerStarted) _then) = _$OtpTimerStartedCopyWithImpl;
@useResult
$Res call({
 int seconds
});




}
/// @nodoc
class _$OtpTimerStartedCopyWithImpl<$Res>
    implements $OtpTimerStartedCopyWith<$Res> {
  _$OtpTimerStartedCopyWithImpl(this._self, this._then);

  final OtpTimerStarted _self;
  final $Res Function(OtpTimerStarted) _then;

/// Create a copy of OtpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? seconds = null,}) {
  return _then(OtpTimerStarted(
seconds: null == seconds ? _self.seconds : seconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OtpTimerTicked implements OtpEvent {
  const OtpTimerTicked(this.remainingSeconds);
  

 final  int remainingSeconds;

/// Create a copy of OtpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpTimerTickedCopyWith<OtpTimerTicked> get copyWith => _$OtpTimerTickedCopyWithImpl<OtpTimerTicked>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpTimerTicked&&(identical(other.remainingSeconds, remainingSeconds) || other.remainingSeconds == remainingSeconds));
}


@override
int get hashCode {
    return Object.hash(runtimeType,remainingSeconds);
}

@override
String toString() {
    return 'OtpEvent.timerTicked(remainingSeconds: $remainingSeconds)';
}


}

/// @nodoc
abstract mixin class $OtpTimerTickedCopyWith<$Res> implements $OtpEventCopyWith<$Res> {
  factory $OtpTimerTickedCopyWith(OtpTimerTicked value, $Res Function(OtpTimerTicked) _then) = _$OtpTimerTickedCopyWithImpl;
@useResult
$Res call({
 int remainingSeconds
});




}
/// @nodoc
class _$OtpTimerTickedCopyWithImpl<$Res>
    implements $OtpTimerTickedCopyWith<$Res> {
  _$OtpTimerTickedCopyWithImpl(this._self, this._then);

  final OtpTimerTicked _self;
  final $Res Function(OtpTimerTicked) _then;

/// Create a copy of OtpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? remainingSeconds = null,}) {
  return _then(OtpTimerTicked(
null == remainingSeconds ? _self.remainingSeconds : remainingSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OtpCodeChanged implements OtpEvent {
  const OtpCodeChanged(this.code);
  

 final  String code;

/// Create a copy of OtpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpCodeChangedCopyWith<OtpCodeChanged> get copyWith => _$OtpCodeChangedCopyWithImpl<OtpCodeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpCodeChanged&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode {
    return Object.hash(runtimeType,code);
}

@override
String toString() {
    return 'OtpEvent.codeChanged(code: $code)';
}


}

/// @nodoc
abstract mixin class $OtpCodeChangedCopyWith<$Res> implements $OtpEventCopyWith<$Res> {
  factory $OtpCodeChangedCopyWith(OtpCodeChanged value, $Res Function(OtpCodeChanged) _then) = _$OtpCodeChangedCopyWithImpl;
@useResult
$Res call({
 String code
});




}
/// @nodoc
class _$OtpCodeChangedCopyWithImpl<$Res>
    implements $OtpCodeChangedCopyWith<$Res> {
  _$OtpCodeChangedCopyWithImpl(this._self, this._then);

  final OtpCodeChanged _self;
  final $Res Function(OtpCodeChanged) _then;

/// Create a copy of OtpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? code = null,}) {
  return _then(OtpCodeChanged(
null == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OtpVerifySubmitted implements OtpEvent {
  const OtpVerifySubmitted({required this.email});
  

 final  String email;

/// Create a copy of OtpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpVerifySubmittedCopyWith<OtpVerifySubmitted> get copyWith => _$OtpVerifySubmittedCopyWithImpl<OtpVerifySubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpVerifySubmitted&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode {
    return Object.hash(runtimeType,email);
}

@override
String toString() {
    return 'OtpEvent.verifySubmitted(email: $email)';
}


}

/// @nodoc
abstract mixin class $OtpVerifySubmittedCopyWith<$Res> implements $OtpEventCopyWith<$Res> {
  factory $OtpVerifySubmittedCopyWith(OtpVerifySubmitted value, $Res Function(OtpVerifySubmitted) _then) = _$OtpVerifySubmittedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$OtpVerifySubmittedCopyWithImpl<$Res>
    implements $OtpVerifySubmittedCopyWith<$Res> {
  _$OtpVerifySubmittedCopyWithImpl(this._self, this._then);

  final OtpVerifySubmitted _self;
  final $Res Function(OtpVerifySubmitted) _then;

/// Create a copy of OtpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(OtpVerifySubmitted(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OtpResendSubmitted implements OtpEvent {
  const OtpResendSubmitted({required this.email});
  

 final  String email;

/// Create a copy of OtpEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpResendSubmittedCopyWith<OtpResendSubmitted> get copyWith => _$OtpResendSubmittedCopyWithImpl<OtpResendSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpResendSubmitted&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode {
    return Object.hash(runtimeType,email);
}

@override
String toString() {
    return 'OtpEvent.resendSubmitted(email: $email)';
}


}

/// @nodoc
abstract mixin class $OtpResendSubmittedCopyWith<$Res> implements $OtpEventCopyWith<$Res> {
  factory $OtpResendSubmittedCopyWith(OtpResendSubmitted value, $Res Function(OtpResendSubmitted) _then) = _$OtpResendSubmittedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$OtpResendSubmittedCopyWithImpl<$Res>
    implements $OtpResendSubmittedCopyWith<$Res> {
  _$OtpResendSubmittedCopyWithImpl(this._self, this._then);

  final OtpResendSubmitted _self;
  final $Res Function(OtpResendSubmitted) _then;

/// Create a copy of OtpEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(OtpResendSubmitted(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
