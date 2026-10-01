// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CartEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CartEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CartEvent()';
}


}

/// @nodoc
class $CartEventCopyWith<$Res>  {
$CartEventCopyWith(CartEvent _, $Res Function(CartEvent) __);
}


/// Adds pattern-matching-related methods to [CartEvent].
extension CartEventPatterns on CartEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CartFetchRequested value)?  fetchRequested,TResult Function( CartItemAdded value)?  itemAdded,TResult Function( CartQuantityUpdated value)?  quantityUpdated,TResult Function( CartItemRemoved value)?  itemRemoved,TResult Function( CartResetRequested value)?  resetRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CartFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case CartItemAdded() when itemAdded != null:
return itemAdded(_that);case CartQuantityUpdated() when quantityUpdated != null:
return quantityUpdated(_that);case CartItemRemoved() when itemRemoved != null:
return itemRemoved(_that);case CartResetRequested() when resetRequested != null:
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CartFetchRequested value)  fetchRequested,required TResult Function( CartItemAdded value)  itemAdded,required TResult Function( CartQuantityUpdated value)  quantityUpdated,required TResult Function( CartItemRemoved value)  itemRemoved,required TResult Function( CartResetRequested value)  resetRequested,}){
final _that = this;
switch (_that) {
case CartFetchRequested():
return fetchRequested(_that);case CartItemAdded():
return itemAdded(_that);case CartQuantityUpdated():
return quantityUpdated(_that);case CartItemRemoved():
return itemRemoved(_that);case CartResetRequested():
return resetRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CartFetchRequested value)?  fetchRequested,TResult? Function( CartItemAdded value)?  itemAdded,TResult? Function( CartQuantityUpdated value)?  quantityUpdated,TResult? Function( CartItemRemoved value)?  itemRemoved,TResult? Function( CartResetRequested value)?  resetRequested,}){
final _that = this;
switch (_that) {
case CartFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case CartItemAdded() when itemAdded != null:
return itemAdded(_that);case CartQuantityUpdated() when quantityUpdated != null:
return quantityUpdated(_that);case CartItemRemoved() when itemRemoved != null:
return itemRemoved(_that);case CartResetRequested() when resetRequested != null:
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( bool silent)?  fetchRequested,TResult Function( int propertyId,  int quantity)?  itemAdded,TResult Function( int cartItemId,  int quantity)?  quantityUpdated,TResult Function( int cartItemId)?  itemRemoved,TResult Function()?  resetRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CartFetchRequested() when fetchRequested != null:
return fetchRequested(_that.silent);case CartItemAdded() when itemAdded != null:
return itemAdded(_that.propertyId,_that.quantity);case CartQuantityUpdated() when quantityUpdated != null:
return quantityUpdated(_that.cartItemId,_that.quantity);case CartItemRemoved() when itemRemoved != null:
return itemRemoved(_that.cartItemId);case CartResetRequested() when resetRequested != null:
return resetRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( bool silent)  fetchRequested,required TResult Function( int propertyId,  int quantity)  itemAdded,required TResult Function( int cartItemId,  int quantity)  quantityUpdated,required TResult Function( int cartItemId)  itemRemoved,required TResult Function()  resetRequested,}) {final _that = this;
switch (_that) {
case CartFetchRequested():
return fetchRequested(_that.silent);case CartItemAdded():
return itemAdded(_that.propertyId,_that.quantity);case CartQuantityUpdated():
return quantityUpdated(_that.cartItemId,_that.quantity);case CartItemRemoved():
return itemRemoved(_that.cartItemId);case CartResetRequested():
return resetRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( bool silent)?  fetchRequested,TResult? Function( int propertyId,  int quantity)?  itemAdded,TResult? Function( int cartItemId,  int quantity)?  quantityUpdated,TResult? Function( int cartItemId)?  itemRemoved,TResult? Function()?  resetRequested,}) {final _that = this;
switch (_that) {
case CartFetchRequested() when fetchRequested != null:
return fetchRequested(_that.silent);case CartItemAdded() when itemAdded != null:
return itemAdded(_that.propertyId,_that.quantity);case CartQuantityUpdated() when quantityUpdated != null:
return quantityUpdated(_that.cartItemId,_that.quantity);case CartItemRemoved() when itemRemoved != null:
return itemRemoved(_that.cartItemId);case CartResetRequested() when resetRequested != null:
return resetRequested();case _:
  return null;

}
}

}

/// @nodoc


class CartFetchRequested implements CartEvent {
  const CartFetchRequested({this.silent = false});
  

@JsonKey() final  bool silent;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartFetchRequestedCopyWith<CartFetchRequested> get copyWith => _$CartFetchRequestedCopyWithImpl<CartFetchRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CartFetchRequested&&(identical(other.silent, silent) || other.silent == silent));
}


@override
int get hashCode {
    return Object.hash(runtimeType,silent);
}

@override
String toString() {
    return 'CartEvent.fetchRequested(silent: $silent)';
}


}

