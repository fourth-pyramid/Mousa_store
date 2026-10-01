// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Product {

 int get id; String get name; String get desc; String get price; String get imagePath; List<String> get imagesPath; int? get minQuantity; int? get stock; DateTime? get createdAt; DateTime? get updatedAt; int? get brandId; Brand? get brand; List<Category>? get categories; List<Offer>? get offers; Properties? get properties; List<Variant>? get variants;
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductCopyWith<Product> get copyWith => _$ProductCopyWithImpl<Product>(this as Product, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Product;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Product&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.desc, _this.desc) || other.desc == _this.desc)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.imagePath, _this.imagePath) || other.imagePath == _this.imagePath)&&const DeepCollectionEquality().equals(other.imagesPath, _this.imagesPath)&&(identical(other.minQuantity, _this.minQuantity) || other.minQuantity == _this.minQuantity)&&(identical(other.stock, _this.stock) || other.stock == _this.stock)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.brandId, _this.brandId) || other.brandId == _this.brandId)&&(identical(other.brand, _this.brand) || other.brand == _this.brand)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.offers, _this.offers)&&(identical(other.properties, _this.properties) || other.properties == _this.properties)&&const DeepCollectionEquality().equals(other.variants, _this.variants));
}


@override
int get hashCode {
  final _this = this as Product;
  return Object.hash(runtimeType,_this.id,_this.name,_this.desc,_this.price,_this.imagePath,const DeepCollectionEquality().hash(_this.imagesPath),_this.minQuantity,_this.stock,_this.createdAt,_this.updatedAt,_this.brandId,_this.brand,const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.offers),_this.properties,const DeepCollectionEquality().hash(_this.variants));
}

@override
String toString() {
  final _this = this as Product;
  return 'Product(id: ${_this.id}, name: ${_this.name}, desc: ${_this.desc}, price: ${_this.price}, imagePath: ${_this.imagePath}, imagesPath: ${_this.imagesPath}, minQuantity: ${_this.minQuantity}, stock: ${_this.stock}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, brandId: ${_this.brandId}, brand: ${_this.brand}, categories: ${_this.categories}, offers: ${_this.offers}, properties: ${_this.properties}, variants: ${_this.variants})';
}


}

