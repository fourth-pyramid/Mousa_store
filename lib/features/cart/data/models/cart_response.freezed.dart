// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CartResponse {

 bool get success; String? get message; Cart? get cart;
/// Create a copy of CartResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartResponseCopyWith<CartResponse> get copyWith => _$CartResponseCopyWithImpl<CartResponse>(this as CartResponse, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CartResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartResponse&&(identical(other.success, _this.success) || other.success == _this.success)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.cart, _this.cart) || other.cart == _this.cart));
}


@override
int get hashCode {
  final _this = this as CartResponse;
  return Object.hash(runtimeType,_this.success,_this.message,_this.cart);
}

@override
String toString() {
  final _this = this as CartResponse;
  return 'CartResponse(success: ${_this.success}, message: ${_this.message}, cart: ${_this.cart})';
}


}

/// @nodoc
abstract mixin class $CartResponseCopyWith<$Res>  {
  factory $CartResponseCopyWith(CartResponse value, $Res Function(CartResponse) _then) = _$CartResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String? message, Cart? cart
});


$CartCopyWith<$Res>? get cart;

}
/// @nodoc
class _$CartResponseCopyWithImpl<$Res>
    implements $CartResponseCopyWith<$Res> {
  _$CartResponseCopyWithImpl(this._self, this._then);

  final CartResponse _self;
  final $Res Function(CartResponse) _then;

/// Create a copy of CartResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = freezed,Object? cart = freezed,}) {
  return _then(CartResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,cart: freezed == cart ? _self.cart : cart // ignore: cast_nullable_to_non_nullable
as Cart?,
  ));
}
/// Create a copy of CartResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartCopyWith<$Res>? get cart {
    if (_self.cart == null) {
    return null;
  }

  return $CartCopyWith<$Res>(_self.cart!, (value) {
    return _then(_self.copyWith(cart: value));
  });
}
}


/// Adds pattern-matching-related methods to [CartResponse].
extension CartResponsePatterns on CartResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartResponse value)  $default,){
final _that = this;
switch (_that) {
case _CartResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CartResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? message,  Cart? cart)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartResponse() when $default != null:
return $default(_that.success,_that.message,_that.cart);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? message,  Cart? cart)  $default,) {final _that = this;
switch (_that) {
case _CartResponse():
return $default(_that.success,_that.message,_that.cart);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? message,  Cart? cart)?  $default,) {final _that = this;
switch (_that) {
case _CartResponse() when $default != null:
return $default(_that.success,_that.message,_that.cart);case _:
  return null;

}
}

}

/// @nodoc


class _CartResponse implements CartResponse {
  const _CartResponse({required this.success, this.message, this.cart});
  

@override final  bool success;
@override final  String? message;
@override final  Cart? cart;

/// Create a copy of CartResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartResponseCopyWith<_CartResponse> get copyWith => __$CartResponseCopyWithImpl<_CartResponse>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.cart, cart) || other.cart == cart));
}


@override
int get hashCode {
    return Object.hash(runtimeType,success,message,cart);
}

@override
String toString() {
    return 'CartResponse(success: $success, message: $message, cart: $cart)';
}


}

/// @nodoc
abstract mixin class _$CartResponseCopyWith<$Res> implements $CartResponseCopyWith<$Res> {
  factory _$CartResponseCopyWith(_CartResponse value, $Res Function(_CartResponse) _then) = __$CartResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? message, Cart? cart
});


@override $CartCopyWith<$Res>? get cart;

}
/// @nodoc
class __$CartResponseCopyWithImpl<$Res>
    implements _$CartResponseCopyWith<$Res> {
  __$CartResponseCopyWithImpl(this._self, this._then);

  final _CartResponse _self;
  final $Res Function(_CartResponse) _then;

/// Create a copy of CartResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = freezed,Object? cart = freezed,}) {
  return _then(_CartResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,cart: freezed == cart ? _self.cart : cart // ignore: cast_nullable_to_non_nullable
as Cart?,
  ));
}

/// Create a copy of CartResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CartCopyWith<$Res>? get cart {
    if (_self.cart == null) {
    return null;
  }

  return $CartCopyWith<$Res>(_self.cart!, (value) {
    return _then(_self.copyWith(cart: value));
  });
}
}

