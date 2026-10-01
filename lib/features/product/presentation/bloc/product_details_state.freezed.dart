// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductDetailsState {

 ProductDetail get product; Map<String, String> get selectedAttributes; int get selectedQuantity; ProductVariant? get selectedVariant;
/// Create a copy of ProductDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductDetailsStateCopyWith<ProductDetailsState> get copyWith => _$ProductDetailsStateCopyWithImpl<ProductDetailsState>(this as ProductDetailsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProductDetailsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductDetailsState&&(identical(other.product, _this.product) || other.product == _this.product)&&const DeepCollectionEquality().equals(other.selectedAttributes, _this.selectedAttributes)&&(identical(other.selectedQuantity, _this.selectedQuantity) || other.selectedQuantity == _this.selectedQuantity)&&(identical(other.selectedVariant, _this.selectedVariant) || other.selectedVariant == _this.selectedVariant));
}


@override
int get hashCode {
  final _this = this as ProductDetailsState;
  return Object.hash(runtimeType,_this.product,const DeepCollectionEquality().hash(_this.selectedAttributes),_this.selectedQuantity,_this.selectedVariant);
}

@override
String toString() {
  final _this = this as ProductDetailsState;
  return 'ProductDetailsState(product: ${_this.product}, selectedAttributes: ${_this.selectedAttributes}, selectedQuantity: ${_this.selectedQuantity}, selectedVariant: ${_this.selectedVariant})';
}


}

/// @nodoc
abstract mixin class $ProductDetailsStateCopyWith<$Res>  {
  factory $ProductDetailsStateCopyWith(ProductDetailsState value, $Res Function(ProductDetailsState) _then) = _$ProductDetailsStateCopyWithImpl;
@useResult
$Res call({
 ProductDetail product, Map<String, String> selectedAttributes, int selectedQuantity, ProductVariant? selectedVariant
});




}
/// @nodoc
class _$ProductDetailsStateCopyWithImpl<$Res>
    implements $ProductDetailsStateCopyWith<$Res> {
  _$ProductDetailsStateCopyWithImpl(this._self, this._then);

  final ProductDetailsState _self;
  final $Res Function(ProductDetailsState) _then;

/// Create a copy of ProductDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? product = null,Object? selectedAttributes = null,Object? selectedQuantity = null,Object? selectedVariant = freezed,}) {
  return _then(ProductDetailsState(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductDetail,selectedAttributes: null == selectedAttributes ? _self.selectedAttributes : selectedAttributes // ignore: cast_nullable_to_non_nullable
as Map<String, String>,selectedQuantity: null == selectedQuantity ? _self.selectedQuantity : selectedQuantity // ignore: cast_nullable_to_non_nullable
as int,selectedVariant: freezed == selectedVariant ? _self.selectedVariant : selectedVariant // ignore: cast_nullable_to_non_nullable
as ProductVariant?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductDetailsState].
extension ProductDetailsStatePatterns on ProductDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductDetailsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductDetailsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductDetailsState value)  $default,){
final _that = this;
switch (_that) {
case _ProductDetailsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductDetailsState value)?  $default,){
final _that = this;
switch (_that) {
case _ProductDetailsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProductDetail product,  Map<String, String> selectedAttributes,  int selectedQuantity,  ProductVariant? selectedVariant)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductDetailsState() when $default != null:
return $default(_that.product,_that.selectedAttributes,_that.selectedQuantity,_that.selectedVariant);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProductDetail product,  Map<String, String> selectedAttributes,  int selectedQuantity,  ProductVariant? selectedVariant)  $default,) {final _that = this;
switch (_that) {
case _ProductDetailsState():
return $default(_that.product,_that.selectedAttributes,_that.selectedQuantity,_that.selectedVariant);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProductDetail product,  Map<String, String> selectedAttributes,  int selectedQuantity,  ProductVariant? selectedVariant)?  $default,) {final _that = this;
switch (_that) {
case _ProductDetailsState() when $default != null:
return $default(_that.product,_that.selectedAttributes,_that.selectedQuantity,_that.selectedVariant);case _:
  return null;

}
}

}

/// @nodoc


class _ProductDetailsState extends ProductDetailsState {
  const _ProductDetailsState({required this.product,  Map<String, String> selectedAttributes = const <String, String>{}, this.selectedQuantity = 1, this.selectedVariant}): _selectedAttributes = selectedAttributes,super._();
  

@override final  ProductDetail product;
 final  Map<String, String> _selectedAttributes;
@override@JsonKey() Map<String, String> get selectedAttributes {
  if (_selectedAttributes is EqualUnmodifiableMapView) return _selectedAttributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_selectedAttributes);
}

@override@JsonKey() final  int selectedQuantity;
@override final  ProductVariant? selectedVariant;

/// Create a copy of ProductDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductDetailsStateCopyWith<_ProductDetailsState> get copyWith => __$ProductDetailsStateCopyWithImpl<_ProductDetailsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductDetailsState&&(identical(other.product, product) || other.product == product)&&const DeepCollectionEquality().equals(other.selectedAttributes, _selectedAttributes)&&(identical(other.selectedQuantity, selectedQuantity) || other.selectedQuantity == selectedQuantity)&&(identical(other.selectedVariant, selectedVariant) || other.selectedVariant == selectedVariant));
}


@override
int get hashCode {
    return Object.hash(runtimeType,product,const DeepCollectionEquality().hash(_selectedAttributes),selectedQuantity,selectedVariant);
}

@override
String toString() {
    return 'ProductDetailsState(product: $product, selectedAttributes: $selectedAttributes, selectedQuantity: $selectedQuantity, selectedVariant: $selectedVariant)';
}


}

/// @nodoc
abstract mixin class _$ProductDetailsStateCopyWith<$Res> implements $ProductDetailsStateCopyWith<$Res> {
  factory _$ProductDetailsStateCopyWith(_ProductDetailsState value, $Res Function(_ProductDetailsState) _then) = __$ProductDetailsStateCopyWithImpl;
@override @useResult
$Res call({
 ProductDetail product, Map<String, String> selectedAttributes, int selectedQuantity, ProductVariant? selectedVariant
});




}
/// @nodoc
class __$ProductDetailsStateCopyWithImpl<$Res>
    implements _$ProductDetailsStateCopyWith<$Res> {
  __$ProductDetailsStateCopyWithImpl(this._self, this._then);

  final _ProductDetailsState _self;
  final $Res Function(_ProductDetailsState) _then;

/// Create a copy of ProductDetailsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? product = null,Object? selectedAttributes = null,Object? selectedQuantity = null,Object? selectedVariant = freezed,}) {
  return _then(_ProductDetailsState(
product: null == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as ProductDetail,selectedAttributes: null == selectedAttributes ? _self._selectedAttributes : selectedAttributes // ignore: cast_nullable_to_non_nullable
as Map<String, String>,selectedQuantity: null == selectedQuantity ? _self.selectedQuantity : selectedQuantity // ignore: cast_nullable_to_non_nullable
as int,selectedVariant: freezed == selectedVariant ? _self.selectedVariant : selectedVariant // ignore: cast_nullable_to_non_nullable
as ProductVariant?,
  ));
}


}

// dart format on
