// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ResetPasswordState {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ResetPasswordState()';
}


}

/// @nodoc
class $ResetPasswordStateCopyWith<$Res>  {
$ResetPasswordStateCopyWith(ResetPasswordState _, $Res Function(ResetPasswordState) __);
}


/// Adds pattern-matching-related methods to [ResetPasswordState].
extension ResetPasswordStatePatterns on ResetPasswordState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ResetPasswordInitial value)?  initial,TResult Function( ResetPasswordLoading value)?  loading,TResult Function( ResetPasswordSuccess value)?  success,TResult Function( ResetPasswordFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ResetPasswordInitial() when initial != null:
return initial(_that);case ResetPasswordLoading() when loading != null:
return loading(_that);case ResetPasswordSuccess() when success != null:
return success(_that);case ResetPasswordFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ResetPasswordInitial value)  initial,required TResult Function( ResetPasswordLoading value)  loading,required TResult Function( ResetPasswordSuccess value)  success,required TResult Function( ResetPasswordFailure value)  failure,}){
final _that = this;
switch (_that) {
case ResetPasswordInitial():
return initial(_that);case ResetPasswordLoading():
return loading(_that);case ResetPasswordSuccess():
return success(_that);case ResetPasswordFailure():
return failure(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ResetPasswordInitial value)?  initial,TResult? Function( ResetPasswordLoading value)?  loading,TResult? Function( ResetPasswordSuccess value)?  success,TResult? Function( ResetPasswordFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ResetPasswordInitial() when initial != null:
return initial(_that);case ResetPasswordLoading() when loading != null:
return loading(_that);case ResetPasswordSuccess() when success != null:
return success(_that);case ResetPasswordFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( OtpResponse response)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ResetPasswordInitial() when initial != null:
return initial();case ResetPasswordLoading() when loading != null:
return loading();case ResetPasswordSuccess() when success != null:
return success(_that.response);case ResetPasswordFailure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( OtpResponse response)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case ResetPasswordInitial():
return initial();case ResetPasswordLoading():
return loading();case ResetPasswordSuccess():
return success(_that.response);case ResetPasswordFailure():
return failure(_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( OtpResponse response)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case ResetPasswordInitial() when initial != null:
return initial();case ResetPasswordLoading() when loading != null:
return loading();case ResetPasswordSuccess() when success != null:
return success(_that.response);case ResetPasswordFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ResetPasswordInitial implements ResetPasswordState {
  const ResetPasswordInitial();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ResetPasswordState.initial()';
}


}




/// @nodoc


class ResetPasswordLoading implements ResetPasswordState {
  const ResetPasswordLoading();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ResetPasswordState.loading()';
}


}




/// @nodoc


class ResetPasswordSuccess implements ResetPasswordState {
  const ResetPasswordSuccess(this.response);
  

 final  OtpResponse response;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordSuccessCopyWith<ResetPasswordSuccess> get copyWith => _$ResetPasswordSuccessCopyWithImpl<ResetPasswordSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordSuccess&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode {
    return Object.hash(runtimeType,response);
}

@override
String toString() {
    return 'ResetPasswordState.success(response: $response)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordSuccessCopyWith<$Res> implements $ResetPasswordStateCopyWith<$Res> {
  factory $ResetPasswordSuccessCopyWith(ResetPasswordSuccess value, $Res Function(ResetPasswordSuccess) _then) = _$ResetPasswordSuccessCopyWithImpl;
@useResult
$Res call({
 OtpResponse response
});




}
/// @nodoc
class _$ResetPasswordSuccessCopyWithImpl<$Res>
    implements $ResetPasswordSuccessCopyWith<$Res> {
  _$ResetPasswordSuccessCopyWithImpl(this._self, this._then);

  final ResetPasswordSuccess _self;
  final $Res Function(ResetPasswordSuccess) _then;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(ResetPasswordSuccess(
null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as OtpResponse,
  ));
}


}

/// @nodoc


class ResetPasswordFailure implements ResetPasswordState {
  const ResetPasswordFailure(this.message);
  

 final  String message;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordFailureCopyWith<ResetPasswordFailure> get copyWith => _$ResetPasswordFailureCopyWithImpl<ResetPasswordFailure>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'ResetPasswordState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordFailureCopyWith<$Res> implements $ResetPasswordStateCopyWith<$Res> {
  factory $ResetPasswordFailureCopyWith(ResetPasswordFailure value, $Res Function(ResetPasswordFailure) _then) = _$ResetPasswordFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ResetPasswordFailureCopyWithImpl<$Res>
    implements $ResetPasswordFailureCopyWith<$Res> {
  _$ResetPasswordFailureCopyWithImpl(this._self, this._then);

  final ResetPasswordFailure _self;
  final $Res Function(ResetPasswordFailure) _then;

/// Create a copy of ResetPasswordState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ResetPasswordFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