/// @nodoc
mixin _$Cart {

 int get id; int get userId; double get total; List<CartItem> get items; String? get status; String? get type; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of Cart
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartCopyWith<Cart> get copyWith => _$CartCopyWithImpl<Cart>(this as Cart, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Cart;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Cart&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.total, _this.total) || other.total == _this.total)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.type, _this.type) || other.type == _this.type)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}


@override
int get hashCode {
  final _this = this as Cart;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.total,const DeepCollectionEquality().hash(_this.items),_this.status,_this.type,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as Cart;
  return 'Cart(id: ${_this.id}, userId: ${_this.userId}, total: ${_this.total}, items: ${_this.items}, status: ${_this.status}, type: ${_this.type}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $CartCopyWith<$Res>  {
  factory $CartCopyWith(Cart value, $Res Function(Cart) _then) = _$CartCopyWithImpl;
@useResult
$Res call({
 int id, int userId, double total, List<CartItem> items, String? status, String? type, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$CartCopyWithImpl<$Res>
    implements $CartCopyWith<$Res> {
  _$CartCopyWithImpl(this._self, this._then);

  final Cart _self;
  final $Res Function(Cart) _then;

/// Create a copy of Cart
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? total = null,Object? items = null,Object? status = freezed,Object? type = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(Cart(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Cart].
extension CartPatterns on Cart {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Cart value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Cart() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Cart value)  $default,){
final _that = this;
switch (_that) {
case _Cart():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Cart value)?  $default,){
final _that = this;
switch (_that) {
case _Cart() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int userId,  double total,  List<CartItem> items,  String? status,  String? type,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Cart() when $default != null:
return $default(_that.id,_that.userId,_that.total,_that.items,_that.status,_that.type,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int userId,  double total,  List<CartItem> items,  String? status,  String? type,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Cart():
return $default(_that.id,_that.userId,_that.total,_that.items,_that.status,_that.type,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int userId,  double total,  List<CartItem> items,  String? status,  String? type,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Cart() when $default != null:
return $default(_that.id,_that.userId,_that.total,_that.items,_that.status,_that.type,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _Cart implements Cart {
  const _Cart({required this.id, required this.userId, required this.total, required  List<CartItem> items, this.status, this.type, this.createdAt, this.updatedAt}): _items = items;
  

@override final  int id;
@override final  int userId;
@override final  double total;
 final  List<CartItem> _items;
@override List<CartItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  String? status;
@override final  String? type;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of Cart
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartCopyWith<_Cart> get copyWith => __$CartCopyWithImpl<_Cart>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Cart&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.status, status) || other.status == status)&&(identical(other.type, type) || other.type == type)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,total,const DeepCollectionEquality().hash(_items),status,type,createdAt,updatedAt);
}

@override
String toString() {
    return 'Cart(id: $id, userId: $userId, total: $total, items: $items, status: $status, type: $type, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CartCopyWith<$Res> implements $CartCopyWith<$Res> {
  factory _$CartCopyWith(_Cart value, $Res Function(_Cart) _then) = __$CartCopyWithImpl;
@override @useResult
$Res call({
 int id, int userId, double total, List<CartItem> items, String? status, String? type, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$CartCopyWithImpl<$Res>
    implements _$CartCopyWith<$Res> {
  __$CartCopyWithImpl(this._self, this._then);

  final _Cart _self;
  final $Res Function(_Cart) _then;

/// Create a copy of Cart
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? total = null,Object? items = null,Object? status = freezed,Object? type = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Cart(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as double,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CartItem>,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc
mixin _$CartItem {

 int get id; String get name; String get desc; String get price; String get imagePath; List<String> get imagesPath; int get quantity; int? get productId; double? get lineTotal; int? get minQuantity; int? get stock; DateTime? get createdAt; DateTime? get updatedAt; int? get brandId; Brand? get brand; List<Category>? get categories; List<Offer>? get offers; Properties? get properties; Map<String, String>? get itemAttributes;
/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CartItemCopyWith<CartItem> get copyWith => _$CartItemCopyWithImpl<CartItem>(this as CartItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CartItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CartItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.desc, _this.desc) || other.desc == _this.desc)&&(identical(other.price, _this.price) || other.price == _this.price)&&(identical(other.imagePath, _this.imagePath) || other.imagePath == _this.imagePath)&&const DeepCollectionEquality().equals(other.imagesPath, _this.imagesPath)&&(identical(other.quantity, _this.quantity) || other.quantity == _this.quantity)&&(identical(other.productId, _this.productId) || other.productId == _this.productId)&&(identical(other.lineTotal, _this.lineTotal) || other.lineTotal == _this.lineTotal)&&(identical(other.minQuantity, _this.minQuantity) || other.minQuantity == _this.minQuantity)&&(identical(other.stock, _this.stock) || other.stock == _this.stock)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.brandId, _this.brandId) || other.brandId == _this.brandId)&&(identical(other.brand, _this.brand) || other.brand == _this.brand)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&const DeepCollectionEquality().equals(other.offers, _this.offers)&&(identical(other.properties, _this.properties) || other.properties == _this.properties)&&const DeepCollectionEquality().equals(other.itemAttributes, _this.itemAttributes));
}


@override
int get hashCode {
  final _this = this as CartItem;
  return Object.hashAll([runtimeType,_this.id,_this.name,_this.desc,_this.price,_this.imagePath,const DeepCollectionEquality().hash(_this.imagesPath),_this.quantity,_this.productId,_this.lineTotal,_this.minQuantity,_this.stock,_this.createdAt,_this.updatedAt,_this.brandId,_this.brand,const DeepCollectionEquality().hash(_this.categories),const DeepCollectionEquality().hash(_this.offers),_this.properties,const DeepCollectionEquality().hash(_this.itemAttributes)]);
}

@override
String toString() {
  final _this = this as CartItem;
  return 'CartItem(id: ${_this.id}, name: ${_this.name}, desc: ${_this.desc}, price: ${_this.price}, imagePath: ${_this.imagePath}, imagesPath: ${_this.imagesPath}, quantity: ${_this.quantity}, productId: ${_this.productId}, lineTotal: ${_this.lineTotal}, minQuantity: ${_this.minQuantity}, stock: ${_this.stock}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, brandId: ${_this.brandId}, brand: ${_this.brand}, categories: ${_this.categories}, offers: ${_this.offers}, properties: ${_this.properties}, itemAttributes: ${_this.itemAttributes})';
}


}

/// @nodoc
abstract mixin class $CartItemCopyWith<$Res>  {
  factory $CartItemCopyWith(CartItem value, $Res Function(CartItem) _then) = _$CartItemCopyWithImpl;
@useResult
$Res call({
 int id, String name, String desc, String price, String imagePath, List<String> imagesPath, int quantity, int? productId, double? lineTotal, int? minQuantity, int? stock, DateTime? createdAt, DateTime? updatedAt, int? brandId, Brand? brand, List<Category>? categories, List<Offer>? offers, Properties? properties, Map<String, String>? itemAttributes
});


$BrandCopyWith<$Res>? get brand;$PropertiesCopyWith<$Res>? get properties;

}
/// @nodoc
class _$CartItemCopyWithImpl<$Res>
    implements $CartItemCopyWith<$Res> {
  _$CartItemCopyWithImpl(this._self, this._then);

  final CartItem _self;
  final $Res Function(CartItem) _then;

/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? desc = null,Object? price = null,Object? imagePath = null,Object? imagesPath = null,Object? quantity = null,Object? productId = freezed,Object? lineTotal = freezed,Object? minQuantity = freezed,Object? stock = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? brandId = freezed,Object? brand = freezed,Object? categories = freezed,Object? offers = freezed,Object? properties = freezed,Object? itemAttributes = freezed,}) {
  return _then(CartItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,imagesPath: null == imagesPath ? _self.imagesPath : imagesPath // ignore: cast_nullable_to_non_nullable
as List<String>,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int?,lineTotal: freezed == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as double?,minQuantity: freezed == minQuantity ? _self.minQuantity : minQuantity // ignore: cast_nullable_to_non_nullable
as int?,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,brandId: freezed == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as int?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as Brand?,categories: freezed == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>?,offers: freezed == offers ? _self.offers : offers // ignore: cast_nullable_to_non_nullable
as List<Offer>?,properties: freezed == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as Properties?,itemAttributes: freezed == itemAttributes ? _self.itemAttributes : itemAttributes // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}
/// Create a copy of CartItem
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
}/// Create a copy of CartItem
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


/// Adds pattern-matching-related methods to [CartItem].
extension CartItemPatterns on CartItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CartItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CartItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CartItem value)  $default,){
final _that = this;
switch (_that) {
case _CartItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CartItem value)?  $default,){
final _that = this;
switch (_that) {
case _CartItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String desc,  String price,  String imagePath,  List<String> imagesPath,  int quantity,  int? productId,  double? lineTotal,  int? minQuantity,  int? stock,  DateTime? createdAt,  DateTime? updatedAt,  int? brandId,  Brand? brand,  List<Category>? categories,  List<Offer>? offers,  Properties? properties,  Map<String, String>? itemAttributes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CartItem() when $default != null:
return $default(_that.id,_that.name,_that.desc,_that.price,_that.imagePath,_that.imagesPath,_that.quantity,_that.productId,_that.lineTotal,_that.minQuantity,_that.stock,_that.createdAt,_that.updatedAt,_that.brandId,_that.brand,_that.categories,_that.offers,_that.properties,_that.itemAttributes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String desc,  String price,  String imagePath,  List<String> imagesPath,  int quantity,  int? productId,  double? lineTotal,  int? minQuantity,  int? stock,  DateTime? createdAt,  DateTime? updatedAt,  int? brandId,  Brand? brand,  List<Category>? categories,  List<Offer>? offers,  Properties? properties,  Map<String, String>? itemAttributes)  $default,) {final _that = this;
switch (_that) {
case _CartItem():
return $default(_that.id,_that.name,_that.desc,_that.price,_that.imagePath,_that.imagesPath,_that.quantity,_that.productId,_that.lineTotal,_that.minQuantity,_that.stock,_that.createdAt,_that.updatedAt,_that.brandId,_that.brand,_that.categories,_that.offers,_that.properties,_that.itemAttributes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String desc,  String price,  String imagePath,  List<String> imagesPath,  int quantity,  int? productId,  double? lineTotal,  int? minQuantity,  int? stock,  DateTime? createdAt,  DateTime? updatedAt,  int? brandId,  Brand? brand,  List<Category>? categories,  List<Offer>? offers,  Properties? properties,  Map<String, String>? itemAttributes)?  $default,) {final _that = this;
switch (_that) {
case _CartItem() when $default != null:
return $default(_that.id,_that.name,_that.desc,_that.price,_that.imagePath,_that.imagesPath,_that.quantity,_that.productId,_that.lineTotal,_that.minQuantity,_that.stock,_that.createdAt,_that.updatedAt,_that.brandId,_that.brand,_that.categories,_that.offers,_that.properties,_that.itemAttributes);case _:
  return null;

}
}

}

/// @nodoc


class _CartItem extends CartItem {
  const _CartItem({required this.id, required this.name, required this.desc, required this.price, required this.imagePath, required  List<String> imagesPath, required this.quantity, this.productId, this.lineTotal, this.minQuantity, this.stock, this.createdAt, this.updatedAt, this.brandId, this.brand,  List<Category>? categories,  List<Offer>? offers, this.properties,  Map<String, String>? itemAttributes}): _imagesPath = imagesPath,_categories = categories,_offers = offers,_itemAttributes = itemAttributes,super._();
  

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

@override final  int quantity;
@override final  int? productId;
@override final  double? lineTotal;
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
 final  Map<String, String>? _itemAttributes;
@override Map<String, String>? get itemAttributes {
  final value = _itemAttributes;
  if (value == null) return null;
  if (_itemAttributes is EqualUnmodifiableMapView) return _itemAttributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CartItemCopyWith<_CartItem> get copyWith => __$CartItemCopyWithImpl<_CartItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CartItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.desc, desc) || other.desc == desc)&&(identical(other.price, price) || other.price == price)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&const DeepCollectionEquality().equals(other.imagesPath, _imagesPath)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.lineTotal, lineTotal) || other.lineTotal == lineTotal)&&(identical(other.minQuantity, minQuantity) || other.minQuantity == minQuantity)&&(identical(other.stock, stock) || other.stock == stock)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.brandId, brandId) || other.brandId == brandId)&&(identical(other.brand, brand) || other.brand == brand)&&const DeepCollectionEquality().equals(other.categories, _categories)&&const DeepCollectionEquality().equals(other.offers, _offers)&&(identical(other.properties, properties) || other.properties == properties)&&const DeepCollectionEquality().equals(other.itemAttributes, _itemAttributes));
}