/// @nodoc
abstract mixin class $CartFetchRequestedCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory $CartFetchRequestedCopyWith(CartFetchRequested value, $Res Function(CartFetchRequested) _then) = _$CartFetchRequestedCopyWithImpl;
@useResult
$Res call({
 bool silent
});




}
/// @nodoc
class _$CartFetchRequestedCopyWithImpl<$Res>
    implements $CartFetchRequestedCopyWith<$Res> {
  _$CartFetchRequestedCopyWithImpl(this._self, this._then);

  final CartFetchRequested _self;
  final $Res Function(CartFetchRequested) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? silent = null,}) {
  return _then(CartFetchRequested(
silent: null == silent ? _self.silent : silent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class CartItemAdded implements CartEvent {
  const CartItemAdded({required this.propertyId, required this.quantity});
  

 final  int propertyId;
 final  int quantity;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemAddedCopyWith<CartItemAdded> get copyWith => _$CartItemAddedCopyWithImpl<CartItemAdded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItemAdded&&(identical(other.propertyId, propertyId) || other.propertyId == propertyId)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}


@override
int get hashCode {
    return Object.hash(runtimeType,propertyId,quantity);
}

@override
String toString() {
    return 'CartEvent.itemAdded(propertyId: $propertyId, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $CartItemAddedCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory $CartItemAddedCopyWith(CartItemAdded value, $Res Function(CartItemAdded) _then) = _$CartItemAddedCopyWithImpl;
@useResult
$Res call({
 int propertyId, int quantity
});




}
/// @nodoc
class _$CartItemAddedCopyWithImpl<$Res>
    implements $CartItemAddedCopyWith<$Res> {
  _$CartItemAddedCopyWithImpl(this._self, this._then);

  final CartItemAdded _self;
  final $Res Function(CartItemAdded) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? propertyId = null,Object? quantity = null,}) {
  return _then(CartItemAdded(
propertyId: null == propertyId ? _self.propertyId : propertyId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class CartQuantityUpdated implements CartEvent {
  const CartQuantityUpdated({required this.cartItemId, required this.quantity});
  

 final  int cartItemId;
 final  int quantity;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartQuantityUpdatedCopyWith<CartQuantityUpdated> get copyWith => _$CartQuantityUpdatedCopyWithImpl<CartQuantityUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CartQuantityUpdated&&(identical(other.cartItemId, cartItemId) || other.cartItemId == cartItemId)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}


@override
int get hashCode {
    return Object.hash(runtimeType,cartItemId,quantity);
}

@override
String toString() {
    return 'CartEvent.quantityUpdated(cartItemId: $cartItemId, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $CartQuantityUpdatedCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory $CartQuantityUpdatedCopyWith(CartQuantityUpdated value, $Res Function(CartQuantityUpdated) _then) = _$CartQuantityUpdatedCopyWithImpl;
@useResult
$Res call({
 int cartItemId, int quantity
});




}
/// @nodoc
class _$CartQuantityUpdatedCopyWithImpl<$Res>
    implements $CartQuantityUpdatedCopyWith<$Res> {
  _$CartQuantityUpdatedCopyWithImpl(this._self, this._then);

  final CartQuantityUpdated _self;
  final $Res Function(CartQuantityUpdated) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cartItemId = null,Object? quantity = null,}) {
  return _then(CartQuantityUpdated(
cartItemId: null == cartItemId ? _self.cartItemId : cartItemId // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class CartItemRemoved implements CartEvent {
  const CartItemRemoved({required this.cartItemId});
  

 final  int cartItemId;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemRemovedCopyWith<CartItemRemoved> get copyWith => _$CartItemRemovedCopyWithImpl<CartItemRemoved>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItemRemoved&&(identical(other.cartItemId, cartItemId) || other.cartItemId == cartItemId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,cartItemId);
}

@override
String toString() {
    return 'CartEvent.itemRemoved(cartItemId: $cartItemId)';
}


}

/// @nodoc
abstract mixin class $CartItemRemovedCopyWith<$Res> implements $CartEventCopyWith<$Res> {
  factory $CartItemRemovedCopyWith(CartItemRemoved value, $Res Function(CartItemRemoved) _then) = _$CartItemRemovedCopyWithImpl;
@useResult
$Res call({
 int cartItemId
});




}
/// @nodoc
class _$CartItemRemovedCopyWithImpl<$Res>
    implements $CartItemRemovedCopyWith<$Res> {
  _$CartItemRemovedCopyWithImpl(this._self, this._then);

  final CartItemRemoved _self;
  final $Res Function(CartItemRemoved) _then;

/// Create a copy of CartEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cartItemId = null,}) {
  return _then(CartItemRemoved(
cartItemId: null == cartItemId ? _self.cartItemId : cartItemId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class CartResetRequested implements CartEvent {
  const CartResetRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CartResetRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CartEvent.resetRequested()';
}


}




// dart format on
