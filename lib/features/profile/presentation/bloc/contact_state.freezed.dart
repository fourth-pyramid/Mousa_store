// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contact_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ContactState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ContactState()';
}


}

/// @nodoc
class $ContactStateCopyWith<$Res>  {
$ContactStateCopyWith(ContactState _, $Res Function(ContactState) __);
}


/// Adds pattern-matching-related methods to [ContactState].
extension ContactStatePatterns on ContactState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ContactInitial value)?  initial,TResult Function( ContactLoading value)?  loading,TResult Function( ContactLoaded value)?  loaded,TResult Function( ContactError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ContactInitial() when initial != null:
return initial(_that);case ContactLoading() when loading != null:
return loading(_that);case ContactLoaded() when loaded != null:
return loaded(_that);case ContactError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ContactInitial value)  initial,required TResult Function( ContactLoading value)  loading,required TResult Function( ContactLoaded value)  loaded,required TResult Function( ContactError value)  error,}){
final _that = this;
switch (_that) {
case ContactInitial():
return initial(_that);case ContactLoading():
return loading(_that);case ContactLoaded():
return loaded(_that);case ContactError():
return error(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ContactInitial value)?  initial,TResult? Function( ContactLoading value)?  loading,TResult? Function( ContactLoaded value)?  loaded,TResult? Function( ContactError value)?  error,}){
final _that = this;
switch (_that) {
case ContactInitial() when initial != null:
return initial(_that);case ContactLoading() when loading != null:
return loading(_that);case ContactLoaded() when loaded != null:
return loaded(_that);case ContactError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ContactModel contact)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ContactInitial() when initial != null:
return initial();case ContactLoading() when loading != null:
return loading();case ContactLoaded() when loaded != null:
return loaded(_that.contact);case ContactError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ContactModel contact)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ContactInitial():
return initial();case ContactLoading():
return loading();case ContactLoaded():
return loaded(_that.contact);case ContactError():
return error(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ContactModel contact)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ContactInitial() when initial != null:
return initial();case ContactLoading() when loading != null:
return loading();case ContactLoaded() when loaded != null:
return loaded(_that.contact);case ContactError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ContactInitial implements ContactState {
  const ContactInitial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ContactState.initial()';
}


}




/// @nodoc


class ContactLoading implements ContactState {
  const ContactLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ContactState.loading()';
}


}




/// @nodoc


class ContactLoaded implements ContactState {
  const ContactLoaded(this.contact);
  

 final  ContactModel contact;

/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactLoadedCopyWith<ContactLoaded> get copyWith => _$ContactLoadedCopyWithImpl<ContactLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactLoaded&&(identical(other.contact, contact) || other.contact == contact));
}


@override
int get hashCode {
    return Object.hash(runtimeType,contact);
}

@override
String toString() {
    return 'ContactState.loaded(contact: $contact)';
}


}

/// @nodoc
abstract mixin class $ContactLoadedCopyWith<$Res> implements $ContactStateCopyWith<$Res> {
  factory $ContactLoadedCopyWith(ContactLoaded value, $Res Function(ContactLoaded) _then) = _$ContactLoadedCopyWithImpl;
@useResult
$Res call({
 ContactModel contact
});




}
/// @nodoc
class _$ContactLoadedCopyWithImpl<$Res>
    implements $ContactLoadedCopyWith<$Res> {
  _$ContactLoadedCopyWithImpl(this._self, this._then);

  final ContactLoaded _self;
  final $Res Function(ContactLoaded) _then;

/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? contact = null,}) {
  return _then(ContactLoaded(
null == contact ? _self.contact : contact // ignore: cast_nullable_to_non_nullable
as ContactModel,
  ));
}


}

/// @nodoc


class ContactError implements ContactState {
  const ContactError(this.message);
  

 final  String message;

/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ContactErrorCopyWith<ContactError> get copyWith => _$ContactErrorCopyWithImpl<ContactError>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ContactError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'ContactState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ContactErrorCopyWith<$Res> implements $ContactStateCopyWith<$Res> {
  factory $ContactErrorCopyWith(ContactError value, $Res Function(ContactError) _then) = _$ContactErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ContactErrorCopyWithImpl<$Res>
    implements $ContactErrorCopyWith<$Res> {
  _$ContactErrorCopyWithImpl(this._self, this._then);

  final ContactError _self;
  final $Res Function(ContactError) _then;

/// Create a copy of ContactState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ContactError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
