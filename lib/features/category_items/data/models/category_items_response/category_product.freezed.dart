// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryProduct {

 int? get id; int? get minQuantity; int? get stock; DateTime? get createdAt; DateTime? get updatedAt; int? get brandId; String? get name; String? get desc; String? get price; String? get imagePath; List<String>? get imagesPath; Brand? get brand; List<ItemCategory>? get categories; List<Offer>? get offers; List<Variant>? get variants; Map<String, dynamic>? get attributes;
/// Create a copy of CategoryProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryProductCopyWith<CategoryProduct> get copyWith => _$CategoryProductCopyWithImpl<CategoryProduct>(this as CategoryProduct, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CategoryProduct;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryProduct&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.minQuantity, _this.minQuantity) || other.minQuantity == _this.minQuantity)&&(identical(other.stock, _this.stock) || other.stock == _this.stock)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.brandId, _this.brandId) || other.brandId == _this.brandId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.desc, _this.desc) || other.desc == _this.desc)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.imagePath, _this.imagePath) || other.imagePath == _this.imagePath)&&const DeepCollectionEquality().equals(other.imagesPath, _this.imagesPath)&&(identical(other.brand, _this.brand) || other.brand == _this.brand)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.offers, _this.offers)&&const DeepCollectionEquality().equals(other.variants, _this.variants)&&const DeepCollectionEquality().equals(other.attributes, _this.attributes));
}


@override
int get hashCode {
  final _this = this as CategoryProduct;
  return Object.hash(runtimeType,_this.id,_this.minQuantity,_this.stock,_this.createdAt,_this.updatedAt,_this.brandId,_this.name,_this.desc,_this.price,_this.imagePath,const DeepCollectionEquality().hash(_this.imagesPath),_this.brand,const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.offers),const DeepCollectionEquality().hash(_this.variants),const DeepCollectionEquality().hash(_this.attributes));
}

@override
String toString() {
  final _this = this as CategoryProduct;
  return 'CategoryProduct(id: ${_this.id}, minQuantity: ${_this.minQuantity}, stock: ${_this.stock}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, brandId: ${_this.brandId}, name: ${_this.name}, desc: ${_this.desc}, price: ${_this.price}, imagePath: ${_this.imagePath}, imagesPath: ${_this.imagesPath}, brand: ${_this.brand}, categories: ${_this.categories}, offers: ${_this.offers}, variants: ${_this.variants}, attributes: ${_this.attributes})';
}


}

