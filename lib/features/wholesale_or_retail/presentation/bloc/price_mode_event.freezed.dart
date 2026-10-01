// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_mode_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PriceModeEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceModeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PriceModeEvent()';
}


}

/// @nodoc
class $PriceModeEventCopyWith<$Res>  {
$PriceModeEventCopyWith(PriceModeEvent _, $Res Function(PriceModeEvent) __);
}


/// Adds pattern-matching-related methods to [PriceModeEvent].
extension PriceModeEventPatterns on PriceModeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PriceModeStarted value)?  started,TResult Function( PriceModeChanged value)?  modeChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PriceModeStarted() when started != null:
return started(_that);case PriceModeChanged() when modeChanged != null:
return modeChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PriceModeStarted value)  started,required TResult Function( PriceModeChanged value)  modeChanged,}){
final _that = this;
switch (_that) {
case PriceModeStarted():
return started(_that);case PriceModeChanged():
return modeChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PriceModeStarted value)?  started,TResult? Function( PriceModeChanged value)?  modeChanged,}){
final _that = this;
switch (_that) {
case PriceModeStarted() when started != null:
return started(_that);case PriceModeChanged() when modeChanged != null:
return modeChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( PriceMode mode)?  modeChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PriceModeStarted() when started != null:
return started();case PriceModeChanged() when modeChanged != null:
return modeChanged(_that.mode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( PriceMode mode)  modeChanged,}) {final _that = this;
switch (_that) {
case PriceModeStarted():
return started();case PriceModeChanged():
return modeChanged(_that.mode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( PriceMode mode)?  modeChanged,}) {final _that = this;
switch (_that) {
case PriceModeStarted() when started != null:
return started();case PriceModeChanged() when modeChanged != null:
return modeChanged(_that.mode);case _:
  return null;

}
}

}

/// @nodoc


class PriceModeStarted implements PriceModeEvent {
  const PriceModeStarted();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceModeStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'PriceModeEvent.started()';
}


}




/// @nodoc


class PriceModeChanged implements PriceModeEvent {
  const PriceModeChanged(this.mode);
  

 final  PriceMode mode;

/// Create a copy of PriceModeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriceModeChangedCopyWith<PriceModeChanged> get copyWith => _$PriceModeChangedCopyWithImpl<PriceModeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceModeChanged&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,mode);
}

@override
String toString() {
    return 'PriceModeEvent.modeChanged(mode: $mode)';
}


}

/// @nodoc
abstract mixin class $PriceModeChangedCopyWith<$Res> implements $PriceModeEventCopyWith<$Res> {
  factory $PriceModeChangedCopyWith(PriceModeChanged value, $Res Function(PriceModeChanged) _then) = _$PriceModeChangedCopyWithImpl;
@useResult
$Res call({
 PriceMode mode
});




}
/// @nodoc
class _$PriceModeChangedCopyWithImpl<$Res>
    implements $PriceModeChangedCopyWith<$Res> {
  _$PriceModeChangedCopyWithImpl(this._self, this._then);

  final PriceModeChanged _self;
  final $Res Function(PriceModeChanged) _then;

/// Create a copy of PriceModeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(PriceModeChanged(
null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as PriceMode,
  ));
}


}

// dart format on
