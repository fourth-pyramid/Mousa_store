// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reset_password_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ResetPasswordEvent {

 String get email; String get newPassword; String get passwordConfirm; String get resetToken;
/// Create a copy of ResetPasswordEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordEventCopyWith<ResetPasswordEvent> get copyWith => _$ResetPasswordEventCopyWithImpl<ResetPasswordEvent>(this as ResetPasswordEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ResetPasswordEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordEvent&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.newPassword, _this.newPassword) || other.newPassword == _this.newPassword)&&(identical(other.passwordConfirm, _this.passwordConfirm) || other.passwordConfirm == _this.passwordConfirm)&&(identical(other.resetToken, _this.resetToken) || other.resetToken == _this.resetToken));
}


@override
int get hashCode {
  final _this = this as ResetPasswordEvent;
  return Object.hash(runtimeType,_this.email,_this.newPassword,_this.passwordConfirm,_this.resetToken);
}

@override
String toString() {
  final _this = this as ResetPasswordEvent;
  return 'ResetPasswordEvent(email: ${_this.email}, newPassword: ${_this.newPassword}, passwordConfirm: ${_this.passwordConfirm}, resetToken: ${_this.resetToken})';
}


}

/// @nodoc
abstract mixin class $ResetPasswordEventCopyWith<$Res>  {
  factory $ResetPasswordEventCopyWith(ResetPasswordEvent value, $Res Function(ResetPasswordEvent) _then) = _$ResetPasswordEventCopyWithImpl;
@useResult
$Res call({
 String email, String newPassword, String passwordConfirm, String resetToken
});




}
/// @nodoc
class _$ResetPasswordEventCopyWithImpl<$Res>
    implements $ResetPasswordEventCopyWith<$Res> {
  _$ResetPasswordEventCopyWithImpl(this._self, this._then);

  final ResetPasswordEvent _self;
  final $Res Function(ResetPasswordEvent) _then;

/// Create a copy of ResetPasswordEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? newPassword = null,Object? passwordConfirm = null,Object? resetToken = null,}) {
  return _then(ResetPasswordEvent.submitted(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,passwordConfirm: null == passwordConfirm ? _self.passwordConfirm : passwordConfirm // ignore: cast_nullable_to_non_nullable
as String,resetToken: null == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ResetPasswordEvent].
extension ResetPasswordEventPatterns on ResetPasswordEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ResetPasswordSubmitted value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ResetPasswordSubmitted() when submitted != null:
return submitted(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ResetPasswordSubmitted value)  submitted,}){
final _that = this;
switch (_that) {
case ResetPasswordSubmitted():
return submitted(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ResetPasswordSubmitted value)?  submitted,}){
final _that = this;
switch (_that) {
case ResetPasswordSubmitted() when submitted != null:
return submitted(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String email,  String newPassword,  String passwordConfirm,  String resetToken)?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ResetPasswordSubmitted() when submitted != null:
return submitted(_that.email,_that.newPassword,_that.passwordConfirm,_that.resetToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String email,  String newPassword,  String passwordConfirm,  String resetToken)  submitted,}) {final _that = this;
switch (_that) {
case ResetPasswordSubmitted():
return submitted(_that.email,_that.newPassword,_that.passwordConfirm,_that.resetToken);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String email,  String newPassword,  String passwordConfirm,  String resetToken)?  submitted,}) {final _that = this;
switch (_that) {
case ResetPasswordSubmitted() when submitted != null:
return submitted(_that.email,_that.newPassword,_that.passwordConfirm,_that.resetToken);case _:
  return null;

}
}

}

/// @nodoc


class ResetPasswordSubmitted implements ResetPasswordEvent {
  const ResetPasswordSubmitted({required this.email, required this.newPassword, required this.passwordConfirm, required this.resetToken});
  

@override final  String email;
@override final  String newPassword;
@override final  String passwordConfirm;
@override final  String resetToken;

/// Create a copy of ResetPasswordEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResetPasswordSubmittedCopyWith<ResetPasswordSubmitted> get copyWith => _$ResetPasswordSubmittedCopyWithImpl<ResetPasswordSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ResetPasswordSubmitted&&(identical(other.email, email) || other.email == email)&&(identical(other.newPassword, newPassword) || other.newPassword == newPassword)&&(identical(other.passwordConfirm, passwordConfirm) || other.passwordConfirm == passwordConfirm)&&(identical(other.resetToken, resetToken) || other.resetToken == resetToken));
}


@override
int get hashCode {
    return Object.hash(runtimeType,email,newPassword,passwordConfirm,resetToken);
}

@override
String toString() {
    return 'ResetPasswordEvent.submitted(email: $email, newPassword: $newPassword, passwordConfirm: $passwordConfirm, resetToken: $resetToken)';
}


}

/// @nodoc
abstract mixin class $ResetPasswordSubmittedCopyWith<$Res> implements $ResetPasswordEventCopyWith<$Res> {
  factory $ResetPasswordSubmittedCopyWith(ResetPasswordSubmitted value, $Res Function(ResetPasswordSubmitted) _then) = _$ResetPasswordSubmittedCopyWithImpl;
@override @useResult
$Res call({
 String email, String newPassword, String passwordConfirm, String resetToken
});




}
/// @nodoc
class _$ResetPasswordSubmittedCopyWithImpl<$Res>
    implements $ResetPasswordSubmittedCopyWith<$Res> {
  _$ResetPasswordSubmittedCopyWithImpl(this._self, this._then);

  final ResetPasswordSubmitted _self;
  final $Res Function(ResetPasswordSubmitted) _then;

/// Create a copy of ResetPasswordEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? newPassword = null,Object? passwordConfirm = null,Object? resetToken = null,}) {
  return _then(ResetPasswordSubmitted(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,newPassword: null == newPassword ? _self.newPassword : newPassword // ignore: cast_nullable_to_non_nullable
as String,passwordConfirm: null == passwordConfirm ? _self.passwordConfirm : passwordConfirm // ignore: cast_nullable_to_non_nullable
as String,resetToken: null == resetToken ? _self.resetToken : resetToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
