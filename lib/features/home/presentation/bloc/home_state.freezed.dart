// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {

 RequestStatus get bannerStatus; List<BannerModel> get banners; RequestStatus get brandsStatus; List<Brand> get brands; RequestStatus get categoriesStatus; List<Category> get categories; RequestStatus get offersStatus; List<Product> get offerProducts; RequestStatus get recentlyStatus; List<Product> get recentlyProducts; RequestStatus get allProductsStatus; RequestStatus get allProductsPaginationStatus; List<Product> get allProducts; int get currentPage; int get lastPage; bool get hasReachedMax; String? get errorMessage;
/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeStateCopyWith<HomeState> get copyWith => _$HomeStateCopyWithImpl<HomeState>(this as HomeState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HomeState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState&&(identical(other.bannerStatus, _this.bannerStatus) || other.bannerStatus == _this.bannerStatus)&&const DeepCollectionEquality().equals(other.banners, _this.banners)&&(identical(other.brandsStatus, _this.brandsStatus) || other.brandsStatus == _this.brandsStatus)&&const DeepCollectionEquality().equals(other.brands, _this.brands)&&(identical(other.categoriesStatus, _this.categoriesStatus) || other.categoriesStatus == _this.categoriesStatus)&&const DeepCollectionEquality().equals(other.categories, _this.categories)&&(identical(other.offersStatus, _this.offersStatus) || other.offersStatus == _this.offersStatus)&&const DeepCollectionEquality().equals(other.offerProducts, _this.offerProducts)&&(identical(other.recentlyStatus, _this.recentlyStatus) || other.recentlyStatus == _this.recentlyStatus)&&const DeepCollectionEquality().equals(other.recentlyProducts, _this.recentlyProducts)&&(identical(other.allProductsStatus, _this.allProductsStatus) || other.allProductsStatus == _this.allProductsStatus)&&(identical(other.allProductsPaginationStatus, _this.allProductsPaginationStatus) || other.allProductsPaginationStatus == _this.allProductsPaginationStatus)&&const DeepCollectionEquality().equals(other.allProducts, _this.allProducts)&&(identical(other.currentPage, _this.currentPage) || other.currentPage == _this.currentPage)&&(identical(other.lastPage, _this.lastPage) || other.lastPage == _this.lastPage)&&(identical(other.hasReachedMax, _this.hasReachedMax) || other.hasReachedMax == _this.hasReachedMax)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as HomeState;
  return Object.hash(runtimeType,_this.bannerStatus,const DeepCollectionEquality().hash(_this.banners),_this.brandsStatus,const DeepCollectionEquality().hash(_this.brands),_this.categoriesStatus,const DeepCollectionEquality().hash(_this.categories),_this.offersStatus,const DeepCollectionEquality().hash(_this.offerProducts),_this.recentlyStatus,const DeepCollectionEquality().hash(_this.recentlyProducts),_this.allProductsStatus,_this.allProductsPaginationStatus,const DeepCollectionEquality().hash(_this.allProducts),_this.currentPage,_this.lastPage,_this.hasReachedMax,_this.errorMessage);
}