@override
int get hashCode {
    return Object.hashAll([runtimeType,id,name,desc,price,imagePath,const DeepCollectionEquality().hash(_imagesPath),quantity,productId,lineTotal,minQuantity,stock,createdAt,updatedAt,brandId,brand,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_offers),properties,const DeepCollectionEquality().hash(_itemAttributes)]);
}

@override
String toString() {
    return 'CartItem(id: $id, name: $name, desc: $desc, price: $price, imagePath: $imagePath, imagesPath: $imagesPath, quantity: $quantity, productId: $productId, lineTotal: $lineTotal, minQuantity: $minQuantity, stock: $stock, createdAt: $createdAt, updatedAt: $updatedAt, brandId: $brandId, brand: $brand, categories: $categories, offers: $offers, properties: $properties, itemAttributes: $itemAttributes)';
}


}

/// @nodoc
abstract mixin class _$CartItemCopyWith<$Res> implements $CartItemCopyWith<$Res> {
  factory _$CartItemCopyWith(_CartItem value, $Res Function(_CartItem) _then) = __$CartItemCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String desc, String price, String imagePath, List<String> imagesPath, int quantity, int? productId, double? lineTotal, int? minQuantity, int? stock, DateTime? createdAt, DateTime? updatedAt, int? brandId, Brand? brand, List<Category>? categories, List<Offer>? offers, Properties? properties, Map<String, String>? itemAttributes
});


