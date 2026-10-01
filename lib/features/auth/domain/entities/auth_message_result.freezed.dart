// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_message_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthMessageResult {

 bool get success; String get message; String? get token;
/// Create a copy of AuthMessageResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthMessageResultCopyWith<AuthMessageResult> get copyWith => _$AuthMessageResultCopyWithImpl<AuthMessageResult>(this as AuthMessageResult, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AuthMessageResult;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthMessageResult&&(identical(other.success, _this.success) || other.success == _this.success)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.token, _this.token) || other.token == _this.token));
}


@override
int get hashCode {
  final _this = this as AuthMessageResult;
  return Object.hash(runtimeType,_this.success,_this.message,_this.token);
}

@override
String toString() {
  final _this = this as AuthMessageResult;
  return 'AuthMessageResult(success: ${_this.success}, message: ${_this.message}, token: ${_this.token})';
}


}

/// @nodoc
abstract mixin class $AuthMessageResultCopyWith<$Res>  {
  factory $AuthMessageResultCopyWith(AuthMessageResult value, $Res Function(AuthMessageResult) _then) = _$AuthMessageResultCopyWithImpl;
@useResult
$Res call({
 bool success, String message, String? token
});




}
/// @nodoc
class _$AuthMessageResultCopyWithImpl<$Res>
    implements $AuthMessageResultCopyWith<$Res> {
  _$AuthMessageResultCopyWithImpl(this._self, this._then);

  final AuthMessageResult _self;
  final $Res Function(AuthMessageResult) _then;

/// Create a copy of AuthMessageResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,Object? token = freezed,}) {
  return _then(AuthMessageResult(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthMessageResult].
extension AuthMessageResultPatterns on AuthMessageResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthMessageResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthMessageResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthMessageResult value)  $default,){
final _that = this;
switch (_that) {
case _AuthMessageResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthMessageResult value)?  $default,){
final _that = this;
switch (_that) {
case _AuthMessageResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message,  String? token)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthMessageResult() when $default != null:
return $default(_that.success,_that.message,_that.token);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message,  String? token)  $default,) {final _that = this;
switch (_that) {
case _AuthMessageResult():
return $default(_that.success,_that.message,_that.token);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message,  String? token)?  $default,) {final _that = this;
switch (_that) {
case _AuthMessageResult() when $default != null:
return $default(_that.success,_that.message,_that.token);case _:
  return null;

}
}

}

/// @nodoc


class _AuthMessageResult implements AuthMessageResult {
  const _AuthMessageResult({required this.success, required this.message, this.token});
  

@override final  bool success;
@override final  String message;
@override final  String? token;

/// Create a copy of AuthMessageResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthMessageResultCopyWith<_AuthMessageResult> get copyWith => __$AuthMessageResultCopyWithImpl<_AuthMessageResult>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthMessageResult&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.token, token) || other.token == token));
}


@override
int get hashCode {
    return Object.hash(runtimeType,success,message,token);
}

@override
String toString() {
    return 'AuthMessageResult(success: $success, message: $message, token: $token)';
}


}

/// @nodoc
abstract mixin class _$AuthMessageResultCopyWith<$Res> implements $AuthMessageResultCopyWith<$Res> {
  factory _$AuthMessageResultCopyWith(_AuthMessageResult value, $Res Function(_AuthMessageResult) _then) = __$AuthMessageResultCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message, String? token
});




}
/// @nodoc
class __$AuthMessageResultCopyWithImpl<$Res>
    implements _$AuthMessageResultCopyWith<$Res> {
  __$AuthMessageResultCopyWithImpl(this._self, this._then);

  final _AuthMessageResult _self;
  final $Res Function(_AuthMessageResult) _then;

/// Create a copy of AuthMessageResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,Object? token = freezed,}) {
  return _then(_AuthMessageResult(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,token: freezed == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
