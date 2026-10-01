// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OtpState {

 OtpFlowType get flowType; OtpStatus get status; int get remainingSeconds; String get otpCode; String get message; String? get resetToken;
/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpStateCopyWith<OtpState> get copyWith => _$OtpStateCopyWithImpl<OtpState>(this as OtpState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OtpState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpState&&(identical(other.flowType, _this.flowType) || other.flowType == _this.flowType)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.remainingSeconds, _this.remainingSeconds) || other.remainingSeconds == _this.remainingSeconds)&&(identical(other.otpCode, _this.otpCode) || other.otpCode == _this.otpCode)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.resetToken, _this.resetToken) || other.resetToken == _this.resetToken));
}


@override
int get hashCode {
  final _this = this as OtpState;
  return Object.hash(runtimeType,_this.flowType,_this.status,_this.remainingSeconds,_this.otpCode,_this.message,_this.resetToken);
}

@override
String toString() {
  final _this = this as OtpState;
  return 'OtpState(flowType: ${_this.flowType}, status: ${_this.status}, remainingSeconds: ${_this.remainingSeconds}, otpCode: ${_this.otpCode}, message: ${_this.message}, resetToken: ${_this.resetToken})';
}


}

/// @nodoc
abstract mixin class $OtpStateCopyWith<$Res>  {
  factory $OtpStateCopyWith(OtpState value, $Res Function(OtpState) _then) = _$OtpStateCopyWithImpl;
@useResult
$Res call({
 OtpFlowType flowType, OtpStatus status, int remainingSeconds, String otpCode, String message, String? resetToken
});




}
/// @nodoc
class _$OtpStateCopyWithImpl<$Res>
    implements $OtpStateCopyWith<$Res> {
  _$OtpStateCopyWithImpl(this._self, this._then);

  final OtpState _self;
  final $Res Function(OtpState) _then;

/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? flowType = null,Object? status = null,Object? remainingSeconds = null,Object? otpCode = null,Object? message = null,Object? resetToken = freezed,}) {
  return _then(OtpState(
flowType: null == flowType ? _self.flowType : flowType // ignore: cast_nullable_to_non_nullable
as OtpFlowType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OtpStatus,remainingSeconds: null == remainingSeconds ? _self.remainingSeconds : remainingSeconds // ignore: cast_nullable_to_non_nullable
as int,otpCode: null == otpCode ? _self.otpCode : otpCode // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,resetToken: freezed == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OtpState].
extension OtpStatePatterns on OtpState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtpState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtpState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtpState value)  $default,){
final _that = this;
switch (_that) {
case _OtpState():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtpState value)?  $default,){
final _that = this;
switch (_that) {
case _OtpState() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( OtpFlowType flowType,  OtpStatus status,  int remainingSeconds,  String otpCode,  String message,  String? resetToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtpState() when $default != null:
return $default(_that.flowType,_that.status,_that.remainingSeconds,_that.otpCode,_that.message,_that.resetToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( OtpFlowType flowType,  OtpStatus status,  int remainingSeconds,  String otpCode,  String message,  String? resetToken)  $default,) {final _that = this;
switch (_that) {
case _OtpState():
return $default(_that.flowType,_that.status,_that.remainingSeconds,_that.otpCode,_that.message,_that.resetToken);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( OtpFlowType flowType,  OtpStatus status,  int remainingSeconds,  String otpCode,  String message,  String? resetToken)?  $default,) {final _that = this;
switch (_that) {
case _OtpState() when $default != null:
return $default(_that.flowType,_that.status,_that.remainingSeconds,_that.otpCode,_that.message,_that.resetToken);case _:
  return null;

}
}

}

/// @nodoc


class _OtpState implements OtpState {
  const _OtpState({this.flowType = OtpFlowType.signup, this.status = OtpStatus.idle, this.remainingSeconds = 0, this.otpCode = '', this.message = '', this.resetToken});
  

@override@JsonKey() final  OtpFlowType flowType;
@override@JsonKey() final  OtpStatus status;
@override@JsonKey() final  int remainingSeconds;
@override@JsonKey() final  String otpCode;
@override@JsonKey() final  String message;
@override final  String? resetToken;

/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpStateCopyWith<_OtpState> get copyWith => __$OtpStateCopyWithImpl<_OtpState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpState&&(identical(other.flowType, flowType) || other.flowType == flowType)&&(identical(other.status, status) || other.status == status)&&(identical(other.remainingSeconds, remainingSeconds) || other.remainingSeconds == remainingSeconds)&&(identical(other.otpCode, otpCode) || other.otpCode == otpCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken));
}


@override
int get hashCode {
    return Object.hash(runtimeType,flowType,status,remainingSeconds,otpCode,message,resetToken);
}

@override
String toString() {
    return 'OtpState(flowType: $flowType, status: $status, remainingSeconds: $remainingSeconds, otpCode: $otpCode, message: $message, resetToken: $resetToken)';
}


}

/// @nodoc
abstract mixin class _$OtpStateCopyWith<$Res> implements $OtpStateCopyWith<$Res> {
  factory _$OtpStateCopyWith(_OtpState value, $Res Function(_OtpState) _then) = __$OtpStateCopyWithImpl;
@override @useResult
$Res call({
 OtpFlowType flowType, OtpStatus status, int remainingSeconds, String otpCode, String message, String? resetToken
});




}
/// @nodoc
class __$OtpStateCopyWithImpl<$Res>
    implements _$OtpStateCopyWith<$Res> {
  __$OtpStateCopyWithImpl(this._self, this._then);

  final _OtpState _self;
  final $Res Function(_OtpState) _then;

/// Create a copy of OtpState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? flowType = null,Object? status = null,Object? remainingSeconds = null,Object? otpCode = null,Object? message = null,Object? resetToken = freezed,}) {
  return _then(_OtpState(
flowType: null == flowType ? _self.flowType : flowType // ignore: cast_nullable_to_non_nullable
as OtpFlowType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OtpStatus,remainingSeconds: null == remainingSeconds ? _self.remainingSeconds : remainingSeconds // ignore: cast_nullable_to_non_nullable
as int,otpCode: null == otpCode ? _self.otpCode : otpCode // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,resetToken: freezed == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