/// @nodoc
abstract mixin class $CategoryProductCopyWith<$Res>  {
  factory $CategoryProductCopyWith(CategoryProduct value, $Res Function(CategoryProduct) _then) = _$CategoryProductCopyWithImpl;
@useResult
$Res call({
 int? id, int? minQuantity, int? stock, DateTime? createdAt, DateTime? updatedAt, int? brandId, String? name, String? desc, String? price, String? imagePath, List<String>? imagesPath, Brand? brand, List<ItemCategory>? categories, List<Offer>? offers, List<Variant>? variants, Map<String, dynamic>? attributes
});




}
/// @nodoc
class _$CategoryProductCopyWithImpl<$Res>
    implements $CategoryProductCopyWith<$Res> {
  _$CategoryProductCopyWithImpl(this._self, this._then);

  final CategoryProduct _self;
  final $Res Function(CategoryProduct) _then;

/// Create a copy of CategoryProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? minQuantity = freezed,Object? stock = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? brandId = freezed,Object? name = freezed,Object? desc = freezed,Object? price = freezed,Object? imagePath = freezed,Object? imagesPath = freezed,Object? brand = freezed,Object? categories = freezed,Object? offers = freezed,Object? variants = freezed,Object? attributes = freezed,}) {
  return _then(CategoryProduct(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,minQuantity: freezed == minQuantity ? _self.minQuantity : minQuantity // ignore: cast_nullable_to_non_nullable
as int?,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,brandId: freezed == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,imagesPath: freezed == imagesPath ? _self.imagesPath : imagesPath // ignore: cast_nullable_to_non_nullable
as List<String>?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as Brand?,categories: freezed == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<ItemCategory>?,offers: freezed == offers ? _self.offers : offers // ignore: cast_nullable_to_non_nullable
as List<Offer>?,variants: freezed == variants ? _self.variants : variants // ignore: cast_nullable_to_non_nullable
as List<Variant>?,attributes: freezed == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryProduct].
extension CategoryProductPatterns on CategoryProduct {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryProduct() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryProduct value)  $default,){
final _that = this;
switch (_that) {
case _CategoryProduct():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryProduct value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryProduct() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  int? minQuantity,  int? stock,  DateTime? createdAt,  DateTime? updatedAt,  int? brandId,  String? name,  String? desc,  String? price,  String? imagePath,  List<String>? imagesPath,  Brand? brand,  List<ItemCategory>? categories,  List<Offer>? offers,  List<Variant>? variants,  Map<String, dynamic>? attributes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryProduct() when $default != null:
return $default(_that.id,_that.minQuantity,_that.stock,_that.createdAt,_that.updatedAt,_that.brandId,_that.name,_that.desc,_that.price,_that.imagePath,_that.imagesPath,_that.brand,_that.categories,_that.offers,_that.variants,_that.attributes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  int? minQuantity,  int? stock,  DateTime? createdAt,  DateTime? updatedAt,  int? brandId,  String? name,  String? desc,  String? price,  String? imagePath,  List<String>? imagesPath,  Brand? brand,  List<ItemCategory>? categories,  List<Offer>? offers,  List<Variant>? variants,  Map<String, dynamic>? attributes)  $default,) {final _that = this;
switch (_that) {
case _CategoryProduct():
return $default(_that.id,_that.minQuantity,_that.stock,_that.createdAt,_that.updatedAt,_that.brandId,_that.name,_that.desc,_that.price,_that.imagePath,_that.imagesPath,_that.brand,_that.categories,_that.offers,_that.variants,_that.attributes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  int? minQuantity,  int? stock,  DateTime? createdAt,  DateTime? updatedAt,  int? brandId,  String? name,  String? desc,  String? price,  String? imagePath,  List<String>? imagesPath,  Brand? brand,  List<ItemCategory>? categories,  List<Offer>? offers,  List<Variant>? variants,  Map<String, dynamic>? attributes)?  $default,) {final _that = this;
switch (_that) {
case _CategoryProduct() when $default != null:
return $default(_that.id,_that.minQuantity,_that.stock,_that.createdAt,_that.updatedAt,_that.brandId,_that.name,_that.desc,_that.price,_that.imagePath,_that.imagesPath,_that.brand,_that.categories,_that.offers,_that.variants,_that.attributes);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryProduct extends CategoryProduct {
  const _CategoryProduct({this.id, this.minQuantity, this.stock, this.createdAt, this.updatedAt, this.brandId, this.name, this.desc, this.price, this.imagePath,  List<String>? imagesPath, this.brand,  List<ItemCategory>? categories,  List<Offer>? offers,  List<Variant>? variants,  Map<String, dynamic>? attributes}): _imagesPath = imagesPath,_categories = categories,_offers = offers,_variants = variants,_attributes = attributes,super._();
  

@override final  int? id;
@override final  int? minQuantity;
@override final  int? stock;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  int? brandId;
@override final  String? name;
@override final  String? desc;
@override final  String? price;
@override final  String? imagePath;
 final  List<String>? _imagesPath;
@override List<String>? get imagesPath {
  final value = _imagesPath;
  if (value == null) return null;
  if (_imagesPath is EqualUnmodifiableListView) return _imagesPath;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  Brand? brand;
 final  List<ItemCategory>? _categories;
@override List<ItemCategory>? get categories {
  final value = _categories;
  if (value == null) return null;
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Offer>? _offers;
@override List<Offer>? get offers {
  final value = _offers;
  if (value == null) return null;
  if (_offers is EqualUnmodifiableListView) return _offers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<Variant>? _variants;
@override List<Variant>? get variants {
  final value = _variants;
  if (value == null) return null;
  if (_variants is EqualUnmodifiableListView) return _variants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  Map<String, dynamic>? _attributes;
@override Map<String, dynamic>? get attributes {
  final value = _attributes;
  if (value == null) return null;
  if (_attributes is EqualUnmodifiableMapView) return _attributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of CategoryProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryProductCopyWith<_CategoryProduct> get copyWith => __$CategoryProductCopyWithImpl<_CategoryProduct>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.minQuantity, minQuantity) || other.minQuantity == minQuantity)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.name, name) || other.name == name)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.price, price) || other.price == price)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&const DeepCollectionEquality().equals(other.imagesPath, _imagesPath)&&(identical(other.brand, brand) || other.brand == brand)&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.offers, _offers)&&const DeepCollectionEquality().equals(other.variants, _variants)&&const DeepCollectionEquality().equals(other.attributes, _attributes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,minQuantity,stock,createdAt,updatedAt,brandId,name,desc,price,imagePath,const DeepCollectionEquality().hash(_imagesPath),brand,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_offers),const DeepCollectionEquality().hash(_variants),const DeepCollectionEquality().hash(_attributes));
}

@override
String toString() {
    return 'CategoryProduct(id: $id, minQuantity: $minQuantity, stock: $stock, createdAt: $createdAt, updatedAt: $updatedAt, brandId: $brandId, name: $name, desc: $desc, price: $price, imagePath: $imagePath, imagesPath: $imagesPath, brand: $brand, categories: $categories, offers: $offers, variants: $variants, attributes: $attributes)';
}


}

/// @nodoc
abstract mixin class _$CategoryProductCopyWith<$Res> implements $CategoryProductCopyWith<$Res> {
  factory _$CategoryProductCopyWith(_CategoryProduct value, $Res Function(_CategoryProduct) _then) = __$CategoryProductCopyWithImpl;
@override @useResult
$Res call({
 int? id, int? minQuantity, int? stock, DateTime? createdAt, DateTime? updatedAt, int? brandId, String? name, String? desc, String? price, String? imagePath, List<String>? imagesPath, Brand? brand, List<ItemCategory>? categories, List<Offer>? offers, List<Variant>? variants, Map<String, dynamic>? attributes
});




}
/// @nodoc
class __$CategoryProductCopyWithImpl<$Res>
    implements _$CategoryProductCopyWith<$Res> {
  __$CategoryProductCopyWithImpl(this._self, this._then);

  final _CategoryProduct _self;
  final $Res Function(_CategoryProduct) _then;

/// Create a copy of CategoryProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? minQuantity = freezed,Object? stock = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? brandId = freezed,Object? name = freezed,Object? desc = freezed,Object? price = freezed,Object? imagePath = freezed,Object? imagesPath = freezed,Object? brand = freezed,Object? categories = freezed,Object? offers = freezed,Object? variants = freezed,Object? attributes = freezed,}) {
  return _then(_CategoryProduct(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,minQuantity: freezed == minQuantity ? _self.minQuantity : minQuantity // ignore: cast_nullable_to_non_nullable
as int?,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,brandId: freezed == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as int?,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,desc: freezed == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,imagesPath: freezed == imagesPath ? _self._imagesPath : imagesPath // ignore: cast_nullable_to_non_nullable
as List<String>?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as Brand?,categories: freezed == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<ItemCategory>?,offers: freezed == offers ? _self._offers : offers // ignore: cast_nullable_to_non_nullable
as List<Offer>?,variants: freezed == variants ? _self._variants : variants // ignore: cast_nullable_to_non_nullable
as List<Variant>?,attributes: freezed == attributes ? _self._attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
