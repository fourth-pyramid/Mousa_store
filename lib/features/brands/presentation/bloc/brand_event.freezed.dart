// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BrandEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is BrandEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'BrandEvent()';
}


}

/// @nodoc
class $BrandEventCopyWith<$Res>  {
$BrandEventCopyWith(BrandEvent _, $Res Function(BrandEvent) __);
}


/// Adds pattern-matching-related methods to [BrandEvent].
extension BrandEventPatterns on BrandEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BrandFetchStarted value)?  fetchStarted,TResult Function( BrandRefreshRequested value)?  refreshRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BrandFetchStarted() when fetchStarted != null:
return fetchStarted(_that);case BrandRefreshRequested() when refreshRequested != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BrandFetchStarted value)  fetchStarted,required TResult Function( BrandRefreshRequested value)  refreshRequested,}){
final _that = this;
switch (_that) {
case BrandFetchStarted():
return fetchStarted(_that);case BrandRefreshRequested():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BrandFetchStarted value)?  fetchStarted,TResult? Function( BrandRefreshRequested value)?  refreshRequested,}){
final _that = this;
switch (_that) {
case BrandFetchStarted() when fetchStarted != null:
return fetchStarted(_that);case BrandRefreshRequested() when refreshRequested != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchStarted,TResult Function()?  refreshRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BrandFetchStarted() when fetchStarted != null:
return fetchStarted();case BrandRefreshRequested() when refreshRequested != null:
return refreshRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchStarted,required TResult Function()  refreshRequested,}) {final _that = this;
switch (_that) {
case BrandFetchStarted():
return fetchStarted();case BrandRefreshRequested():
return refreshRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchStarted,TResult? Function()?  refreshRequested,}) {final _that = this;
switch (_that) {
case BrandFetchStarted() when fetchStarted != null:
return fetchStarted();case BrandRefreshRequested() when refreshRequested != null:
return refreshRequested();case _:
  return null;

}
}

}

/// @nodoc


class BrandFetchStarted implements BrandEvent {
  const BrandFetchStarted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is BrandFetchStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'BrandEvent.fetchStarted()';
}


}




/// @nodoc


class BrandRefreshRequested implements BrandEvent {
  const BrandRefreshRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is BrandRefreshRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'BrandEvent.refreshRequested()';
}


}




// dart format on
