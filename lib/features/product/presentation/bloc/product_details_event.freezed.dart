// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_details_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductDetailsEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProductDetailsEvent()';
}


}

/// @nodoc
class $ProductDetailsEventCopyWith<$Res>  {
$ProductDetailsEventCopyWith(ProductDetailsEvent _, $Res Function(ProductDetailsEvent) __);
}


/// Adds pattern-matching-related methods to [ProductDetailsEvent].
extension ProductDetailsEventPatterns on ProductDetailsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProductDetailsStarted value)?  started,TResult Function( ProductDetailsAttributeChanged value)?  attributeChanged,TResult Function( ProductDetailsQuantityChanged value)?  quantityChanged,TResult Function( ProductDetailsProductUpdated value)?  productUpdated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProductDetailsStarted() when started != null:
return started(_that);case ProductDetailsAttributeChanged() when attributeChanged != null:
return attributeChanged(_that);case ProductDetailsQuantityChanged() when quantityChanged != null:
return quantityChanged(_that);case ProductDetailsProductUpdated() when productUpdated != null:
return productUpdated(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProductDetailsStarted value)  started,required TResult Function( ProductDetailsAttributeChanged value)  attributeChanged,required TResult Function( ProductDetailsQuantityChanged value)  quantityChanged,required TResult Function( ProductDetailsProductUpdated value)  productUpdated,}){
final _that = this;
switch (_that) {
case ProductDetailsStarted():
return started(_that);case ProductDetailsAttributeChanged():
return attributeChanged(_that);case ProductDetailsQuantityChanged():
return quantityChanged(_that);case ProductDetailsProductUpdated():
return productUpdated(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProductDetailsStarted value)?  started,TResult? Function( ProductDetailsAttributeChanged value)?  attributeChanged,TResult? Function( ProductDetailsQuantityChanged value)?  quantityChanged,TResult? Function( ProductDetailsProductUpdated value)?  productUpdated,}){
final _that = this;
switch (_that) {
case ProductDetailsStarted() when started != null:
return started(_that);case ProductDetailsAttributeChanged() when attributeChanged != null:
return attributeChanged(_that);case ProductDetailsQuantityChanged() when quantityChanged != null:
return quantityChanged(_that);case ProductDetailsProductUpdated() when productUpdated != null:
return productUpdated(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ProductDetail product)?  started,TResult Function( String key,  String value)?  attributeChanged,TResult Function( int quantity)?  quantityChanged,TResult Function( ProductDetail product)?  productUpdated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProductDetailsStarted() when started != null:
return started(_that.product);case ProductDetailsAttributeChanged() when attributeChanged != null:
return attributeChanged(_that.key,_that.value);case ProductDetailsQuantityChanged() when quantityChanged != null:
return quantityChanged(_that.quantity);case ProductDetailsProductUpdated() when productUpdated != null:
return productUpdated(_that.product);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ProductDetail product)  started,required TResult Function( String key,  String value)  attributeChanged,required TResult Function( int quantity)  quantityChanged,required TResult Function( ProductDetail product)  productUpdated,}) {final _that = this;
switch (_that) {
case ProductDetailsStarted():
return started(_that.product);case ProductDetailsAttributeChanged():
return attributeChanged(_that.key,_that.value);case ProductDetailsQuantityChanged():
return quantityChanged(_that.quantity);case ProductDetailsProductUpdated():
return productUpdated(_that.product);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ProductDetail product)?  started,TResult? Function( String key,  String value)?  attributeChanged,TResult? Function( int quantity)?  quantityChanged,TResult? Function( ProductDetail product)?  productUpdated,}) {final _that = this;
switch (_that) {
case ProductDetailsStarted() when started != null:
return started(_that.product);case ProductDetailsAttributeChanged() when attributeChanged != null:
return attributeChanged(_that.key,_that.value);case ProductDetailsQuantityChanged() when quantityChanged != null:
return quantityChanged(_that.quantity);case ProductDetailsProductUpdated() when productUpdated != null:
return productUpdated(_that.product);case _:
  return null;

}
}

}

/// @nodoc


class ProductDetailsStarted implements ProductDetailsEvent {
  const ProductDetailsStarted(this.product);
  

 final  ProductDetail product;

/// Create a copy of ProductDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailsStartedCopyWith<ProductDetailsStarted> get copyWith => _$ProductDetailsStartedCopyWithImpl<ProductDetailsStarted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailsStarted&&(identical(other.product, product) || other.product == product));
}


@override
int get hashCode {
    return Object.hash(runtimeType,product);
}

@override
String toString() {
    return 'ProductDetailsEvent.started(product: $product)';
}


}

/// @nodoc
abstract mixin class $ProductDetailsStartedCopyWith<$Res> implements $ProductDetailsEventCopyWith<$Res> {
  factory $ProductDetailsStartedCopyWith(ProductDetailsStarted value, $Res Function(ProductDetailsStarted) _then) = _$ProductDetailsStartedCopyWithImpl;
@useResult
$Res call({
 ProductDetail product
});




}
/// @nodoc
class _$ProductDetailsStartedCopyWithImpl<$Res>
    implements $ProductDetailsStartedCopyWith<$Res> {
  _$ProductDetailsStartedCopyWithImpl(this._self, this._then);

  final ProductDetailsStarted _self;
  final $Res Function(ProductDetailsStarted) _then;

/// Create a copy of ProductDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,}) {
  return _then(ProductDetailsStarted(
null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductDetail,
  ));
}


}

