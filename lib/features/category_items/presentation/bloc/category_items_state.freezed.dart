// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_items_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryItemsState {

 CategoryItemsStatus get status; List<CategoryProduct> get products; List<String> get availableBrands; Map<String, List<String>> get availableAttributes; List<AttributeData> get globalAttributes; List<Brand> get globalBrands; double get minPrice; double get maxPrice; ProductFilter? get activeFilter; ProductSort? get activeSort; String? get errorMessage; int get currentPage; int get lastPage; bool get hasReachedMax; bool get isLoadingMore;
/// Create a copy of CategoryItemsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryItemsStateCopyWith<CategoryItemsState> get copyWith => _$CategoryItemsStateCopyWithImpl<CategoryItemsState>(this as CategoryItemsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CategoryItemsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryItemsState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.products, _this.products)&&const DeepCollectionEquality().equals(other.availableBrands, _this.availableBrands)&&const DeepCollectionEquality().equals(other.availableAttributes, _this.availableAttributes)&&const DeepCollectionEquality().equals(other.globalAttributes, _this.globalAttributes)&&const DeepCollectionEquality().equals(other.globalBrands, _this.globalBrands)&&(identical(other.minPrice, _this.minPrice) || other.minPrice == _this.minPrice)&&(identical(other.maxPrice, _this.maxPrice) || other.maxPrice == _this.maxPrice)&&(identical(other.activeFilter, _this.activeFilter) || other.activeFilter == _this.activeFilter)&&(identical(other.activeSort, _this.activeSort) || other.activeSort == _this.activeSort)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage)&&(identical(other.currentPage, _this.currentPage) || other.currentPage == _this.currentPage)&&(identical(other.lastPage, _this.lastPage) || other.lastPage == _this.lastPage)&&(identical(other.hasReachedMax, _this.hasReachedMax) || other.hasReachedMax == _this.hasReachedMax)&&(identical(other.isLoadingMore, _this.isLoadingMore) || other.isLoadingMore == _this.isLoadingMore));
}


@override
int get hashCode {
  final _this = this as CategoryItemsState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.products),const DeepCollectionEquality().hash(_this.availableBrands),const DeepCollectionEquality().hash(_this.availableAttributes),const DeepCollectionEquality().hash(_this.globalAttributes),const DeepCollectionEquality().hash(_this.globalBrands),_this.minPrice,_this.maxPrice,_this.activeFilter,_this.activeSort,_this.errorMessage,_this.currentPage,_this.lastPage,_this.hasReachedMax,_this.isLoadingMore);
}

@override
String toString() {
  final _this = this as CategoryItemsState;
  return 'CategoryItemsState(status: ${_this.status}, products: ${_this.products}, availableBrands: ${_this.availableBrands}, availableAttributes: ${_this.availableAttributes}, globalAttributes: ${_this.globalAttributes}, globalBrands: ${_this.globalBrands}, minPrice: ${_this.minPrice}, maxPrice: ${_this.maxPrice}, activeFilter: ${_this.activeFilter}, activeSort: ${_this.activeSort}, errorMessage: ${_this.errorMessage}, currentPage: ${_this.currentPage}, lastPage: ${_this.lastPage}, hasReachedMax: ${_this.hasReachedMax}, isLoadingMore: ${_this.isLoadingMore})';
}


}

