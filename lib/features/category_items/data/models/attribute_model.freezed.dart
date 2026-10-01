// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attribute_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttributeValue {

 int get id; String get value;
/// Create a copy of AttributeValue
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttributeValueCopyWith<AttributeValue> get copyWith => _$AttributeValueCopyWithImpl<AttributeValue>(this as AttributeValue, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AttributeValue;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttributeValue&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.value, _this.value) || other.value == _this.value));
}


@override
int get hashCode {
  final _this = this as AttributeValue;
  return Object.hash(runtimeType,_this.id,_this.value);
}

@override
String toString() {
  final _this = this as AttributeValue;
  return 'AttributeValue(id: ${_this.id}, value: ${_this.value})';
}


}

/// @nodoc
abstract mixin class $AttributeValueCopyWith<$Res>  {
  factory $AttributeValueCopyWith(AttributeValue value, $Res Function(AttributeValue) _then) = _$AttributeValueCopyWithImpl;
@useResult
$Res call({
 int id, String value
});




}
/// @nodoc
class _$AttributeValueCopyWithImpl<$Res>
    implements $AttributeValueCopyWith<$Res> {
  _$AttributeValueCopyWithImpl(this._self, this._then);

  final AttributeValue _self;
  final $Res Function(AttributeValue) _then;

/// Create a copy of AttributeValue
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? value = null,}) {
  return _then(AttributeValue(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AttributeValue].
extension AttributeValuePatterns on AttributeValue {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttributeValue value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttributeValue() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttributeValue value)  $default,){
final _that = this;
switch (_that) {
case _AttributeValue():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttributeValue value)?  $default,){
final _that = this;
switch (_that) {
case _AttributeValue() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String value)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttributeValue() when $default != null:
return $default(_that.id,_that.value);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String value)  $default,) {final _that = this;
switch (_that) {
case _AttributeValue():
return $default(_that.id,_that.value);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String value)?  $default,) {final _that = this;
switch (_that) {
case _AttributeValue() when $default != null:
return $default(_that.id,_that.value);case _:
  return null;

}
}

}

/// @nodoc


class _AttributeValue extends AttributeValue {
  const _AttributeValue({required this.id, required this.value}): super._();
  

@override final  int id;
@override final  String value;

/// Create a copy of AttributeValue
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttributeValueCopyWith<_AttributeValue> get copyWith => __$AttributeValueCopyWithImpl<_AttributeValue>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttributeValue&&(identical(other.id, id) || other.id == id)&&(identical(other.value, value) || other.value == value));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,value);
}

@override
String toString() {
    return 'AttributeValue(id: $id, value: $value)';
}


}

/// @nodoc
abstract mixin class _$AttributeValueCopyWith<$Res> implements $AttributeValueCopyWith<$Res> {
  factory _$AttributeValueCopyWith(_AttributeValue value, $Res Function(_AttributeValue) _then) = __$AttributeValueCopyWithImpl;
@override @useResult
$Res call({
 int id, String value
});




}
/// @nodoc
class __$AttributeValueCopyWithImpl<$Res>
    implements _$AttributeValueCopyWith<$Res> {
  __$AttributeValueCopyWithImpl(this._self, this._then);

  final _AttributeValue _self;
  final $Res Function(_AttributeValue) _then;

/// Create a copy of AttributeValue
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? value = null,}) {
  return _then(_AttributeValue(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$AttributeResponse {

 bool get success; String get message; AttributeResponseData get data;
/// Create a copy of AttributeResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttributeResponseCopyWith<AttributeResponse> get copyWith => _$AttributeResponseCopyWithImpl<AttributeResponse>(this as AttributeResponse, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AttributeResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttributeResponse&&(identical(other.success, _this.success) || other.success == _this.success)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.data, _this.data) || other.data == _this.data));
}


@override
int get hashCode {
  final _this = this as AttributeResponse;
  return Object.hash(runtimeType,_this.success,_this.message,_this.data);
}

@override
String toString() {
  final _this = this as AttributeResponse;
  return 'AttributeResponse(success: ${_this.success}, message: ${_this.message}, data: ${_this.data})';
}


}

/// @nodoc
abstract mixin class $AttributeResponseCopyWith<$Res>  {
  factory $AttributeResponseCopyWith(AttributeResponse value, $Res Function(AttributeResponse) _then) = _$AttributeResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message, AttributeResponseData data
});


$AttributeResponseDataCopyWith<$Res> get data;

}
/// @nodoc
class _$AttributeResponseCopyWithImpl<$Res>
    implements $AttributeResponseCopyWith<$Res> {
  _$AttributeResponseCopyWithImpl(this._self, this._then);

  final AttributeResponse _self;
  final $Res Function(AttributeResponse) _then;

/// Create a copy of AttributeResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(AttributeResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AttributeResponseData,
  ));
}
/// Create a copy of AttributeResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttributeResponseDataCopyWith<$Res> get data {
  
  return $AttributeResponseDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AttributeResponse].
