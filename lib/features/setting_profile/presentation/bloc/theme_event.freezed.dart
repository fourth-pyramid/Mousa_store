// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ThemeEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ThemeEvent()';
}


}

/// @nodoc
class $ThemeEventCopyWith<$Res>  {
$ThemeEventCopyWith(ThemeEvent _, $Res Function(ThemeEvent) __);
}


/// Adds pattern-matching-related methods to [ThemeEvent].
extension ThemeEventPatterns on ThemeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ThemeModeChanged value)?  modeChanged,TResult Function( ThemeToggled value)?  toggled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ThemeModeChanged() when modeChanged != null:
return modeChanged(_that);case ThemeToggled() when toggled != null:
return toggled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ThemeModeChanged value)  modeChanged,required TResult Function( ThemeToggled value)  toggled,}){
final _that = this;
switch (_that) {
case ThemeModeChanged():
return modeChanged(_that);case ThemeToggled():
return toggled(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ThemeModeChanged value)?  modeChanged,TResult? Function( ThemeToggled value)?  toggled,}){
final _that = this;
switch (_that) {
case ThemeModeChanged() when modeChanged != null:
return modeChanged(_that);case ThemeToggled() when toggled != null:
return toggled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ThemeMode mode)?  modeChanged,TResult Function()?  toggled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ThemeModeChanged() when modeChanged != null:
return modeChanged(_that.mode);case ThemeToggled() when toggled != null:
return toggled();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ThemeMode mode)  modeChanged,required TResult Function()  toggled,}) {final _that = this;
switch (_that) {
case ThemeModeChanged():
return modeChanged(_that.mode);case ThemeToggled():
return toggled();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ThemeMode mode)?  modeChanged,TResult? Function()?  toggled,}) {final _that = this;
switch (_that) {
case ThemeModeChanged() when modeChanged != null:
return modeChanged(_that.mode);case ThemeToggled() when toggled != null:
return toggled();case _:
  return null;

}
}

}

/// @nodoc


class ThemeModeChanged implements ThemeEvent {
  const ThemeModeChanged(this.mode);
  

 final  ThemeMode mode;

/// Create a copy of ThemeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeModeChangedCopyWith<ThemeModeChanged> get copyWith => _$ThemeModeChangedCopyWithImpl<ThemeModeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeModeChanged&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,mode);
}

@override
String toString() {
    return 'ThemeEvent.modeChanged(mode: $mode)';
}


}

/// @nodoc
abstract mixin class $ThemeModeChangedCopyWith<$Res> implements $ThemeEventCopyWith<$Res> {
  factory $ThemeModeChangedCopyWith(ThemeModeChanged value, $Res Function(ThemeModeChanged) _then) = _$ThemeModeChangedCopyWithImpl;
@useResult
$Res call({
 ThemeMode mode
});




}
/// @nodoc
class _$ThemeModeChangedCopyWithImpl<$Res>
    implements $ThemeModeChangedCopyWith<$Res> {
  _$ThemeModeChangedCopyWithImpl(this._self, this._then);

  final ThemeModeChanged _self;
  final $Res Function(ThemeModeChanged) _then;

/// Create a copy of ThemeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(ThemeModeChanged(
null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ThemeMode,
  ));
}


}

/// @nodoc


class ThemeToggled implements ThemeEvent {
  const ThemeToggled();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ThemeEvent.toggled()';
}


}




// dart format on