/// @nodoc
abstract mixin class $CategoryItemsStateCopyWith<$Res>  {
  factory $CategoryItemsStateCopyWith(CategoryItemsState value, $Res Function(CategoryItemsState) _then) = _$CategoryItemsStateCopyWithImpl;
@useResult
$Res call({
 CategoryItemsStatus status, List<CategoryProduct> products, List<String> availableBrands, Map<String, List<String>> availableAttributes, List<AttributeData> globalAttributes, List<Brand> globalBrands, double minPrice, double maxPrice, ProductFilter? activeFilter, ProductSort? activeSort, String? errorMessage, int currentPage, int lastPage, bool hasReachedMax, bool isLoadingMore
});




}
/// @nodoc
class _$CategoryItemsStateCopyWithImpl<$Res>
    implements $CategoryItemsStateCopyWith<$Res> {
  _$CategoryItemsStateCopyWithImpl(this._self, this._then);

  final CategoryItemsState _self;
  final $Res Function(CategoryItemsState) _then;

/// Create a copy of CategoryItemsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? products = null,Object? availableBrands = null,Object? availableAttributes = null,Object? globalAttributes = null,Object? globalBrands = null,Object? minPrice = null,Object? maxPrice = null,Object? activeFilter = freezed,Object? activeSort = freezed,Object? errorMessage = freezed,Object? currentPage = null,Object? lastPage = null,Object? hasReachedMax = null,Object? isLoadingMore = null,}) {
  return _then(CategoryItemsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CategoryItemsStatus,products: null == products ? _self.products : products // ignore: cast_nullable_to_non_nullable
as List<CategoryProduct>,availableBrands: null == availableBrands ? _self.availableBrands : availableBrands // ignore: cast_nullable_to_non_nullable
as List<String>,availableAttributes: null == availableAttributes ? _self.availableAttributes : availableAttributes // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,globalAttributes: null == globalAttributes ? _self.globalAttributes : globalAttributes // ignore: cast_nullable_to_non_nullable
as List<AttributeData>,globalBrands: null == globalBrands ? _self.globalBrands : globalBrands // ignore: cast_nullable_to_non_nullable
as List<Brand>,minPrice: null == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double,maxPrice: null == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double,activeFilter: freezed == activeFilter ? _self.activeFilter : activeFilter // ignore: cast_nullable_to_non_nullable
as ProductFilter?,activeSort: freezed == activeSort ? _self.activeSort : activeSort // ignore: cast_nullable_to_non_nullable
as ProductSort?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,hasReachedMax: null == hasReachedMax ? _self.hasReachedMax : hasReachedMax // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryItemsState].
extension CategoryItemsStatePatterns on CategoryItemsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryItemsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryItemsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryItemsState value)  $default,){
final _that = this;
switch (_that) {
case _CategoryItemsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryItemsState value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryItemsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CategoryItemsStatus status,  List<CategoryProduct> products,  List<String> availableBrands,  Map<String, List<String>> availableAttributes,  List<AttributeData> globalAttributes,  List<Brand> globalBrands,  double minPrice,  double maxPrice,  ProductFilter? activeFilter,  ProductSort? activeSort,  String? errorMessage,  int currentPage,  int lastPage,  bool hasReachedMax,  bool isLoadingMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryItemsState() when $default != null:
return $default(_that.status,_that.products,_that.availableBrands,_that.availableAttributes,_that.globalAttributes,_that.globalBrands,_that.minPrice,_that.maxPrice,_that.activeFilter,_that.activeSort,_that.errorMessage,_that.currentPage,_that.lastPage,_that.hasReachedMax,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CategoryItemsStatus status,  List<CategoryProduct> products,  List<String> availableBrands,  Map<String, List<String>> availableAttributes,  List<AttributeData> globalAttributes,  List<Brand> globalBrands,  double minPrice,  double maxPrice,  ProductFilter? activeFilter,  ProductSort? activeSort,  String? errorMessage,  int currentPage,  int lastPage,  bool hasReachedMax,  bool isLoadingMore)  $default,) {final _that = this;
switch (_that) {
case _CategoryItemsState():
return $default(_that.status,_that.products,_that.availableBrands,_that.availableAttributes,_that.globalAttributes,_that.globalBrands,_that.minPrice,_that.maxPrice,_that.activeFilter,_that.activeSort,_that.errorMessage,_that.currentPage,_that.lastPage,_that.hasReachedMax,_that.isLoadingMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CategoryItemsStatus status,  List<CategoryProduct> products,  List<String> availableBrands,  Map<String, List<String>> availableAttributes,  List<AttributeData> globalAttributes,  List<Brand> globalBrands,  double minPrice,  double maxPrice,  ProductFilter? activeFilter,  ProductSort? activeSort,  String? errorMessage,  int currentPage,  int lastPage,  bool hasReachedMax,  bool isLoadingMore)?  $default,) {final _that = this;
switch (_that) {
case _CategoryItemsState() when $default != null:
return $default(_that.status,_that.products,_that.availableBrands,_that.availableAttributes,_that.globalAttributes,_that.globalBrands,_that.minPrice,_that.maxPrice,_that.activeFilter,_that.activeSort,_that.errorMessage,_that.currentPage,_that.lastPage,_that.hasReachedMax,_that.isLoadingMore);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryItemsState implements CategoryItemsState {
  const _CategoryItemsState({this.status = CategoryItemsStatus.initial,  List<CategoryProduct> products = const [],  List<String> availableBrands = const [],  Map<String, List<String>> availableAttributes = const {},  List<AttributeData> globalAttributes = const [],  List<Brand> globalBrands = const [], this.minPrice = 0, this.maxPrice = 100000, this.activeFilter, this.activeSort = ProductSort.nameAZ, this.errorMessage, this.currentPage = 1, this.lastPage = 1, this.hasReachedMax = false, this.isLoadingMore = false}): _products = products,_availableBrands = availableBrands,_availableAttributes = availableAttributes,_globalAttributes = globalAttributes,_globalBrands = globalBrands;
  

@override@JsonKey() final  CategoryItemsStatus status;
 final  List<CategoryProduct> _products;
@override@JsonKey() List<CategoryProduct> get products {
  if (_products is EqualUnmodifiableListView) return _products;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_products);
}

 final  List<String> _availableBrands;
@override@JsonKey() List<String> get availableBrands {
  if (_availableBrands is EqualUnmodifiableListView) return _availableBrands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_availableBrands);
}

 final  Map<String, List<String>> _availableAttributes;
@override@JsonKey() Map<String, List<String>> get availableAttributes {
  if (_availableAttributes is EqualUnmodifiableMapView) return _availableAttributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_availableAttributes);
}

 final  List<AttributeData> _globalAttributes;
@override@JsonKey() List<AttributeData> get globalAttributes {
  if (_globalAttributes is EqualUnmodifiableListView) return _globalAttributes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_globalAttributes);
}