extension AttributeResponsePatterns on AttributeResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttributeResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttributeResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttributeResponse value)  $default,){
final _that = this;
switch (_that) {
case _AttributeResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttributeResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AttributeResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  AttributeResponseData data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttributeResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  AttributeResponseData data)  $default,) {final _that = this;
switch (_that) {
case _AttributeResponse():
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  AttributeResponseData data)?  $default,) {final _that = this;
switch (_that) {
case _AttributeResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _AttributeResponse extends AttributeResponse {
  const _AttributeResponse({required this.success, required this.message, required this.data}): super._();
  

@override final  bool success;
@override final  String message;
@override final  AttributeResponseData data;

/// Create a copy of AttributeResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttributeResponseCopyWith<_AttributeResponse> get copyWith => __$AttributeResponseCopyWithImpl<_AttributeResponse>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttributeResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode {
    return Object.hash(runtimeType,success,message,data);
}

@override
String toString() {
    return 'AttributeResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$AttributeResponseCopyWith<$Res> implements $AttributeResponseCopyWith<$Res> {
  factory _$AttributeResponseCopyWith(_AttributeResponse value, $Res Function(_AttributeResponse) _then) = __$AttributeResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, AttributeResponseData data
});


@override $AttributeResponseDataCopyWith<$Res> get data;

}
/// @nodoc
class __$AttributeResponseCopyWithImpl<$Res>
    implements _$AttributeResponseCopyWith<$Res> {
  __$AttributeResponseCopyWithImpl(this._self, this._then);

  final _AttributeResponse _self;
  final $Res Function(_AttributeResponse) _then;

/// Create a copy of AttributeResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? data = null,}) {
  return _then(_AttributeResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AttributeResponseData,
  ));
}

/// Create a copy of AttributeResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AttributeResponseDataCopyWith<$Res> get data {
  
  return $AttributeResponseDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}

/// @nodoc
mixin _$AttributeResponseData {

 List<AttributeData> get attributes; List<Brand> get brands; String get minPrice; String get maxPrice;
/// Create a copy of AttributeResponseData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttributeResponseDataCopyWith<AttributeResponseData> get copyWith => _$AttributeResponseDataCopyWithImpl<AttributeResponseData>(this as AttributeResponseData, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AttributeResponseData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttributeResponseData&&const DeepCollectionEquality().equals(other.attributes, _this.attributes)&&const DeepCollectionEquality().equals(other.brands, _this.brands)&&(identical(other.minPrice, _this.minPrice) || other.minPrice == _this.minPrice)&&(identical(other.maxPrice, _this.maxPrice) || other.maxPrice == _this.maxPrice));
}


@override
int get hashCode {
  final _this = this as AttributeResponseData;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.attributes),const DeepCollectionEquality().hash(_this.brands),_this.minPrice,_this.maxPrice);
}

@override
String toString() {
  final _this = this as AttributeResponseData;
  return 'AttributeResponseData(attributes: ${_this.attributes}, brands: ${_this.brands}, minPrice: ${_this.minPrice}, maxPrice: ${_this.maxPrice})';
}


}