/// @nodoc
abstract mixin class $ProductCopyWith<$Res>  {
  factory $ProductCopyWith(Product value, $Res Function(Product) _then) = _$ProductCopyWithImpl;
@useResult
$Res call({
 int id, String name, String desc, String price, String imagePath, List<String> imagesPath, int? minQuantity, int? stock, DateTime? createdAt, DateTime? updatedAt, int? brandId, Brand? brand, List<Category>? categories, List<Offer>? offers, Properties? properties, List<Variant>? variants
});


$BrandCopyWith<$Res>? get brand;$PropertiesCopyWith<$Res>? get properties;

}
/// @nodoc
class _$ProductCopyWithImpl<$Res>
    implements $ProductCopyWith<$Res> {
  _$ProductCopyWithImpl(this._self, this._then);

  final Product _self;
  final $Res Function(Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? desc = null,Object? price = null,Object? imagePath = null,Object? imagesPath = null,Object? minQuantity = freezed,Object? stock = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? brandId = freezed,Object? brand = freezed,Object? categories = freezed,Object? offers = freezed,Object? properties = freezed,Object? variants = freezed,}) {
  return _then(Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,imagesPath: null == imagesPath ? _self.imagesPath : imagesPath // ignore: cast_nullable_to_non_nullable
as List<String>,minQuantity: freezed == minQuantity ? _self.minQuantity : minQuantity // ignore: cast_nullable_to_non_nullable
as int?,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,brandId: freezed == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as int?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as Brand?,categories: freezed == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>?,offers: freezed == offers ? _self.offers : offers // ignore: cast_nullable_to_non_nullable
as List<Offer>?,properties: freezed == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as Properties?,variants: freezed == variants ? _self.variants : variants // ignore: cast_nullable_to_non_nullable
as List<Variant>?,
  ));
}
/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BrandCopyWith<$Res>? get brand {
    if (_self.brand == null) {
    return null;
  }

  return $BrandCopyWith<$Res>(_self.brand!, (value) {
    return _then(_self.copyWith(brand: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PropertiesCopyWith<$Res>? get properties {
    if (_self.properties == null) {
    return null;
  }

  return $PropertiesCopyWith<$Res>(_self.properties!, (value) {
    return _then(_self.copyWith(properties: value));
  });
}
}


/// Adds pattern-matching-related methods to [Product].
extension ProductPatterns on Product {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Product value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Product value)  $default,){
final _that = this;
switch (_that) {
case _Product():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Product value)?  $default,){
final _that = this;
switch (_that) {
case _Product() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String desc,  String price,  String imagePath,  List<String> imagesPath,  int? minQuantity,  int? stock,  DateTime? createdAt,  DateTime? updatedAt,  int? brandId,  Brand? brand,  List<Category>? categories,  List<Offer>? offers,  Properties? properties,  List<Variant>? variants)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.name,_that.desc,_that.price,_that.imagePath,_that.imagesPath,_that.minQuantity,_that.stock,_that.createdAt,_that.updatedAt,_that.brandId,_that.brand,_that.categories,_that.offers,_that.properties,_that.variants);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String desc,  String price,  String imagePath,  List<String> imagesPath,  int? minQuantity,  int? stock,  DateTime? createdAt,  DateTime? updatedAt,  int? brandId,  Brand? brand,  List<Category>? categories,  List<Offer>? offers,  Properties? properties,  List<Variant>? variants)  $default,) {final _that = this;
switch (_that) {
case _Product():
return $default(_that.id,_that.name,_that.desc,_that.price,_that.imagePath,_that.imagesPath,_that.minQuantity,_that.stock,_that.createdAt,_that.updatedAt,_that.brandId,_that.brand,_that.categories,_that.offers,_that.properties,_that.variants);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String desc,  String price,  String imagePath,  List<String> imagesPath,  int? minQuantity,  int? stock,  DateTime? createdAt,  DateTime? updatedAt,  int? brandId,  Brand? brand,  List<Category>? categories,  List<Offer>? offers,  Properties? properties,  List<Variant>? variants)?  $default,) {final _that = this;
switch (_that) {
case _Product() when $default != null:
return $default(_that.id,_that.name,_that.desc,_that.price,_that.imagePath,_that.imagesPath,_that.minQuantity,_that.stock,_that.createdAt,_that.updatedAt,_that.brandId,_that.brand,_that.categories,_that.offers,_that.properties,_that.variants);case _:
  return null;

}
}

}

/// @nodoc


class _Product extends Product {
  const _Product({required this.id, required this.name, required this.desc, required this.price, required this.imagePath, required  List<String> imagesPath, this.minQuantity, this.stock, this.createdAt, this.updatedAt, this.brandId, this.brand,  List<Category>? categories,  List<Offer>? offers, this.properties,  List<Variant>? variants}): _imagesPath = imagesPath,_categories = categories,_offers = offers,_variants = variants,super._();
  

@override final  int id;
@override final  String name;
@override final  String desc;
@override final  String price;
@override final  String imagePath;
 final  List<String> _imagesPath;
@override List<String> get imagesPath {
  if (_imagesPath is EqualUnmodifiableListView) return _imagesPath;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imagesPath);
}

@override final  int? minQuantity;
@override final  int? stock;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  int? brandId;
@override final  Brand? brand;
 final  List<Category>? _categories;
@override List<Category>? get categories {
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

@override final  Properties? properties;
 final  List<Variant>? _variants;
@override List<Variant>? get variants {
  final value = _variants;
  if (value == null) return null;
  if (_variants is EqualUnmodifiableListView) return _variants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductCopyWith<_Product> get copyWith => __$ProductCopyWithImpl<_Product>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Product&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.price, price) || other.price == price)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&const DeepCollectionEquality().equals(other.imagesPath, _imagesPath)&&(identical(other.minQuantity, minQuantity) || other.minQuantity == minQuantity)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.brand, brand) || other.brand == brand)&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.offers, _offers)&&(identical(other.properties, properties) || other.properties == properties)&&const DeepCollectionEquality().equals(other.variants, _variants));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,name,desc,price,imagePath,const DeepCollectionEquality().hash(_imagesPath),minQuantity,stock,createdAt,updatedAt,brandId,brand,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_offers),properties,const DeepCollectionEquality().hash(_variants));
}

