// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'brand_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BrandState {

 BrandStatus get status; List<Brand> get brands; String? get errorMessage;
/// Create a copy of BrandState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BrandStateCopyWith<BrandState> get copyWith => _$BrandStateCopyWithImpl<BrandState>(this as BrandState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BrandState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BrandState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.brands, _this.brands)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as BrandState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.brands),_this.errorMessage);
}

@override
String toString() {
  final _this = this as BrandState;
  return 'BrandState(status: ${_this.status}, brands: ${_this.brands}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $BrandStateCopyWith<$Res>  {
  factory $BrandStateCopyWith(BrandState value, $Res Function(BrandState) _then) = _$BrandStateCopyWithImpl;
@useResult
$Res call({
 BrandStatus status, List<Brand> brands, String? errorMessage
});




}
/// @nodoc
class _$BrandStateCopyWithImpl<$Res>
    implements $BrandStateCopyWith<$Res> {
  _$BrandStateCopyWithImpl(this._self, this._then);

  final BrandState _self;
  final $Res Function(BrandState) _then;

/// Create a copy of BrandState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? brands = null,Object? errorMessage = freezed,}) {
  return _then(BrandState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BrandStatus,brands: null == brands ? _self.brands : brands // ignore: cast_nullable_to_non_nullable
as List<Brand>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BrandState].
extension BrandStatePatterns on BrandState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BrandState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BrandState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BrandState value)  $default,){
final _that = this;
switch (_that) {
case _BrandState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BrandState value)?  $default,){
final _that = this;
switch (_that) {
case _BrandState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( BrandStatus status,  List<Brand> brands,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BrandState() when $default != null:
return $default(_that.status,_that.brands,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( BrandStatus status,  List<Brand> brands,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _BrandState():
return $default(_that.status,_that.brands,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( BrandStatus status,  List<Brand> brands,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _BrandState() when $default != null:
return $default(_that.status,_that.brands,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _BrandState implements BrandState {
  const _BrandState({this.status = BrandStatus.initial,  List<Brand> brands = const [], this.errorMessage}): _brands = brands;
  

@override@JsonKey() final  BrandStatus status;
 final  List<Brand> _brands;
@override@JsonKey() List<Brand> get brands {
  if (_brands is EqualUnmodifiableListView) return _brands;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_brands);
}

@override final  String? errorMessage;

/// Create a copy of BrandState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BrandStateCopyWith<_BrandState> get copyWith => __$BrandStateCopyWithImpl<_BrandState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BrandState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.brands, _brands)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_brands),errorMessage);
}

@override
String toString() {
    return 'BrandState(status: $status, brands: $brands, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$BrandStateCopyWith<$Res> implements $BrandStateCopyWith<$Res> {
  factory _$BrandStateCopyWith(_BrandState value, $Res Function(_BrandState) _then) = __$BrandStateCopyWithImpl;
@override @useResult
$Res call({
 BrandStatus status, List<Brand> brands, String? errorMessage
});




}
/// @nodoc
class __$BrandStateCopyWithImpl<$Res>
    implements _$BrandStateCopyWith<$Res> {
  __$BrandStateCopyWithImpl(this._self, this._then);

  final _BrandState _self;
  final $Res Function(_BrandState) _then;

/// Create a copy of BrandState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? brands = null,Object? errorMessage = freezed,}) {
  return _then(_BrandState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BrandStatus,brands: null == brands ? _self._brands : brands // ignore: cast_nullable_to_non_nullable
as List<Brand>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
