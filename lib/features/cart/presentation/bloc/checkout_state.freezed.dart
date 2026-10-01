// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutState {

 RequestStatus get checkoutStatus; RequestStatus get shippingFeeStatus; String? get message; String? get shippingFee; String? get errorMessage;
/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutStateCopyWith<CheckoutState> get copyWith => _$CheckoutStateCopyWithImpl<CheckoutState>(this as CheckoutState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CheckoutState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutState&&(identical(other.checkoutStatus, _this.checkoutStatus) || other.checkoutStatus == _this.checkoutStatus)&&(identical(other.shippingFeeStatus, _this.shippingFeeStatus) || other.shippingFeeStatus == _this.shippingFeeStatus)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.shippingFee, _this.shippingFee) || other.shippingFee == _this.shippingFee)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as CheckoutState;
  return Object.hash(runtimeType,_this.checkoutStatus,_this.shippingFeeStatus,_this.message,_this.shippingFee,_this.errorMessage);
}

@override
String toString() {
  final _this = this as CheckoutState;
  return 'CheckoutState(checkoutStatus: ${_this.checkoutStatus}, shippingFeeStatus: ${_this.shippingFeeStatus}, message: ${_this.message}, shippingFee: ${_this.shippingFee}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $CheckoutStateCopyWith<$Res>  {
  factory $CheckoutStateCopyWith(CheckoutState value, $Res Function(CheckoutState) _then) = _$CheckoutStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus checkoutStatus, RequestStatus shippingFeeStatus, String? message, String? shippingFee, String? errorMessage
});




}
/// @nodoc
class _$CheckoutStateCopyWithImpl<$Res>
    implements $CheckoutStateCopyWith<$Res> {
  _$CheckoutStateCopyWithImpl(this._self, this._then);

  final CheckoutState _self;
  final $Res Function(CheckoutState) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? checkoutStatus = null,Object? shippingFeeStatus = null,Object? message = freezed,Object? shippingFee = freezed,Object? errorMessage = freezed,}) {
  return _then(CheckoutState(
checkoutStatus: null == checkoutStatus ? _self.checkoutStatus : checkoutStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,shippingFeeStatus: null == shippingFeeStatus ? _self.shippingFeeStatus : shippingFeeStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,shippingFee: freezed == shippingFee ? _self.shippingFee : shippingFee // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutState].
extension CheckoutStatePatterns on CheckoutState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutState value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutState value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus checkoutStatus,  RequestStatus shippingFeeStatus,  String? message,  String? shippingFee,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
return $default(_that.checkoutStatus,_that.shippingFeeStatus,_that.message,_that.shippingFee,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus checkoutStatus,  RequestStatus shippingFeeStatus,  String? message,  String? shippingFee,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _CheckoutState():
return $default(_that.checkoutStatus,_that.shippingFeeStatus,_that.message,_that.shippingFee,_that.errorMessage);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus checkoutStatus,  RequestStatus shippingFeeStatus,  String? message,  String? shippingFee,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutState() when $default != null:
return $default(_that.checkoutStatus,_that.shippingFeeStatus,_that.message,_that.shippingFee,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _CheckoutState implements CheckoutState {
  const _CheckoutState({this.checkoutStatus = RequestStatus.initial, this.shippingFeeStatus = RequestStatus.initial, this.message, this.shippingFee, this.errorMessage});
  

@override@JsonKey() final  RequestStatus checkoutStatus;
@override@JsonKey() final  RequestStatus shippingFeeStatus;
@override final  String? message;
@override final  String? shippingFee;
@override final  String? errorMessage;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutStateCopyWith<_CheckoutState> get copyWith => __$CheckoutStateCopyWithImpl<_CheckoutState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutState&&(identical(other.checkoutStatus, checkoutStatus) || other.checkoutStatus == checkoutStatus)&&(identical(other.shippingFeeStatus, shippingFeeStatus) || other.shippingFeeStatus == shippingFeeStatus)&&(identical(other.message, message) || other.message == message)&&(identical(other.shippingFee, shippingFee) || other.shippingFee == shippingFee)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,checkoutStatus,shippingFeeStatus,message,shippingFee,errorMessage);
}

@override
String toString() {
    return 'CheckoutState(checkoutStatus: $checkoutStatus, shippingFeeStatus: $shippingFeeStatus, message: $message, shippingFee: $shippingFee, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$CheckoutStateCopyWith<$Res> implements $CheckoutStateCopyWith<$Res> {
  factory _$CheckoutStateCopyWith(_CheckoutState value, $Res Function(_CheckoutState) _then) = __$CheckoutStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus checkoutStatus, RequestStatus shippingFeeStatus, String? message, String? shippingFee, String? errorMessage
});




}
/// @nodoc
class __$CheckoutStateCopyWithImpl<$Res>
    implements _$CheckoutStateCopyWith<$Res> {
  __$CheckoutStateCopyWithImpl(this._self, this._then);

  final _CheckoutState _self;
  final $Res Function(_CheckoutState) _then;

/// Create a copy of CheckoutState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? checkoutStatus = null,Object? shippingFeeStatus = null,Object? message = freezed,Object? shippingFee = freezed,Object? errorMessage = freezed,}) {
  return _then(_CheckoutState(
checkoutStatus: null == checkoutStatus ? _self.checkoutStatus : checkoutStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,shippingFeeStatus: null == shippingFeeStatus ? _self.shippingFeeStatus : shippingFeeStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,shippingFee: freezed == shippingFee ? _self.shippingFee : shippingFee // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