@override
String toString() {
    return 'Product(id: $id, name: $name, desc: $desc, price: $price, imagePath: $imagePath, imagesPath: $imagesPath, minQuantity: $minQuantity, stock: $stock, createdAt: $createdAt, updatedAt: $updatedAt, brandId: $brandId, brand: $brand, categories: $categories, offers: $offers, properties: $properties, variants: $variants)';
}


}

/// @nodoc
abstract mixin class _$ProductCopyWith<$Res> implements $ProductCopyWith<$Res> {
  factory _$ProductCopyWith(_Product value, $Res Function(_Product) _then) = __$ProductCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String desc, String price, String imagePath, List<String> imagesPath, int? minQuantity, int? stock, DateTime? createdAt, DateTime? updatedAt, int? brandId, Brand? brand, List<Category>? categories, List<Offer>? offers, Properties? properties, List<Variant>? variants
});


@override $BrandCopyWith<$Res>? get brand;@override $PropertiesCopyWith<$Res>? get properties;

}
/// @nodoc
class __$ProductCopyWithImpl<$Res>
    implements _$ProductCopyWith<$Res> {
  __$ProductCopyWithImpl(this._self, this._then);

  final _Product _self;
  final $Res Function(_Product) _then;

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? desc = null,Object? price = null,Object? imagePath = null,Object? imagesPath = null,Object? minQuantity = freezed,Object? stock = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? brandId = freezed,Object? brand = freezed,Object? categories = freezed,Object? offers = freezed,Object? properties = freezed,Object? variants = freezed,}) {
  return _then(_Product(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,imagesPath: null == imagesPath ? _self._imagesPath : imagesPath // ignore: cast_nullable_to_non_nullable
as List<String>,minQuantity: freezed == minQuantity ? _self.minQuantity : minQuantity // ignore: cast_nullable_to_non_nullable
as int?,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,brandId: freezed == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as int?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as Brand?,categories: freezed == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>?,offers: freezed == offers ? _self._offers : offers // ignore: cast_nullable_to_non_nullable
as List<Offer>?,properties: freezed == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as Properties?,variants: freezed == variants ? _self._variants : variants // ignore: cast_nullable_to_non_nullable
as List<Variant>?,
  ));
}

/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BrandCopyWith<$Res>? get brand {
    if (_self.brand == null) {
    return null;
  }

  return $BrandCopyWith<$Res>(_self.brand!, (value) {
    return _then(_self.copyWith(brand: value));
  });
}/// Create a copy of Product
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PropertiesCopyWith<$Res>? get properties {
    if (_self.properties == null) {
    return null;
  }

  return $PropertiesCopyWith<$Res>(_self.properties!, (value) {
    return _then(_self.copyWith(properties: value));
  });
}
}

/// @nodoc
mixin _$Variant {

 int get id; String get price; int get stock; String get imagePath; List<String> get imagesPath; Map<String, String>? get attributes; List<Offer>? get offers;
/// Create a copy of Variant
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VariantCopyWith<Variant> get copyWith => _$VariantCopyWithImpl<Variant>(this as Variant, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Variant;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Variant&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.stock, _this.stock) || other.stock == _this.stock)&&(identical(other.imagePath, _this.imagePath) || other.imagePath == _this.imagePath)&&const DeepCollectionEquality().equals(other.imagesPath, _this.imagesPath)&&const DeepCollectionEquality().equals(other.attributes, _this.attributes)&&const DeepCollectionEquality().equals(other.offers, _this.offers));
}


@override
int get hashCode {
  final _this = this as Variant;
  return Object.hash(runtimeType,_this.id,_this.price,_this.stock,_this.imagePath,const DeepCollectionEquality().hash(_this.imagesPath),const DeepCollectionEquality().hash(_this.attributes),const DeepCollectionEquality().hash(_this.offers));
}

@override
String toString() {
  final _this = this as Variant;
  return 'Variant(id: ${_this.id}, price: ${_this.price}, stock: ${_this.stock}, imagePath: ${_this.imagePath}, imagesPath: ${_this.imagesPath}, attributes: ${_this.attributes}, offers: ${_this.offers})';
}


}