 final  List<Brand> _globalBrands;
@override@JsonKey() List<Brand> get globalBrands {
  if (_globalBrands is EqualUnmodifiableListView) return _globalBrands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_globalBrands);
}

@override@JsonKey() final  double minPrice;
@override@JsonKey() final  double maxPrice;
@override final  ProductFilter? activeFilter;
@override@JsonKey() final  ProductSort? activeSort;
@override final  String? errorMessage;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int lastPage;
@override@JsonKey() final  bool hasReachedMax;
@override@JsonKey() final  bool isLoadingMore;

/// Create a copy of CategoryItemsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryItemsStateCopyWith<_CategoryItemsState> get copyWith => __$CategoryItemsStateCopyWithImpl<_CategoryItemsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryItemsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.products, _products)&&const DeepCollectionEquality().equals(other.availableBrands, _availableBrands)&&const DeepCollectionEquality().equals(other.availableAttributes, _availableAttributes)&&const DeepCollectionEquality().equals(other.globalAttributes, _globalAttributes)&&const DeepCollectionEquality().equals(other.globalBrands, _globalBrands)&&(identical(other.minPrice, minPrice) || other.minPrice == minPrice)&&(identical(other.maxPrice, maxPrice) || other.maxPrice == maxPrice)&&(identical(other.activeFilter, activeFilter) || other.activeFilter == activeFilter)&&(identical(other.activeSort, activeSort) || other.activeSort == activeSort)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.hasReachedMax, hasReachedMax) || other.hasReachedMax == hasReachedMax)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_products),const DeepCollectionEquality().hash(_availableBrands),const DeepCollectionEquality().hash(_availableAttributes),const DeepCollectionEquality().hash(_globalAttributes),const DeepCollectionEquality().hash(_globalBrands),minPrice,maxPrice,activeFilter,activeSort,errorMessage,currentPage,lastPage,hasReachedMax,isLoadingMore);
}

