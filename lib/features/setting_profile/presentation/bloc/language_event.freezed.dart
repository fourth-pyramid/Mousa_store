// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'language_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LanguageEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LanguageEvent()';
}


}

/// @nodoc
class $LanguageEventCopyWith<$Res>  {
$LanguageEventCopyWith(LanguageEvent _, $Res Function(LanguageEvent) __);
}


/// Adds pattern-matching-related methods to [LanguageEvent].
extension LanguageEventPatterns on LanguageEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LanguageLoaded value)?  loaded,TResult Function( LanguageChanged value)?  changed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LanguageLoaded() when loaded != null:
return loaded(_that);case LanguageChanged() when changed != null:
return changed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LanguageLoaded value)  loaded,required TResult Function( LanguageChanged value)  changed,}){
final _that = this;
switch (_that) {
case LanguageLoaded():
return loaded(_that);case LanguageChanged():
return changed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LanguageLoaded value)?  loaded,TResult? Function( LanguageChanged value)?  changed,}){
final _that = this;
switch (_that) {
case LanguageLoaded() when loaded != null:
return loaded(_that);case LanguageChanged() when changed != null:
return changed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loaded,TResult Function( Locale locale)?  changed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LanguageLoaded() when loaded != null:
return loaded();case LanguageChanged() when changed != null:
return changed(_that.locale);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loaded,required TResult Function( Locale locale)  changed,}) {final _that = this;
switch (_that) {
case LanguageLoaded():
return loaded();case LanguageChanged():
return changed(_that.locale);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loaded,TResult? Function( Locale locale)?  changed,}) {final _that = this;
switch (_that) {
case LanguageLoaded() when loaded != null:
return loaded();case LanguageChanged() when changed != null:
return changed(_that.locale);case _:
  return null;

}
}

}

/// @nodoc


class LanguageLoaded implements LanguageEvent {
  const LanguageLoaded();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'LanguageEvent.loaded()';
}


}




/// @nodoc


class LanguageChanged implements LanguageEvent {
  const LanguageChanged(this.locale);
  

 final  Locale locale;

/// Create a copy of LanguageEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanguageChangedCopyWith<LanguageChanged> get copyWith => _$LanguageChangedCopyWithImpl<LanguageChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageChanged&&(identical(other.locale, locale) || other.locale == locale));
}


@override
int get hashCode {
    return Object.hash(runtimeType,locale);
}

@override
String toString() {
    return 'LanguageEvent.changed(locale: $locale)';
}


}

/// @nodoc
abstract mixin class $LanguageChangedCopyWith<$Res> implements $LanguageEventCopyWith<$Res> {
  factory $LanguageChangedCopyWith(LanguageChanged value, $Res Function(LanguageChanged) _then) = _$LanguageChangedCopyWithImpl;
@useResult
$Res call({
 Locale locale
});




}
/// @nodoc
class _$LanguageChangedCopyWithImpl<$Res>
    implements $LanguageChangedCopyWith<$Res> {
  _$LanguageChangedCopyWithImpl(this._self, this._then);

  final LanguageChanged _self;
  final $Res Function(LanguageChanged) _then;

/// Create a copy of LanguageEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? locale = null,}) {
  return _then(LanguageChanged(
null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,
  ));
}


}

// dart format on