/// @nodoc
abstract mixin class $VariantCopyWith<$Res>  {
  factory $VariantCopyWith(Variant value, $Res Function(Variant) _then) = _$VariantCopyWithImpl;
@useResult
$Res call({
 int id, String price, int stock, String imagePath, List<String> imagesPath, Map<String, String>? attributes, List<Offer>? offers
});




}
/// @nodoc
class _$VariantCopyWithImpl<$Res>
    implements $VariantCopyWith<$Res> {
  _$VariantCopyWithImpl(this._self, this._then);

  final Variant _self;
  final $Res Function(Variant) _then;

/// Create a copy of Variant
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? price = null,Object? stock = null,Object? imagePath = null,Object? imagesPath = null,Object? attributes = freezed,Object? offers = freezed,}) {
  return _then(Variant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,imagesPath: null == imagesPath ? _self.imagesPath : imagesPath // ignore: cast_nullable_to_non_nullable
as List<String>,attributes: freezed == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,offers: freezed == offers ? _self.offers : offers // ignore: cast_nullable_to_non_nullable
as List<Offer>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Variant].
extension VariantPatterns on Variant {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Variant value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Variant() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Variant value)  $default,){
final _that = this;
switch (_that) {
case _Variant():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Variant value)?  $default,){
final _that = this;
switch (_that) {
case _Variant() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String price,  int stock,  String imagePath,  List<String> imagesPath,  Map<String, String>? attributes,  List<Offer>? offers)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Variant() when $default != null:
return $default(_that.id,_that.price,_that.stock,_that.imagePath,_that.imagesPath,_that.attributes,_that.offers);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String price,  int stock,  String imagePath,  List<String> imagesPath,  Map<String, String>? attributes,  List<Offer>? offers)  $default,) {final _that = this;
switch (_that) {
case _Variant():
return $default(_that.id,_that.price,_that.stock,_that.imagePath,_that.imagesPath,_that.attributes,_that.offers);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String price,  int stock,  String imagePath,  List<String> imagesPath,  Map<String, String>? attributes,  List<Offer>? offers)?  $default,) {final _that = this;
switch (_that) {
case _Variant() when $default != null:
return $default(_that.id,_that.price,_that.stock,_that.imagePath,_that.imagesPath,_that.attributes,_that.offers);case _:
  return null;

}
}

}

/// @nodoc


class _Variant extends Variant {
  const _Variant({required this.id, required this.price, required this.stock, required this.imagePath, required  List<String> imagesPath,  Map<String, String>? attributes,  List<Offer>? offers}): _imagesPath = imagesPath,_attributes = attributes,_offers = offers,super._();
  

@override final  int id;
@override final  String price;
@override final  int stock;
@override final  String imagePath;
 final  List<String> _imagesPath;
@override List<String> get imagesPath {
  if (_imagesPath is EqualUnmodifiableListView) return _imagesPath;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imagesPath);
}

 final  Map<String, String>? _attributes;
@override Map<String, String>? get attributes {
  final value = _attributes;
  if (value == null) return null;
  if (_attributes is EqualUnmodifiableMapView) return _attributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<Offer>? _offers;
@override List<Offer>? get offers {
  final value = _offers;
  if (value == null) return null;
  if (_offers is EqualUnmodifiableListView) return _offers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Variant
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VariantCopyWith<_Variant> get copyWith => __$VariantCopyWithImpl<_Variant>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Variant&&(identical(other.id, id) || other.id == id)&&(identical(other.price, price) || other.price == price)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&const DeepCollectionEquality().equals(other.imagesPath, _imagesPath)&&const DeepCollectionEquality().equals(other.attributes, _attributes)&&const DeepCollectionEquality().equals(other.offers, _offers));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,price,stock,imagePath,const DeepCollectionEquality().hash(_imagesPath),const DeepCollectionEquality().hash(_attributes),const DeepCollectionEquality().hash(_offers));
}

@override
String toString() {
    return 'Variant(id: $id, price: $price, stock: $stock, imagePath: $imagePath, imagesPath: $imagesPath, attributes: $attributes, offers: $offers)';
}


}