/// @nodoc
abstract mixin class $AttributeResponseDataCopyWith<$Res>  {
  factory $AttributeResponseDataCopyWith(AttributeResponseData value, $Res Function(AttributeResponseData) _then) = _$AttributeResponseDataCopyWithImpl;
@useResult
$Res call({
 List<AttributeData> attributes, List<Brand> brands, String minPrice, String maxPrice
});




}
/// @nodoc
class _$AttributeResponseDataCopyWithImpl<$Res>
    implements $AttributeResponseDataCopyWith<$Res> {
  _$AttributeResponseDataCopyWithImpl(this._self, this._then);

  final AttributeResponseData _self;
  final $Res Function(AttributeResponseData) _then;

/// Create a copy of AttributeResponseData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? attributes = null,Object? brands = null,Object? minPrice = null,Object? maxPrice = null,}) {
  return _then(AttributeResponseData(
attributes: null == attributes ? _self.attributes : attributes // ignore: cast_nullable_to_non_nullable
as List<AttributeData>,brands: null == brands ? _self.brands : brands // ignore: cast_nullable_to_non_nullable
as List<Brand>,minPrice: null == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as String,maxPrice: null == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AttributeResponseData].
extension AttributeResponseDataPatterns on AttributeResponseData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttributeResponseData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttributeResponseData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttributeResponseData value)  $default,){
final _that = this;
switch (_that) {
case _AttributeResponseData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttributeResponseData value)?  $default,){
final _that = this;
switch (_that) {
case _AttributeResponseData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AttributeData> attributes,  List<Brand> brands,  String minPrice,  String maxPrice)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttributeResponseData() when $default != null:
return $default(_that.attributes,_that.brands,_that.minPrice,_that.maxPrice);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AttributeData> attributes,  List<Brand> brands,  String minPrice,  String maxPrice)  $default,) {final _that = this;
switch (_that) {
case _AttributeResponseData():
return $default(_that.attributes,_that.brands,_that.minPrice,_that.maxPrice);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AttributeData> attributes,  List<Brand> brands,  String minPrice,  String maxPrice)?  $default,) {final _that = this;
switch (_that) {
case _AttributeResponseData() when $default != null:
return $default(_that.attributes,_that.brands,_that.minPrice,_that.maxPrice);case _:
  return null;

}
}

}

/// @nodoc


class _AttributeResponseData extends AttributeResponseData {
  const _AttributeResponseData({ List<AttributeData> attributes = const [],  List<Brand> brands = const [], this.minPrice = '0', this.maxPrice = '0'}): _attributes = attributes,_brands = brands,super._();
  

 final  List<AttributeData> _attributes;
@override@JsonKey() List<AttributeData> get attributes {
  if (_attributes is EqualUnmodifiableListView) return _attributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_attributes);
}

 final  List<Brand> _brands;
@override@JsonKey() List<Brand> get brands {
  if (_brands is EqualUnmodifiableListView) return _brands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_brands);
}

@override@JsonKey() final  String minPrice;
@override@JsonKey() final  String maxPrice;

/// Create a copy of AttributeResponseData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttributeResponseDataCopyWith<_AttributeResponseData> get copyWith => __$AttributeResponseDataCopyWithImpl<_AttributeResponseData>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttributeResponseData&&const DeepCollectionEquality().equals(other.attributes, _attributes)&&const DeepCollectionEquality().equals(other.brands, _brands)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_attributes),const DeepCollectionEquality().hash(_brands),minPrice,maxPrice);
}

@override
String toString() {
    return 'AttributeResponseData(attributes: $attributes, brands: $brands, minPrice: $minPrice, maxPrice: $maxPrice)';
}


}

