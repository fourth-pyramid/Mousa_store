// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductEvent {

 bool get showLoading;
/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductEventCopyWith<ProductEvent> get copyWith => _$ProductEventCopyWithImpl<ProductEvent>(this as ProductEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ProductEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductEvent&&(identical(other.showLoading, _this.showLoading) || other.showLoading == _this.showLoading));
}


@override
int get hashCode {
  final _this = this as ProductEvent;
  return Object.hash(runtimeType,_this.showLoading);
}

@override
String toString() {
  final _this = this as ProductEvent;
  return 'ProductEvent(showLoading: ${_this.showLoading})';
}


}

/// @nodoc
abstract mixin class $ProductEventCopyWith<$Res>  {
  factory $ProductEventCopyWith(ProductEvent value, $Res Function(ProductEvent) _then) = _$ProductEventCopyWithImpl;
@useResult
$Res call({
 bool showLoading
});




}
/// @nodoc
class _$ProductEventCopyWithImpl<$Res>
    implements $ProductEventCopyWith<$Res> {
  _$ProductEventCopyWithImpl(this._self, this._then);

  final ProductEvent _self;
  final $Res Function(ProductEvent) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? showLoading = null,}) {
  return _then(_self.copyWith(
showLoading: null == showLoading ? _self.showLoading : showLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductEvent].
extension ProductEventPatterns on ProductEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProductFetchRequested value)?  fetchRequested,TResult Function( ProductRefreshRequested value)?  refreshRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProductFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case ProductRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProductFetchRequested value)  fetchRequested,required TResult Function( ProductRefreshRequested value)  refreshRequested,}){
final _that = this;
switch (_that) {
case ProductFetchRequested():
return fetchRequested(_that);case ProductRefreshRequested():
return refreshRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProductFetchRequested value)?  fetchRequested,TResult? Function( ProductRefreshRequested value)?  refreshRequested,}){
final _that = this;
switch (_that) {
case ProductFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case ProductRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int productId,  bool showLoading)?  fetchRequested,TResult Function( bool showLoading)?  refreshRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProductFetchRequested() when fetchRequested != null:
return fetchRequested(_that.productId,_that.showLoading);case ProductRefreshRequested() when refreshRequested != null:
return refreshRequested(_that.showLoading);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int productId,  bool showLoading)  fetchRequested,required TResult Function( bool showLoading)  refreshRequested,}) {final _that = this;
switch (_that) {
case ProductFetchRequested():
return fetchRequested(_that.productId,_that.showLoading);case ProductRefreshRequested():
return refreshRequested(_that.showLoading);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int productId,  bool showLoading)?  fetchRequested,TResult? Function( bool showLoading)?  refreshRequested,}) {final _that = this;
switch (_that) {
case ProductFetchRequested() when fetchRequested != null:
return fetchRequested(_that.productId,_that.showLoading);case ProductRefreshRequested() when refreshRequested != null:
return refreshRequested(_that.showLoading);case _:
  return null;

}
}

}

/// @nodoc


class ProductFetchRequested implements ProductEvent {
  const ProductFetchRequested({required this.productId, this.showLoading = true});
  

 final  int productId;
@override@JsonKey() final  bool showLoading;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductFetchRequestedCopyWith<ProductFetchRequested> get copyWith => _$ProductFetchRequestedCopyWithImpl<ProductFetchRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFetchRequested&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.showLoading, showLoading) || other.showLoading == showLoading));
}


@override
int get hashCode {
    return Object.hash(runtimeType,productId,showLoading);
}

@override
String toString() {
    return 'ProductEvent.fetchRequested(productId: $productId, showLoading: $showLoading)';
}


}

/// @nodoc
abstract mixin class $ProductFetchRequestedCopyWith<$Res> implements $ProductEventCopyWith<$Res> {
  factory $ProductFetchRequestedCopyWith(ProductFetchRequested value, $Res Function(ProductFetchRequested) _then) = _$ProductFetchRequestedCopyWithImpl;
@override @useResult
$Res call({
 int productId, bool showLoading
});




}
/// @nodoc
class _$ProductFetchRequestedCopyWithImpl<$Res>
    implements $ProductFetchRequestedCopyWith<$Res> {
  _$ProductFetchRequestedCopyWithImpl(this._self, this._then);

  final ProductFetchRequested _self;
  final $Res Function(ProductFetchRequested) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? showLoading = null,}) {
  return _then(ProductFetchRequested(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,showLoading: null == showLoading ? _self.showLoading : showLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ProductRefreshRequested implements ProductEvent {
  const ProductRefreshRequested({this.showLoading = true});
  

@override@JsonKey() final  bool showLoading;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductRefreshRequestedCopyWith<ProductRefreshRequested> get copyWith => _$ProductRefreshRequestedCopyWithImpl<ProductRefreshRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductRefreshRequested&&(identical(other.showLoading, showLoading) || other.showLoading == showLoading));
}


@override
int get hashCode {
    return Object.hash(runtimeType,showLoading);
}

@override
String toString() {
    return 'ProductEvent.refreshRequested(showLoading: $showLoading)';
}


}

/// @nodoc
abstract mixin class $ProductRefreshRequestedCopyWith<$Res> implements $ProductEventCopyWith<$Res> {
  factory $ProductRefreshRequestedCopyWith(ProductRefreshRequested value, $Res Function(ProductRefreshRequested) _then) = _$ProductRefreshRequestedCopyWithImpl;
@override @useResult
$Res call({
 bool showLoading
});




}
/// @nodoc
class _$ProductRefreshRequestedCopyWithImpl<$Res>
    implements $ProductRefreshRequestedCopyWith<$Res> {
  _$ProductRefreshRequestedCopyWithImpl(this._self, this._then);

  final ProductRefreshRequested _self;
  final $Res Function(ProductRefreshRequested) _then;

/// Create a copy of ProductEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? showLoading = null,}) {
  return _then(ProductRefreshRequested(
showLoading: null == showLoading ? _self.showLoading : showLoading // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