@override $BrandCopyWith<$Res>? get brand;@override $PropertiesCopyWith<$Res>? get properties;

}
/// @nodoc
class __$CartItemCopyWithImpl<$Res>
    implements _$CartItemCopyWith<$Res> {
  __$CartItemCopyWithImpl(this._self, this._then);

  final _CartItem _self;
  final $Res Function(_CartItem) _then;

/// Create a copy of CartItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? desc = null,Object? price = null,Object? imagePath = null,Object? imagesPath = null,Object? quantity = null,Object? productId = freezed,Object? lineTotal = freezed,Object? minQuantity = freezed,Object? stock = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? brandId = freezed,Object? brand = freezed,Object? categories = freezed,Object? offers = freezed,Object? properties = freezed,Object? itemAttributes = freezed,}) {
  return _then(_CartItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,desc: null == desc ? _self.desc : desc // ignore: cast_nullable_to_non_nullable
as String,price: null == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as String,imagePath: null == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String,imagesPath: null == imagesPath ? _self._imagesPath : imagesPath // ignore: cast_nullable_to_non_nullable
as List<String>,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,productId: freezed == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int?,lineTotal: freezed == lineTotal ? _self.lineTotal : lineTotal // ignore: cast_nullable_to_non_nullable
as double?,minQuantity: freezed == minQuantity ? _self.minQuantity : minQuantity // ignore: cast_nullable_to_non_nullable
as int?,stock: freezed == stock ? _self.stock : stock // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,brandId: freezed == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as int?,brand: freezed == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as Brand?,categories: freezed == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>?,offers: freezed == offers ? _self._offers : offers // ignore: cast_nullable_to_non_nullable
as List<Offer>?,properties: freezed == properties ? _self.properties : properties // ignore: cast_nullable_to_non_nullable
as Properties?,itemAttributes: freezed == itemAttributes ? _self._itemAttributes : itemAttributes // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,
  ));
}

/// Create a copy of CartItem
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
}/// Create a copy of CartItem
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

// dart format on