/// @nodoc
abstract mixin class _$AttributeResponseDataCopyWith<$Res> implements $AttributeResponseDataCopyWith<$Res> {
  factory _$AttributeResponseDataCopyWith(_AttributeResponseData value, $Res Function(_AttributeResponseData) _then) = __$AttributeResponseDataCopyWithImpl;
@override @useResult
$Res call({
 List<AttributeData> attributes, List<Brand> brands, String minPrice, String maxPrice
});




}
/// @nodoc
class __$AttributeResponseDataCopyWithImpl<$Res>
    implements _$AttributeResponseDataCopyWith<$Res> {
  __$AttributeResponseDataCopyWithImpl(this._self, this._then);

  final _AttributeResponseData _self;
  final $Res Function(_AttributeResponseData) _then;

/// Create a copy of AttributeResponseData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? attributes = null,Object? brands = null,Object? minPrice = null,Object? maxPrice = null,}) {
  return _then(_AttributeResponseData(
attributes: null == attributes ? _self._attributes : attributes // ignore: cast_nullable_to_non_nullable
as List<AttributeData>,brands: null == brands ? _self._brands : brands // ignore: cast_nullable_to_non_nullable
as List<Brand>,minPrice: null == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as String,maxPrice: null == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$AttributeData {

 String get key; List<AttributeValue> get values;
/// Create a copy of AttributeData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttributeDataCopyWith<AttributeData> get copyWith => _$AttributeDataCopyWithImpl<AttributeData>(this as AttributeData, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AttributeData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttributeData&&(identical(other.key, _this.key) || other.key == _this.key)&&const DeepCollectionEquality().equals(other.values, _this.values));
}


@override
int get hashCode {
  final _this = this as AttributeData;
  return Object.hash(runtimeType,_this.key,const DeepCollectionEquality().hash(_this.values));
}

@override
String toString() {
  final _this = this as AttributeData;
  return 'AttributeData(key: ${_this.key}, values: ${_this.values})';
}


}

/// @nodoc
abstract mixin class $AttributeDataCopyWith<$Res>  {
  factory $AttributeDataCopyWith(AttributeData value, $Res Function(AttributeData) _then) = _$AttributeDataCopyWithImpl;
@useResult
$Res call({
 String key, List<AttributeValue> values
});




}
/// @nodoc
class _$AttributeDataCopyWithImpl<$Res>
    implements $AttributeDataCopyWith<$Res> {
  _$AttributeDataCopyWithImpl(this._self, this._then);

  final AttributeData _self;
  final $Res Function(AttributeData) _then;

/// Create a copy of AttributeData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? key = null,Object? values = null,}) {
  return _then(AttributeData(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,values: null == values ? _self.values : values // ignore: cast_nullable_to_non_nullable
as List<AttributeValue>,
  ));
}

}


/// Adds pattern-matching-related methods to [AttributeData].
extension AttributeDataPatterns on AttributeData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttributeData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttributeData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttributeData value)  $default,){
final _that = this;
switch (_that) {
case _AttributeData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttributeData value)?  $default,){
final _that = this;
switch (_that) {
case _AttributeData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String key,  List<AttributeValue> values)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttributeData() when $default != null:
return $default(_that.key,_that.values);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String key,  List<AttributeValue> values)  $default,) {final _that = this;
switch (_that) {
case _AttributeData():
return $default(_that.key,_that.values);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String key,  List<AttributeValue> values)?  $default,) {final _that = this;
switch (_that) {
case _AttributeData() when $default != null:
return $default(_that.key,_that.values);case _:
  return null;

}
}

}

/// @nodoc


class _AttributeData extends AttributeData {
  const _AttributeData({required this.key, required  List<AttributeValue> values}): _values = values,super._();
  

@override final  String key;
 final  List<AttributeValue> _values;
@override List<AttributeValue> get values {
  if (_values is EqualUnmodifiableListView) return _values;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_values);
}


/// Create a copy of AttributeData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttributeDataCopyWith<_AttributeData> get copyWith => __$AttributeDataCopyWithImpl<_AttributeData>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttributeData&&(identical(other.key, key) || other.key == key)&&const DeepCollectionEquality().equals(other.values, _values));
}


@override
int get hashCode {
    return Object.hash(runtimeType,key,const DeepCollectionEquality().hash(_values));
}

@override
String toString() {
    return 'AttributeData(key: $key, values: $values)';
}


}

/// @nodoc
abstract mixin class _$AttributeDataCopyWith<$Res> implements $AttributeDataCopyWith<$Res> {
  factory _$AttributeDataCopyWith(_AttributeData value, $Res Function(_AttributeData) _then) = __$AttributeDataCopyWithImpl;
@override @useResult
$Res call({
 String key, List<AttributeValue> values
});




}
/// @nodoc
class __$AttributeDataCopyWithImpl<$Res>
    implements _$AttributeDataCopyWith<$Res> {
  __$AttributeDataCopyWithImpl(this._self, this._then);

  final _AttributeData _self;
  final $Res Function(_AttributeData) _then;

/// Create a copy of AttributeData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? key = null,Object? values = null,}) {
  return _then(_AttributeData(
key: null == key ? _self.key : key // ignore: cast_nullable_to_non_nullable
as String,values: null == values ? _self._values : values // ignore: cast_nullable_to_non_nullable
as List<AttributeValue>,
  ));
}


}

// dart format on