/// @nodoc


class ProductDetailsAttributeChanged implements ProductDetailsEvent {
  const ProductDetailsAttributeChanged({required this.key, required this.value});
  

 final  String key;
 final  String value;

/// Create a copy of ProductDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailsAttributeChangedCopyWith<ProductDetailsAttributeChanged> get copyWith => _$ProductDetailsAttributeChangedCopyWithImpl<ProductDetailsAttributeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailsAttributeChanged&&(identical(other.key, key) || other.key == key)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,key,value);
}

@override
String toString() {
    return 'ProductDetailsEvent.attributeChanged(key: $key, value: $value)';
}


}

/// @nodoc
abstract mixin class $ProductDetailsAttributeChangedCopyWith<$Res> implements $ProductDetailsEventCopyWith<$Res> {
  factory $ProductDetailsAttributeChangedCopyWith(ProductDetailsAttributeChanged value, $Res Function(ProductDetailsAttributeChanged) _then) = _$ProductDetailsAttributeChangedCopyWithImpl;
@useResult
$Res call({
 String key, String value
});




}
/// @nodoc
class _$ProductDetailsAttributeChangedCopyWithImpl<$Res>
    implements $ProductDetailsAttributeChangedCopyWith<$Res> {
  _$ProductDetailsAttributeChangedCopyWithImpl(this._self, this._then);

  final ProductDetailsAttributeChanged _self;
  final $Res Function(ProductDetailsAttributeChanged) _then;

/// Create a copy of ProductDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? key = null,Object? value = null,}) {
  return _then(ProductDetailsAttributeChanged(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ProductDetailsQuantityChanged implements ProductDetailsEvent {
  const ProductDetailsQuantityChanged(this.quantity);
  

 final  int quantity;

/// Create a copy of ProductDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailsQuantityChangedCopyWith<ProductDetailsQuantityChanged> get copyWith => _$ProductDetailsQuantityChangedCopyWithImpl<ProductDetailsQuantityChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailsQuantityChanged&&(identical(other.quantity, quantity) || other.quantity == quantity));
}


@override
int get hashCode {
    return Object.hash(runtimeType,quantity);
}

@override
String toString() {
    return 'ProductDetailsEvent.quantityChanged(quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $ProductDetailsQuantityChangedCopyWith<$Res> implements $ProductDetailsEventCopyWith<$Res> {
  factory $ProductDetailsQuantityChangedCopyWith(ProductDetailsQuantityChanged value, $Res Function(ProductDetailsQuantityChanged) _then) = _$ProductDetailsQuantityChangedCopyWithImpl;
@useResult
$Res call({
 int quantity
});




}
/// @nodoc
class _$ProductDetailsQuantityChangedCopyWithImpl<$Res>
    implements $ProductDetailsQuantityChangedCopyWith<$Res> {
  _$ProductDetailsQuantityChangedCopyWithImpl(this._self, this._then);

  final ProductDetailsQuantityChanged _self;
  final $Res Function(ProductDetailsQuantityChanged) _then;

/// Create a copy of ProductDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? quantity = null,}) {
  return _then(ProductDetailsQuantityChanged(
null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class ProductDetailsProductUpdated implements ProductDetailsEvent {
  const ProductDetailsProductUpdated(this.product);
  

 final  ProductDetail product;

/// Create a copy of ProductDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailsProductUpdatedCopyWith<ProductDetailsProductUpdated> get copyWith => _$ProductDetailsProductUpdatedCopyWithImpl<ProductDetailsProductUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailsProductUpdated&&(identical(other.product, product) || other.product == product));
}


@override
int get hashCode {
    return Object.hash(runtimeType,product);
}

@override
String toString() {
    return 'ProductDetailsEvent.productUpdated(product: $product)';
}


}

/// @nodoc
abstract mixin class $ProductDetailsProductUpdatedCopyWith<$Res> implements $ProductDetailsEventCopyWith<$Res> {
  factory $ProductDetailsProductUpdatedCopyWith(ProductDetailsProductUpdated value, $Res Function(ProductDetailsProductUpdated) _then) = _$ProductDetailsProductUpdatedCopyWithImpl;
@useResult
$Res call({
 ProductDetail product
});




}
/// @nodoc
class _$ProductDetailsProductUpdatedCopyWithImpl<$Res>
    implements $ProductDetailsProductUpdatedCopyWith<$Res> {
  _$ProductDetailsProductUpdatedCopyWithImpl(this._self, this._then);

  final ProductDetailsProductUpdated _self;
  final $Res Function(ProductDetailsProductUpdated) _then;

/// Create a copy of ProductDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? product = null,}) {
  return _then(ProductDetailsProductUpdated(
null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductDetail,
  ));
}


}

// dart format on