@override
String toString() {
  final _this = this as HomeState;
  return 'HomeState(bannerStatus: ${_this.bannerStatus}, banners: ${_this.banners}, brandsStatus: ${_this.brandsStatus}, brands: ${_this.brands}, categoriesStatus: ${_this.categoriesStatus}, categories: ${_this.categories}, offersStatus: ${_this.offersStatus}, offerProducts: ${_this.offerProducts}, recentlyStatus: ${_this.recentlyStatus}, recentlyProducts: ${_this.recentlyProducts}, allProductsStatus: ${_this.allProductsStatus}, allProductsPaginationStatus: ${_this.allProductsPaginationStatus}, allProducts: ${_this.allProducts}, currentPage: ${_this.currentPage}, lastPage: ${_this.lastPage}, hasReachedMax: ${_this.hasReachedMax}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $HomeStateCopyWith<$Res>  {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) _then) = _$HomeStateCopyWithImpl;
@useResult
$Res call({
 RequestStatus bannerStatus, List<BannerModel> banners, RequestStatus brandsStatus, List<Brand> brands, RequestStatus categoriesStatus, List<Category> categories, RequestStatus offersStatus, List<Product> offerProducts, RequestStatus recentlyStatus, List<Product> recentlyProducts, RequestStatus allProductsStatus, RequestStatus allProductsPaginationStatus, List<Product> allProducts, int currentPage, int lastPage, bool hasReachedMax, String? errorMessage
});




}
/// @nodoc
class _$HomeStateCopyWithImpl<$Res>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._self, this._then);

  final HomeState _self;
  final $Res Function(HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bannerStatus = null,Object? banners = null,Object? brandsStatus = null,Object? brands = null,Object? categoriesStatus = null,Object? categories = null,Object? offersStatus = null,Object? offerProducts = null,Object? recentlyStatus = null,Object? recentlyProducts = null,Object? allProductsStatus = null,Object? allProductsPaginationStatus = null,Object? allProducts = null,Object? currentPage = null,Object? lastPage = null,Object? hasReachedMax = null,Object? errorMessage = freezed,}) {
  return _then(HomeState(
bannerStatus: null == bannerStatus ? _self.bannerStatus : bannerStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,banners: null == banners ? _self.banners : banners // ignore: cast_nullable_to_non_nullable
as List<BannerModel>,brandsStatus: null == brandsStatus ? _self.brandsStatus : brandsStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,brands: null == brands ? _self.brands : brands // ignore: cast_nullable_to_non_nullable
as List<Brand>,categoriesStatus: null == categoriesStatus ? _self.categoriesStatus : categoriesStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,offersStatus: null == offersStatus ? _self.offersStatus : offersStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,offerProducts: null == offerProducts ? _self.offerProducts : offerProducts // ignore: cast_nullable_to_non_nullable
as List<Product>,recentlyStatus: null == recentlyStatus ? _self.recentlyStatus : recentlyStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,recentlyProducts: null == recentlyProducts ? _self.recentlyProducts : recentlyProducts // ignore: cast_nullable_to_non_nullable
as List<Product>,allProductsStatus: null == allProductsStatus ? _self.allProductsStatus : allProductsStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,allProductsPaginationStatus: null == allProductsPaginationStatus ? _self.allProductsPaginationStatus : allProductsPaginationStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,allProducts: null == allProducts ? _self.allProducts : allProducts // ignore: cast_nullable_to_non_nullable
as List<Product>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,hasReachedMax: null == hasReachedMax ? _self.hasReachedMax : hasReachedMax // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeState value)  $default,){
final _that = this;
switch (_that) {
case _HomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RequestStatus bannerStatus,  List<BannerModel> banners,  RequestStatus brandsStatus,  List<Brand> brands,  RequestStatus categoriesStatus,  List<Category> categories,  RequestStatus offersStatus,  List<Product> offerProducts,  RequestStatus recentlyStatus,  List<Product> recentlyProducts,  RequestStatus allProductsStatus,  RequestStatus allProductsPaginationStatus,  List<Product> allProducts,  int currentPage,  int lastPage,  bool hasReachedMax,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.bannerStatus,_that.banners,_that.brandsStatus,_that.brands,_that.categoriesStatus,_that.categories,_that.offersStatus,_that.offerProducts,_that.recentlyStatus,_that.recentlyProducts,_that.allProductsStatus,_that.allProductsPaginationStatus,_that.allProducts,_that.currentPage,_that.lastPage,_that.hasReachedMax,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RequestStatus bannerStatus,  List<BannerModel> banners,  RequestStatus brandsStatus,  List<Brand> brands,  RequestStatus categoriesStatus,  List<Category> categories,  RequestStatus offersStatus,  List<Product> offerProducts,  RequestStatus recentlyStatus,  List<Product> recentlyProducts,  RequestStatus allProductsStatus,  RequestStatus allProductsPaginationStatus,  List<Product> allProducts,  int currentPage,  int lastPage,  bool hasReachedMax,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _HomeState():
return $default(_that.bannerStatus,_that.banners,_that.brandsStatus,_that.brands,_that.categoriesStatus,_that.categories,_that.offersStatus,_that.offerProducts,_that.recentlyStatus,_that.recentlyProducts,_that.allProductsStatus,_that.allProductsPaginationStatus,_that.allProducts,_that.currentPage,_that.lastPage,_that.hasReachedMax,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RequestStatus bannerStatus,  List<BannerModel> banners,  RequestStatus brandsStatus,  List<Brand> brands,  RequestStatus categoriesStatus,  List<Category> categories,  RequestStatus offersStatus,  List<Product> offerProducts,  RequestStatus recentlyStatus,  List<Product> recentlyProducts,  RequestStatus allProductsStatus,  RequestStatus allProductsPaginationStatus,  List<Product> allProducts,  int currentPage,  int lastPage,  bool hasReachedMax,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _HomeState() when $default != null:
return $default(_that.bannerStatus,_that.banners,_that.brandsStatus,_that.brands,_that.categoriesStatus,_that.categories,_that.offersStatus,_that.offerProducts,_that.recentlyStatus,_that.recentlyProducts,_that.allProductsStatus,_that.allProductsPaginationStatus,_that.allProducts,_that.currentPage,_that.lastPage,_that.hasReachedMax,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _HomeState implements HomeState {
  const _HomeState({this.bannerStatus = RequestStatus.initial,  List<BannerModel> banners = const [], this.brandsStatus = RequestStatus.initial,  List<Brand> brands = const [], this.categoriesStatus = RequestStatus.initial,  List<Category> categories = const [], this.offersStatus = RequestStatus.initial,  List<Product> offerProducts = const [], this.recentlyStatus = RequestStatus.initial,  List<Product> recentlyProducts = const [], this.allProductsStatus = RequestStatus.initial, this.allProductsPaginationStatus = RequestStatus.initial,  List<Product> allProducts = const [], this.currentPage = 1, this.lastPage = 1, this.hasReachedMax = false, this.errorMessage}): _banners = banners,_brands = brands,_categories = categories,_offerProducts = offerProducts,_recentlyProducts = recentlyProducts,_allProducts = allProducts;
  

@override@JsonKey() final  RequestStatus bannerStatus;
 final  List<BannerModel> _banners;
@override@JsonKey() List<BannerModel> get banners {
  if (_banners is EqualUnmodifiableListView) return _banners;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_banners);
}

@override@JsonKey() final  RequestStatus brandsStatus;
 final  List<Brand> _brands;
@override@JsonKey() List<Brand> get brands {
  if (_brands is EqualUnmodifiableListView) return _brands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_brands);
}

@override@JsonKey() final  RequestStatus categoriesStatus;
 final  List<Category> _categories;
@override@JsonKey() List<Category> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

@override@JsonKey() final  RequestStatus offersStatus;
 final  List<Product> _offerProducts;
@override@JsonKey() List<Product> get offerProducts {
  if (_offerProducts is EqualUnmodifiableListView) return _offerProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_offerProducts);
}

@override@JsonKey() final  RequestStatus recentlyStatus;
 final  List<Product> _recentlyProducts;
@override@JsonKey() List<Product> get recentlyProducts {
  if (_recentlyProducts is EqualUnmodifiableListView) return _recentlyProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentlyProducts);
}

@override@JsonKey() final  RequestStatus allProductsStatus;
@override@JsonKey() final  RequestStatus allProductsPaginationStatus;
 final  List<Product> _allProducts;
@override@JsonKey() List<Product> get allProducts {
  if (_allProducts is EqualUnmodifiableListView) return _allProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allProducts);
}

@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int lastPage;
@override@JsonKey() final  bool hasReachedMax;
@override final  String? errorMessage;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeStateCopyWith<_HomeState> get copyWith => __$HomeStateCopyWithImpl<_HomeState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeState&&(identical(other.bannerStatus, bannerStatus) || other.bannerStatus == bannerStatus)&&const DeepCollectionEquality().equals(other.banners, _banners)&&(identical(other.brandsStatus, brandsStatus) || other.brandsStatus == brandsStatus)&&const DeepCollectionEquality().equals(other.brands, _brands)&&(identical(other.categoriesStatus, categoriesStatus) || other.categoriesStatus == categoriesStatus)&&const DeepCollectionEquality().equals(other.categories, _categories)&&(identical(other.offersStatus, offersStatus) || other.offersStatus == offersStatus)&&const DeepCollectionEquality().equals(other.offerProducts, _offerProducts)&&(identical(other.recentlyStatus, recentlyStatus) || other.recentlyStatus == recentlyStatus)&&const DeepCollectionEquality().equals(other.recentlyProducts, _recentlyProducts)&&(identical(other.allProductsStatus, allProductsStatus) || other.allProductsStatus == allProductsStatus)&&(identical(other.allProductsPaginationStatus, allProductsPaginationStatus) || other.allProductsPaginationStatus == allProductsPaginationStatus)&&const DeepCollectionEquality().equals(other.allProducts, _allProducts)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.hasReachedMax, hasReachedMax) || other.hasReachedMax == hasReachedMax)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,bannerStatus,const DeepCollectionEquality().hash(_banners),brandsStatus,const DeepCollectionEquality().hash(_brands),categoriesStatus,const DeepCollectionEquality().hash(_categories),offersStatus,const DeepCollectionEquality().hash(_offerProducts),recentlyStatus,const DeepCollectionEquality().hash(_recentlyProducts),allProductsStatus,allProductsPaginationStatus,const DeepCollectionEquality().hash(_allProducts),currentPage,lastPage,hasReachedMax,errorMessage);
}

