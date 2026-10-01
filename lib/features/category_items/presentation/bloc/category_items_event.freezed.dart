// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_items_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryItemsEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryItemsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CategoryItemsEvent()';
}


}

/// @nodoc
class $CategoryItemsEventCopyWith<$Res>  {
$CategoryItemsEventCopyWith(CategoryItemsEvent _, $Res Function(CategoryItemsEvent) __);
}


/// Adds pattern-matching-related methods to [CategoryItemsEvent].
extension CategoryItemsEventPatterns on CategoryItemsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CategoryItemsFetchRequested value)?  fetchRequested,TResult Function( CategoryItemsLoadMoreRequested value)?  loadMoreRequested,TResult Function( CategoryItemsFilterApplied value)?  filterApplied,TResult Function( CategoryItemsSortApplied value)?  sortApplied,TResult Function( CategoryItemsFilterReset value)?  filterReset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CategoryItemsFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case CategoryItemsLoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that);case CategoryItemsFilterApplied() when filterApplied != null:
return filterApplied(_that);case CategoryItemsSortApplied() when sortApplied != null:
return sortApplied(_that);case CategoryItemsFilterReset() when filterReset != null:
return filterReset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CategoryItemsFetchRequested value)  fetchRequested,required TResult Function( CategoryItemsLoadMoreRequested value)  loadMoreRequested,required TResult Function( CategoryItemsFilterApplied value)  filterApplied,required TResult Function( CategoryItemsSortApplied value)  sortApplied,required TResult Function( CategoryItemsFilterReset value)  filterReset,}){
final _that = this;
switch (_that) {
case CategoryItemsFetchRequested():
return fetchRequested(_that);case CategoryItemsLoadMoreRequested():
return loadMoreRequested(_that);case CategoryItemsFilterApplied():
return filterApplied(_that);case CategoryItemsSortApplied():
return sortApplied(_that);case CategoryItemsFilterReset():
return filterReset(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CategoryItemsFetchRequested value)?  fetchRequested,TResult? Function( CategoryItemsLoadMoreRequested value)?  loadMoreRequested,TResult? Function( CategoryItemsFilterApplied value)?  filterApplied,TResult? Function( CategoryItemsSortApplied value)?  sortApplied,TResult? Function( CategoryItemsFilterReset value)?  filterReset,}){
final _that = this;
switch (_that) {
case CategoryItemsFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case CategoryItemsLoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that);case CategoryItemsFilterApplied() when filterApplied != null:
return filterApplied(_that);case CategoryItemsSortApplied() when sortApplied != null:
return sortApplied(_that);case CategoryItemsFilterReset() when filterReset != null:
return filterReset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ItemFetchType fetchType,  int? categoryId,  int? brandId)?  fetchRequested,TResult Function()?  loadMoreRequested,TResult Function( ProductFilter filter)?  filterApplied,TResult Function( ProductSort sort)?  sortApplied,TResult Function()?  filterReset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CategoryItemsFetchRequested() when fetchRequested != null:
return fetchRequested(_that.fetchType,_that.categoryId,_that.brandId);case CategoryItemsLoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested();case CategoryItemsFilterApplied() when filterApplied != null:
return filterApplied(_that.filter);case CategoryItemsSortApplied() when sortApplied != null:
return sortApplied(_that.sort);case CategoryItemsFilterReset() when filterReset != null:
return filterReset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ItemFetchType fetchType,  int? categoryId,  int? brandId)  fetchRequested,required TResult Function()  loadMoreRequested,required TResult Function( ProductFilter filter)  filterApplied,required TResult Function( ProductSort sort)  sortApplied,required TResult Function()  filterReset,}) {final _that = this;
switch (_that) {
case CategoryItemsFetchRequested():
return fetchRequested(_that.fetchType,_that.categoryId,_that.brandId);case CategoryItemsLoadMoreRequested():
return loadMoreRequested();case CategoryItemsFilterApplied():
return filterApplied(_that.filter);case CategoryItemsSortApplied():
return sortApplied(_that.sort);case CategoryItemsFilterReset():
return filterReset();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ItemFetchType fetchType,  int? categoryId,  int? brandId)?  fetchRequested,TResult? Function()?  loadMoreRequested,TResult? Function( ProductFilter filter)?  filterApplied,TResult? Function( ProductSort sort)?  sortApplied,TResult? Function()?  filterReset,}) {final _that = this;
switch (_that) {
case CategoryItemsFetchRequested() when fetchRequested != null:
return fetchRequested(_that.fetchType,_that.categoryId,_that.brandId);case CategoryItemsLoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested();case CategoryItemsFilterApplied() when filterApplied != null:
return filterApplied(_that.filter);case CategoryItemsSortApplied() when sortApplied != null:
return sortApplied(_that.sort);case CategoryItemsFilterReset() when filterReset != null:
return filterReset();case _:
  return null;

}
}

}

/// @nodoc


class CategoryItemsFetchRequested implements CategoryItemsEvent {
  const CategoryItemsFetchRequested({required this.fetchType, this.categoryId, this.brandId});
  

 final  ItemFetchType fetchType;
 final  int? categoryId;
 final  int? brandId;

/// Create a copy of CategoryItemsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryItemsFetchRequestedCopyWith<CategoryItemsFetchRequested> get copyWith => _$CategoryItemsFetchRequestedCopyWithImpl<CategoryItemsFetchRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryItemsFetchRequested&&(identical(other.fetchType, fetchType) || other.fetchType == fetchType)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.brandId, brandId) || other.brandId == brandId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,fetchType,categoryId,brandId);
}