/// @nodoc
abstract mixin class _$VariantCopyWith<$Res> implements $VariantCopyWith<$Res> {
  factory _$VariantCopyWith(_Variant value, $Res Function(_Variant) _then) = __$VariantCopyWithImpl;
@override @useResult
$Res call({
 int id, String price, int stock, String imagePath, List<String> imagesPath, Map<String, String>? attributes, List<Offer>? offers
});




}
/// @nodoc
class __$VariantCopyWithImpl<$Res>
    implements _$VariantCopyWith<$Res> {
  __$VariantCopyWithImpl(this._self, this._then);

  final _Variant _self;
  final $Res Function(_Variant) _then;

/// Create a copy of Variant
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? price = null,Object? stock = null,Object? imagePath = null,Object? imagesPath = null,Object? attributes = freezed,Object? offers = freezed,}) {
  return _then(_Variant(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,stock: null == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,imagesPath: null == imagesPath ? _self._imagesPath : imagesPath // ignore: cast_nullable_to_non_nullable
as List<String>,attributes: freezed == attributes ? _self._attributes : attributes // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,offers: freezed == offers ? _self._offers : offers // ignore: cast_nullable_to_non_nullable
as List<Offer>?,
  ));
}


}

/// @nodoc
mixin _$Properties {

 List<String> get color;
/// Create a copy of Properties
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PropertiesCopyWith<Properties> get copyWith => _$PropertiesCopyWithImpl<Properties>(this as Properties, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Properties;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Properties&&const DeepCollectionEquality().equals(other.color, _this.color));
}


@override
int get hashCode {
  final _this = this as Properties;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.color));
}

@override
String toString() {
  final _this = this as Properties;
  return 'Properties(color: ${_this.color})';
}


}

/// @nodoc
abstract mixin class $PropertiesCopyWith<$Res>  {
  factory $PropertiesCopyWith(Properties value, $Res Function(Properties) _then) = _$PropertiesCopyWithImpl;
@useResult
$Res call({
 List<String> color
});




}
/// @nodoc
class _$PropertiesCopyWithImpl<$Res>
    implements $PropertiesCopyWith<$Res> {
  _$PropertiesCopyWithImpl(this._self, this._then);

  final Properties _self;
  final $Res Function(Properties) _then;

/// Create a copy of Properties
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? color = null,}) {
  return _then(Properties(
color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Properties].
extension PropertiesPatterns on Properties {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Properties value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Properties() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Properties value)  $default,){
final _that = this;
switch (_that) {
case _Properties():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Properties value)?  $default,){
final _that = this;
switch (_that) {
case _Properties() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Properties() when $default != null:
return $default(_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> color)  $default,) {final _that = this;
switch (_that) {
case _Properties():
return $default(_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> color)?  $default,) {final _that = this;
switch (_that) {
case _Properties() when $default != null:
return $default(_that.color);case _:
  return null;

}
}

}

/// @nodoc


class _Properties extends Properties {
  const _Properties({required  List<String> color}): _color = color,super._();
  

 final  List<String> _color;
@override List<String> get color {
  if (_color is EqualUnmodifiableListView) return _color;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_color);
}


/// Create a copy of Properties
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PropertiesCopyWith<_Properties> get copyWith => __$PropertiesCopyWithImpl<_Properties>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Properties&&const DeepCollectionEquality().equals(other.color, _color));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_color));
}

@override
String toString() {
    return 'Properties(color: $color)';
}


}

/// @nodoc
abstract mixin class _$PropertiesCopyWith<$Res> implements $PropertiesCopyWith<$Res> {
  factory _$PropertiesCopyWith(_Properties value, $Res Function(_Properties) _then) = __$PropertiesCopyWithImpl;
@override @useResult
$Res call({
 List<String> color
});




}
/// @nodoc
class __$PropertiesCopyWithImpl<$Res>
    implements _$PropertiesCopyWith<$Res> {
  __$PropertiesCopyWithImpl(this._self, this._then);

  final _Properties _self;
  final $Res Function(_Properties) _then;

/// Create a copy of Properties
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? color = null,}) {
  return _then(_Properties(
color: null == color ? _self._color : color // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