@override
String toString() {
    return 'HomeState(bannerStatus: $bannerStatus, banners: $banners, brandsStatus: $brandsStatus, brands: $brands, categoriesStatus: $categoriesStatus, categories: $categories, offersStatus: $offersStatus, offerProducts: $offerProducts, recentlyStatus: $recentlyStatus, recentlyProducts: $recentlyProducts, allProductsStatus: $allProductsStatus, allProductsPaginationStatus: $allProductsPaginationStatus, allProducts: $allProducts, currentPage: $currentPage, lastPage: $lastPage, hasReachedMax: $hasReachedMax, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$HomeStateCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory _$HomeStateCopyWith(_HomeState value, $Res Function(_HomeState) _then) = __$HomeStateCopyWithImpl;
@override @useResult
$Res call({
 RequestStatus bannerStatus, List<BannerModel> banners, RequestStatus brandsStatus, List<Brand> brands, RequestStatus categoriesStatus, List<Category> categories, RequestStatus offersStatus, List<Product> offerProducts, RequestStatus recentlyStatus, List<Product> recentlyProducts, RequestStatus allProductsStatus, RequestStatus allProductsPaginationStatus, List<Product> allProducts, int currentPage, int lastPage, bool hasReachedMax, String? errorMessage
});




}
/// @nodoc
class __$HomeStateCopyWithImpl<$Res>
    implements _$HomeStateCopyWith<$Res> {
  __$HomeStateCopyWithImpl(this._self, this._then);

  final _HomeState _self;
  final $Res Function(_HomeState) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bannerStatus = null,Object? banners = null,Object? brandsStatus = null,Object? brands = null,Object? categoriesStatus = null,Object? categories = null,Object? offersStatus = null,Object? offerProducts = null,Object? recentlyStatus = null,Object? recentlyProducts = null,Object? allProductsStatus = null,Object? allProductsPaginationStatus = null,Object? allProducts = null,Object? currentPage = null,Object? lastPage = null,Object? hasReachedMax = null,Object? errorMessage = freezed,}) {
  return _then(_HomeState(
bannerStatus: null == bannerStatus ? _self.bannerStatus : bannerStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,banners: null == banners ? _self._banners : banners // ignore: cast_nullable_to_non_nullable
as List<BannerModel>,brandsStatus: null == brandsStatus ? _self.brandsStatus : brandsStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,brands: null == brands ? _self._brands : brands // ignore: cast_nullable_to_non_nullable
as List<Brand>,categoriesStatus: null == categoriesStatus ? _self.categoriesStatus : categoriesStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<Category>,offersStatus: null == offersStatus ? _self.offersStatus : offersStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,offerProducts: null == offerProducts ? _self._offerProducts : offerProducts // ignore: cast_nullable_to_non_nullable
as List<Product>,recentlyStatus: null == recentlyStatus ? _self.recentlyStatus : recentlyStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,recentlyProducts: null == recentlyProducts ? _self._recentlyProducts : recentlyProducts // ignore: cast_nullable_to_non_nullable
as List<Product>,allProductsStatus: null == allProductsStatus ? _self.allProductsStatus : allProductsStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,allProductsPaginationStatus: null == allProductsPaginationStatus ? _self.allProductsPaginationStatus : allProductsPaginationStatus // ignore: cast_nullable_to_non_nullable
as RequestStatus,allProducts: null == allProducts ? _self._allProducts : allProducts // ignore: cast_nullable_to_non_nullable
as List<Product>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,hasReachedMax: null == hasReachedMax ? _self.hasReachedMax : hasReachedMax // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