@override
String toString() {
    return 'CategoryItemsEvent.fetchRequested(fetchType: $fetchType, categoryId: $categoryId, brandId: $brandId)';
}


}

/// @nodoc
abstract mixin class $CategoryItemsFetchRequestedCopyWith<$Res> implements $CategoryItemsEventCopyWith<$Res> {
  factory $CategoryItemsFetchRequestedCopyWith(CategoryItemsFetchRequested value, $Res Function(CategoryItemsFetchRequested) _then) = _$CategoryItemsFetchRequestedCopyWithImpl;
@useResult
$Res call({
 ItemFetchType fetchType, int? categoryId, int? brandId
});




}
/// @nodoc
class _$CategoryItemsFetchRequestedCopyWithImpl<$Res>
    implements $CategoryItemsFetchRequestedCopyWith<$Res> {
  _$CategoryItemsFetchRequestedCopyWithImpl(this._self, this._then);

  final CategoryItemsFetchRequested _self;
  final $Res Function(CategoryItemsFetchRequested) _then;

/// Create a copy of CategoryItemsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fetchType = null,Object? categoryId = freezed,Object? brandId = freezed,}) {
  return _then(CategoryItemsFetchRequested(
fetchType: null == fetchType ? _self.fetchType : fetchType // ignore: cast_nullable_to_non_nullable
as ItemFetchType,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as int?,brandId: freezed == brandId ? _self.brandId : brandId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class CategoryItemsLoadMoreRequested implements CategoryItemsEvent {
  const CategoryItemsLoadMoreRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryItemsLoadMoreRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CategoryItemsEvent.loadMoreRequested()';
}


}




/// @nodoc


class CategoryItemsFilterApplied implements CategoryItemsEvent {
  const CategoryItemsFilterApplied(this.filter);
  

 final  ProductFilter filter;

/// Create a copy of CategoryItemsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryItemsFilterAppliedCopyWith<CategoryItemsFilterApplied> get copyWith => _$CategoryItemsFilterAppliedCopyWithImpl<CategoryItemsFilterApplied>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryItemsFilterApplied&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode {
    return Object.hash(runtimeType,filter);
}

@override
String toString() {
    return 'CategoryItemsEvent.filterApplied(filter: $filter)';
}


}

/// @nodoc
abstract mixin class $CategoryItemsFilterAppliedCopyWith<$Res> implements $CategoryItemsEventCopyWith<$Res> {
  factory $CategoryItemsFilterAppliedCopyWith(CategoryItemsFilterApplied value, $Res Function(CategoryItemsFilterApplied) _then) = _$CategoryItemsFilterAppliedCopyWithImpl;
@useResult
$Res call({
 ProductFilter filter
});




}
/// @nodoc
class _$CategoryItemsFilterAppliedCopyWithImpl<$Res>
    implements $CategoryItemsFilterAppliedCopyWith<$Res> {
  _$CategoryItemsFilterAppliedCopyWithImpl(this._self, this._then);

  final CategoryItemsFilterApplied _self;
  final $Res Function(CategoryItemsFilterApplied) _then;

/// Create a copy of CategoryItemsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = null,}) {
  return _then(CategoryItemsFilterApplied(
null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as ProductFilter,
  ));
}


}

/// @nodoc


class CategoryItemsSortApplied implements CategoryItemsEvent {
  const CategoryItemsSortApplied(this.sort);
  

 final  ProductSort sort;

/// Create a copy of CategoryItemsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryItemsSortAppliedCopyWith<CategoryItemsSortApplied> get copyWith => _$CategoryItemsSortAppliedCopyWithImpl<CategoryItemsSortApplied>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryItemsSortApplied&&(identical(other.sort, sort) || other.sort == sort));
}


@override
int get hashCode {
    return Object.hash(runtimeType,sort);
}

@override
String toString() {
    return 'CategoryItemsEvent.sortApplied(sort: $sort)';
}


}

/// @nodoc
abstract mixin class $CategoryItemsSortAppliedCopyWith<$Res> implements $CategoryItemsEventCopyWith<$Res> {
  factory $CategoryItemsSortAppliedCopyWith(CategoryItemsSortApplied value, $Res Function(CategoryItemsSortApplied) _then) = _$CategoryItemsSortAppliedCopyWithImpl;
@useResult
$Res call({
 ProductSort sort
});




}
/// @nodoc
class _$CategoryItemsSortAppliedCopyWithImpl<$Res>
    implements $CategoryItemsSortAppliedCopyWith<$Res> {
  _$CategoryItemsSortAppliedCopyWithImpl(this._self, this._then);

  final CategoryItemsSortApplied _self;
  final $Res Function(CategoryItemsSortApplied) _then;

/// Create a copy of CategoryItemsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? sort = null,}) {
  return _then(CategoryItemsSortApplied(
null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as ProductSort,
  ));
}


}

/// @nodoc


class CategoryItemsFilterReset implements CategoryItemsEvent {
  const CategoryItemsFilterReset();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryItemsFilterReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'CategoryItemsEvent.filterReset()';
}


}




// dart format on
