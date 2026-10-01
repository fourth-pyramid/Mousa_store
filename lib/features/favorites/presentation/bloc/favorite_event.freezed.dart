// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorite_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoriteEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'FavoriteEvent()';
}


}

/// @nodoc
class $FavoriteEventCopyWith<$Res>  {
$FavoriteEventCopyWith(FavoriteEvent _, $Res Function(FavoriteEvent) __);
}


/// Adds pattern-matching-related methods to [FavoriteEvent].
extension FavoriteEventPatterns on FavoriteEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FavoritesFetchRequested value)?  fetchRequested,TResult Function( FavoriteToggled value)?  toggled,TResult Function( FavoriteResetRequested value)?  resetRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FavoritesFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case FavoriteToggled() when toggled != null:
return toggled(_that);case FavoriteResetRequested() when resetRequested != null:
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FavoritesFetchRequested value)  fetchRequested,required TResult Function( FavoriteToggled value)  toggled,required TResult Function( FavoriteResetRequested value)  resetRequested,}){
final _that = this;
switch (_that) {
case FavoritesFetchRequested():
return fetchRequested(_that);case FavoriteToggled():
return toggled(_that);case FavoriteResetRequested():
return resetRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FavoritesFetchRequested value)?  fetchRequested,TResult? Function( FavoriteToggled value)?  toggled,TResult? Function( FavoriteResetRequested value)?  resetRequested,}){
final _that = this;
switch (_that) {
case FavoritesFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case FavoriteToggled() when toggled != null:
return toggled(_that);case FavoriteResetRequested() when resetRequested != null:
return resetRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchRequested,TResult Function( int productId,  Product? product)?  toggled,TResult Function()?  resetRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FavoritesFetchRequested() when fetchRequested != null:
return fetchRequested();case FavoriteToggled() when toggled != null:
return toggled(_that.productId,_that.product);case FavoriteResetRequested() when resetRequested != null:
return resetRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchRequested,required TResult Function( int productId,  Product? product)  toggled,required TResult Function()  resetRequested,}) {final _that = this;
switch (_that) {
case FavoritesFetchRequested():
return fetchRequested();case FavoriteToggled():
return toggled(_that.productId,_that.product);case FavoriteResetRequested():
return resetRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchRequested,TResult? Function( int productId,  Product? product)?  toggled,TResult? Function()?  resetRequested,}) {final _that = this;
switch (_that) {
case FavoritesFetchRequested() when fetchRequested != null:
return fetchRequested();case FavoriteToggled() when toggled != null:
return toggled(_that.productId,_that.product);case FavoriteResetRequested() when resetRequested != null:
return resetRequested();case _:
  return null;

}
}

}

/// @nodoc


class FavoritesFetchRequested implements FavoriteEvent {
  const FavoritesFetchRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesFetchRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'FavoriteEvent.fetchRequested()';
}


}




/// @nodoc


class FavoriteToggled implements FavoriteEvent {
  const FavoriteToggled({required this.productId, this.product});
  

 final  int productId;
 final  Product? product;

/// Create a copy of FavoriteEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoriteToggledCopyWith<FavoriteToggled> get copyWith => _$FavoriteToggledCopyWithImpl<FavoriteToggled>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteToggled&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.product, product) || other.product == product));
}


@override
int get hashCode {
    return Object.hash(runtimeType,productId,product);
}

@override
String toString() {
    return 'FavoriteEvent.toggled(productId: $productId, product: $product)';
}


}

/// @nodoc
abstract mixin class $FavoriteToggledCopyWith<$Res> implements $FavoriteEventCopyWith<$Res> {
  factory $FavoriteToggledCopyWith(FavoriteToggled value, $Res Function(FavoriteToggled) _then) = _$FavoriteToggledCopyWithImpl;
@useResult
$Res call({
 int productId, Product? product
});


$ProductCopyWith<$Res>? get product;

}
/// @nodoc
class _$FavoriteToggledCopyWithImpl<$Res>
    implements $FavoriteToggledCopyWith<$Res> {
  _$FavoriteToggledCopyWithImpl(this._self, this._then);

  final FavoriteToggled _self;
  final $Res Function(FavoriteToggled) _then;

/// Create a copy of FavoriteEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? product = freezed,}) {
  return _then(FavoriteToggled(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,product: freezed == product ? _self.product : product // ignore: cast_nullable_to_non_nullable
as Product?,
  ));
}

/// Create a copy of FavoriteEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProductCopyWith<$Res>? get product {
    if (_self.product == null) {
    return null;
  }

  return $ProductCopyWith<$Res>(_self.product!, (value) {
    return _then(_self.copyWith(product: value));
  });
}
}

/// @nodoc


class FavoriteResetRequested implements FavoriteEvent {
  const FavoriteResetRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoriteResetRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'FavoriteEvent.resetRequested()';
}


}




// dart format on
