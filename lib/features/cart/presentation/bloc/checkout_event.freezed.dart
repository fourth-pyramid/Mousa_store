// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CheckoutEvent {

 int? get governorateId;
/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutEventCopyWith<CheckoutEvent> get copyWith => _$CheckoutEventCopyWithImpl<CheckoutEvent>(this as CheckoutEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CheckoutEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutEvent&&(identical(other.governorateId, _this.governorateId) || other.governorateId == _this.governorateId));
}


@override
int get hashCode {
  final _this = this as CheckoutEvent;
  return Object.hash(runtimeType,_this.governorateId);
}

@override
String toString() {
  final _this = this as CheckoutEvent;
  return 'CheckoutEvent(governorateId: ${_this.governorateId})';
}


}

/// @nodoc
abstract mixin class $CheckoutEventCopyWith<$Res>  {
  factory $CheckoutEventCopyWith(CheckoutEvent value, $Res Function(CheckoutEvent) _then) = _$CheckoutEventCopyWithImpl;
@useResult
$Res call({
 int? governorateId
});




}
/// @nodoc
class _$CheckoutEventCopyWithImpl<$Res>
    implements $CheckoutEventCopyWith<$Res> {
  _$CheckoutEventCopyWithImpl(this._self, this._then);

  final CheckoutEvent _self;
  final $Res Function(CheckoutEvent) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? governorateId = freezed,}) {
  return _then(_self.copyWith(
governorateId: freezed == governorateId ? _self.governorateId : governorateId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutEvent].
extension CheckoutEventPatterns on CheckoutEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CheckoutSubmitted value)?  submitted,TResult Function( ShippingFeeRequested value)?  shippingFeeRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CheckoutSubmitted() when submitted != null:
return submitted(_that);case ShippingFeeRequested() when shippingFeeRequested != null:
return shippingFeeRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CheckoutSubmitted value)  submitted,required TResult Function( ShippingFeeRequested value)  shippingFeeRequested,}){
final _that = this;
switch (_that) {
case CheckoutSubmitted():
return submitted(_that);case ShippingFeeRequested():
return shippingFeeRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CheckoutSubmitted value)?  submitted,TResult? Function( ShippingFeeRequested value)?  shippingFeeRequested,}){
final _that = this;
switch (_that) {
case CheckoutSubmitted() when submitted != null:
return submitted(_that);case ShippingFeeRequested() when shippingFeeRequested != null:
return shippingFeeRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String userAddress,  String userName,  String userPhone,  int? governorateId)?  submitted,TResult Function( int? governorateId)?  shippingFeeRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CheckoutSubmitted() when submitted != null:
return submitted(_that.userAddress,_that.userName,_that.userPhone,_that.governorateId);case ShippingFeeRequested() when shippingFeeRequested != null:
return shippingFeeRequested(_that.governorateId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String userAddress,  String userName,  String userPhone,  int? governorateId)  submitted,required TResult Function( int? governorateId)  shippingFeeRequested,}) {final _that = this;
switch (_that) {
case CheckoutSubmitted():
return submitted(_that.userAddress,_that.userName,_that.userPhone,_that.governorateId);case ShippingFeeRequested():
return shippingFeeRequested(_that.governorateId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String userAddress,  String userName,  String userPhone,  int? governorateId)?  submitted,TResult? Function( int? governorateId)?  shippingFeeRequested,}) {final _that = this;
switch (_that) {
case CheckoutSubmitted() when submitted != null:
return submitted(_that.userAddress,_that.userName,_that.userPhone,_that.governorateId);case ShippingFeeRequested() when shippingFeeRequested != null:
return shippingFeeRequested(_that.governorateId);case _:
  return null;

}
}

}

/// @nodoc


class CheckoutSubmitted implements CheckoutEvent {
  const CheckoutSubmitted({required this.userAddress, required this.userName, required this.userPhone, this.governorateId});
  

 final  String userAddress;
 final  String userName;
 final  String userPhone;
@override final  int? governorateId;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutSubmittedCopyWith<CheckoutSubmitted> get copyWith => _$CheckoutSubmittedCopyWithImpl<CheckoutSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutSubmitted&&(identical(other.userAddress, userAddress) || other.userAddress == userAddress)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userPhone, userPhone) || other.userPhone == userPhone)&&(identical(other.governorateId, governorateId) || other.governorateId == governorateId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,userAddress,userName,userPhone,governorateId);
}

@override
String toString() {
    return 'CheckoutEvent.submitted(userAddress: $userAddress, userName: $userName, userPhone: $userPhone, governorateId: $governorateId)';
}


}

/// @nodoc
abstract mixin class $CheckoutSubmittedCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $CheckoutSubmittedCopyWith(CheckoutSubmitted value, $Res Function(CheckoutSubmitted) _then) = _$CheckoutSubmittedCopyWithImpl;
@override @useResult
$Res call({
 String userAddress, String userName, String userPhone, int? governorateId
});




}
/// @nodoc
class _$CheckoutSubmittedCopyWithImpl<$Res>
    implements $CheckoutSubmittedCopyWith<$Res> {
  _$CheckoutSubmittedCopyWithImpl(this._self, this._then);

  final CheckoutSubmitted _self;
  final $Res Function(CheckoutSubmitted) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userAddress = null,Object? userName = null,Object? userPhone = null,Object? governorateId = freezed,}) {
  return _then(CheckoutSubmitted(
userAddress: null == userAddress ? _self.userAddress : userAddress // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userPhone: null == userPhone ? _self.userPhone : userPhone // ignore: cast_nullable_to_non_nullable
as String,governorateId: freezed == governorateId ? _self.governorateId : governorateId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class ShippingFeeRequested implements CheckoutEvent {
  const ShippingFeeRequested({this.governorateId});
  

@override final  int? governorateId;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShippingFeeRequestedCopyWith<ShippingFeeRequested> get copyWith => _$ShippingFeeRequestedCopyWithImpl<ShippingFeeRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ShippingFeeRequested&&(identical(other.governorateId, governorateId) || other.governorateId == governorateId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,governorateId);
}

@override
String toString() {
    return 'CheckoutEvent.shippingFeeRequested(governorateId: $governorateId)';
}


}

/// @nodoc
abstract mixin class $ShippingFeeRequestedCopyWith<$Res> implements $CheckoutEventCopyWith<$Res> {
  factory $ShippingFeeRequestedCopyWith(ShippingFeeRequested value, $Res Function(ShippingFeeRequested) _then) = _$ShippingFeeRequestedCopyWithImpl;
@override @useResult
$Res call({
 int? governorateId
});




}
/// @nodoc
class _$ShippingFeeRequestedCopyWithImpl<$Res>
    implements $ShippingFeeRequestedCopyWith<$Res> {
  _$ShippingFeeRequestedCopyWithImpl(this._self, this._then);

  final ShippingFeeRequested _self;
  final $Res Function(ShippingFeeRequested) _then;

/// Create a copy of CheckoutEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? governorateId = freezed,}) {
  return _then(ShippingFeeRequested(
governorateId: freezed == governorateId ? _self.governorateId : governorateId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