@override
String toString() {
    return 'CategoryItemsState(status: $status, products: $products, availableBrands: $availableBrands, availableAttributes: $availableAttributes, globalAttributes: $globalAttributes, globalBrands: $globalBrands, minPrice: $minPrice, maxPrice: $maxPrice, activeFilter: $activeFilter, activeSort: $activeSort, errorMessage: $errorMessage, currentPage: $currentPage, lastPage: $lastPage, hasReachedMax: $hasReachedMax, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class _$CategoryItemsStateCopyWith<$Res> implements $CategoryItemsStateCopyWith<$Res> {
  factory _$CategoryItemsStateCopyWith(_CategoryItemsState value, $Res Function(_CategoryItemsState) _then) = __$CategoryItemsStateCopyWithImpl;
@override @useResult
$Res call({
 CategoryItemsStatus status, List<CategoryProduct> products, List<String> availableBrands, Map<String, List<String>> availableAttributes, List<AttributeData> globalAttributes, List<Brand> globalBrands, double minPrice, double maxPrice, ProductFilter? activeFilter, ProductSort? activeSort, String? errorMessage, int currentPage, int lastPage, bool hasReachedMax, bool isLoadingMore
});




}
/// @nodoc
class __$CategoryItemsStateCopyWithImpl<$Res>
    implements _$CategoryItemsStateCopyWith<$Res> {
  __$CategoryItemsStateCopyWithImpl(this._self, this._then);

  final _CategoryItemsState _self;
  final $Res Function(_CategoryItemsState) _then;

/// Create a copy of CategoryItemsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? products = null,Object? availableBrands = null,Object? availableAttributes = null,Object? globalAttributes = null,Object? globalBrands = null,Object? minPrice = null,Object? maxPrice = null,Object? activeFilter = freezed,Object? activeSort = freezed,Object? errorMessage = freezed,Object? currentPage = null,Object? lastPage = null,Object? hasReachedMax = null,Object? isLoadingMore = null,}) {
  return _then(_CategoryItemsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CategoryItemsStatus,products: null == products ? _self._products : products // ignore: cast_nullable_to_non_nullable
as List<CategoryProduct>,availableBrands: null == availableBrands ? _self._availableBrands : availableBrands // ignore: cast_nullable_to_non_nullable
as List<String>,availableAttributes: null == availableAttributes ? _self._availableAttributes : availableAttributes // ignore: cast_nullable_to_non_nullable
as Map<String, List<String>>,globalAttributes: null == globalAttributes ? _self._globalAttributes : globalAttributes // ignore: cast_nullable_to_non_nullable
as List<AttributeData>,globalBrands: null == globalBrands ? _self._globalBrands : globalBrands // ignore: cast_nullable_to_non_nullable
as List<Brand>,minPrice: null == minPrice ? _self.minPrice : minPrice // ignore: cast_nullable_to_non_nullable
as double,maxPrice: null == maxPrice ? _self.maxPrice : maxPrice // ignore: cast_nullable_to_non_nullable
as double,activeFilter: freezed == activeFilter ? _self.activeFilter : activeFilter // ignore: cast_nullable_to_non_nullable
as ProductFilter?,activeSort: freezed == activeSort ? _self.activeSort : activeSort // ignore: cast_nullable_to_non_nullable
as ProductSort?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,hasReachedMax: null == hasReachedMax ? _self.hasReachedMax : hasReachedMax // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
