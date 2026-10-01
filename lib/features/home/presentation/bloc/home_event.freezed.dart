// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HomeEvent()';
}


}

/// @nodoc
class $HomeEventCopyWith<$Res>  {
$HomeEventCopyWith(HomeEvent _, $Res Function(HomeEvent) __);
}


/// Adds pattern-matching-related methods to [HomeEvent].
extension HomeEventPatterns on HomeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HomeAllDataRequested value)?  allDataRequested,TResult Function( HomeBannersRequested value)?  bannersRequested,TResult Function( HomeBrandsRequested value)?  brandsRequested,TResult Function( HomeCategoriesRequested value)?  categoriesRequested,TResult Function( HomeOfferItemsRequested value)?  offerItemsRequested,TResult Function( HomeRecentlyItemsRequested value)?  recentlyItemsRequested,TResult Function( HomeProductsRequested value)?  productsRequested,TResult Function( HomeLoadMoreProductsRequested value)?  loadMoreProductsRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HomeAllDataRequested() when allDataRequested != null:
return allDataRequested(_that);case HomeBannersRequested() when bannersRequested != null:
return bannersRequested(_that);case HomeBrandsRequested() when brandsRequested != null:
return brandsRequested(_that);case HomeCategoriesRequested() when categoriesRequested != null:
return categoriesRequested(_that);case HomeOfferItemsRequested() when offerItemsRequested != null:
return offerItemsRequested(_that);case HomeRecentlyItemsRequested() when recentlyItemsRequested != null:
return recentlyItemsRequested(_that);case HomeProductsRequested() when productsRequested != null:
return productsRequested(_that);case HomeLoadMoreProductsRequested() when loadMoreProductsRequested != null:
return loadMoreProductsRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HomeAllDataRequested value)  allDataRequested,required TResult Function( HomeBannersRequested value)  bannersRequested,required TResult Function( HomeBrandsRequested value)  brandsRequested,required TResult Function( HomeCategoriesRequested value)  categoriesRequested,required TResult Function( HomeOfferItemsRequested value)  offerItemsRequested,required TResult Function( HomeRecentlyItemsRequested value)  recentlyItemsRequested,required TResult Function( HomeProductsRequested value)  productsRequested,required TResult Function( HomeLoadMoreProductsRequested value)  loadMoreProductsRequested,}){
final _that = this;
switch (_that) {
case HomeAllDataRequested():
return allDataRequested(_that);case HomeBannersRequested():
return bannersRequested(_that);case HomeBrandsRequested():
return brandsRequested(_that);case HomeCategoriesRequested():
return categoriesRequested(_that);case HomeOfferItemsRequested():
return offerItemsRequested(_that);case HomeRecentlyItemsRequested():
return recentlyItemsRequested(_that);case HomeProductsRequested():
return productsRequested(_that);case HomeLoadMoreProductsRequested():
return loadMoreProductsRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HomeAllDataRequested value)?  allDataRequested,TResult? Function( HomeBannersRequested value)?  bannersRequested,TResult? Function( HomeBrandsRequested value)?  brandsRequested,TResult? Function( HomeCategoriesRequested value)?  categoriesRequested,TResult? Function( HomeOfferItemsRequested value)?  offerItemsRequested,TResult? Function( HomeRecentlyItemsRequested value)?  recentlyItemsRequested,TResult? Function( HomeProductsRequested value)?  productsRequested,TResult? Function( HomeLoadMoreProductsRequested value)?  loadMoreProductsRequested,}){
final _that = this;
switch (_that) {
case HomeAllDataRequested() when allDataRequested != null:
return allDataRequested(_that);case HomeBannersRequested() when bannersRequested != null:
return bannersRequested(_that);case HomeBrandsRequested() when brandsRequested != null:
return brandsRequested(_that);case HomeCategoriesRequested() when categoriesRequested != null:
return categoriesRequested(_that);case HomeOfferItemsRequested() when offerItemsRequested != null:
return offerItemsRequested(_that);case HomeRecentlyItemsRequested() when recentlyItemsRequested != null:
return recentlyItemsRequested(_that);case HomeProductsRequested() when productsRequested != null:
return productsRequested(_that);case HomeLoadMoreProductsRequested() when loadMoreProductsRequested != null:
return loadMoreProductsRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  allDataRequested,TResult Function()?  bannersRequested,TResult Function()?  brandsRequested,TResult Function()?  categoriesRequested,TResult Function()?  offerItemsRequested,TResult Function()?  recentlyItemsRequested,TResult Function( int page)?  productsRequested,TResult Function()?  loadMoreProductsRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HomeAllDataRequested() when allDataRequested != null:
return allDataRequested();case HomeBannersRequested() when bannersRequested != null:
return bannersRequested();case HomeBrandsRequested() when brandsRequested != null:
return brandsRequested();case HomeCategoriesRequested() when categoriesRequested != null:
return categoriesRequested();case HomeOfferItemsRequested() when offerItemsRequested != null:
return offerItemsRequested();case HomeRecentlyItemsRequested() when recentlyItemsRequested != null:
return recentlyItemsRequested();case HomeProductsRequested() when productsRequested != null:
return productsRequested(_that.page);case HomeLoadMoreProductsRequested() when loadMoreProductsRequested != null:
return loadMoreProductsRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  allDataRequested,required TResult Function()  bannersRequested,required TResult Function()  brandsRequested,required TResult Function()  categoriesRequested,required TResult Function()  offerItemsRequested,required TResult Function()  recentlyItemsRequested,required TResult Function( int page)  productsRequested,required TResult Function()  loadMoreProductsRequested,}) {final _that = this;
switch (_that) {
case HomeAllDataRequested():
return allDataRequested();case HomeBannersRequested():
return bannersRequested();case HomeBrandsRequested():
return brandsRequested();case HomeCategoriesRequested():
return categoriesRequested();case HomeOfferItemsRequested():
return offerItemsRequested();case HomeRecentlyItemsRequested():
return recentlyItemsRequested();case HomeProductsRequested():
return productsRequested(_that.page);case HomeLoadMoreProductsRequested():
return loadMoreProductsRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  allDataRequested,TResult? Function()?  bannersRequested,TResult? Function()?  brandsRequested,TResult? Function()?  categoriesRequested,TResult? Function()?  offerItemsRequested,TResult? Function()?  recentlyItemsRequested,TResult? Function( int page)?  productsRequested,TResult? Function()?  loadMoreProductsRequested,}) {final _that = this;
switch (_that) {
case HomeAllDataRequested() when allDataRequested != null:
return allDataRequested();case HomeBannersRequested() when bannersRequested != null:
return bannersRequested();case HomeBrandsRequested() when brandsRequested != null:
return brandsRequested();case HomeCategoriesRequested() when categoriesRequested != null:
return categoriesRequested();case HomeOfferItemsRequested() when offerItemsRequested != null:
return offerItemsRequested();case HomeRecentlyItemsRequested() when recentlyItemsRequested != null:
return recentlyItemsRequested();case HomeProductsRequested() when productsRequested != null:
return productsRequested(_that.page);case HomeLoadMoreProductsRequested() when loadMoreProductsRequested != null:
return loadMoreProductsRequested();case _:
  return null;

}
}

}

/// @nodoc


class HomeAllDataRequested implements HomeEvent {
  const HomeAllDataRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeAllDataRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HomeEvent.allDataRequested()';
}


}




/// @nodoc


class HomeBannersRequested implements HomeEvent {
  const HomeBannersRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeBannersRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HomeEvent.bannersRequested()';
}


}




/// @nodoc


class HomeBrandsRequested implements HomeEvent {
  const HomeBrandsRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeBrandsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HomeEvent.brandsRequested()';
}


}




/// @nodoc


class HomeCategoriesRequested implements HomeEvent {
  const HomeCategoriesRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeCategoriesRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HomeEvent.categoriesRequested()';
}


}




/// @nodoc


class HomeOfferItemsRequested implements HomeEvent {
  const HomeOfferItemsRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeOfferItemsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HomeEvent.offerItemsRequested()';
}


}




/// @nodoc


class HomeRecentlyItemsRequested implements HomeEvent {
  const HomeRecentlyItemsRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeRecentlyItemsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HomeEvent.recentlyItemsRequested()';
}


}




/// @nodoc


class HomeProductsRequested implements HomeEvent {
  const HomeProductsRequested({this.page = 1});
  

@JsonKey() final  int page;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeProductsRequestedCopyWith<HomeProductsRequested> get copyWith => _$HomeProductsRequestedCopyWithImpl<HomeProductsRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeProductsRequested&&(identical(other.page, page) || other.page == page));
}


@override
int get hashCode {
    return Object.hash(runtimeType,page);
}

@override
String toString() {
    return 'HomeEvent.productsRequested(page: $page)';
}


}

/// @nodoc
abstract mixin class $HomeProductsRequestedCopyWith<$Res> implements $HomeEventCopyWith<$Res> {
  factory $HomeProductsRequestedCopyWith(HomeProductsRequested value, $Res Function(HomeProductsRequested) _then) = _$HomeProductsRequestedCopyWithImpl;
@useResult
$Res call({
 int page
});




}
/// @nodoc
class _$HomeProductsRequestedCopyWithImpl<$Res>
    implements $HomeProductsRequestedCopyWith<$Res> {
  _$HomeProductsRequestedCopyWithImpl(this._self, this._then);

  final HomeProductsRequested _self;
  final $Res Function(HomeProductsRequested) _then;

/// Create a copy of HomeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,}) {
  return _then(HomeProductsRequested(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class HomeLoadMoreProductsRequested implements HomeEvent {
  const HomeLoadMoreProductsRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeLoadMoreProductsRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HomeEvent.loadMoreProductsRequested()';
}


}




// dart format on
