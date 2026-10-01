// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignupEvent {

 String get firstName; String get lastName; String get email; String get phone; String get password; String get passwordConfirmation;
/// Create a copy of SignupEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupEventCopyWith<SignupEvent> get copyWith => _$SignupEventCopyWithImpl<SignupEvent>(this as SignupEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SignupEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupEvent&&(identical(other.firstName, _this.firstName) || other.firstName == _this.firstName)&&(identical(other.lastName, _this.lastName) || other.lastName == _this.lastName)&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.phone, _this.phone) || other.phone == _this.phone)&&(identical(other.password, _this.password) || other.password == _this.password)&&(identical(other.passwordConfirmation, _this.passwordConfirmation) || other.passwordConfirmation == _this.passwordConfirmation));
}


@override
int get hashCode {
  final _this = this as SignupEvent;
  return Object.hash(runtimeType,_this.firstName,_this.lastName,_this.email,_this.phone,_this.password,_this.passwordConfirmation);
}

@override
String toString() {
  final _this = this as SignupEvent;
  return 'SignupEvent(firstName: ${_this.firstName}, lastName: ${_this.lastName}, email: ${_this.email}, phone: ${_this.phone}, password: ${_this.password}, passwordConfirmation: ${_this.passwordConfirmation})';
}


}

/// @nodoc
abstract mixin class $SignupEventCopyWith<$Res>  {
  factory $SignupEventCopyWith(SignupEvent value, $Res Function(SignupEvent) _then) = _$SignupEventCopyWithImpl;
@useResult
$Res call({
 String firstName, String lastName, String email, String phone, String password, String passwordConfirmation
});




}
/// @nodoc
class _$SignupEventCopyWithImpl<$Res>
    implements $SignupEventCopyWith<$Res> {
  _$SignupEventCopyWithImpl(this._self, this._then);

  final SignupEvent _self;
  final $Res Function(SignupEvent) _then;

/// Create a copy of SignupEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? lastName = null,Object? email = null,Object? phone = null,Object? password = null,Object? passwordConfirmation = null,}) {
  return _then(SignupEvent.submitted(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,passwordConfirmation: null == passwordConfirmation ? _self.passwordConfirmation : passwordConfirmation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SignupEvent].
extension SignupEventPatterns on SignupEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SignupSubmitted value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SignupSubmitted() when submitted != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SignupSubmitted value)  submitted,}){
final _that = this;
switch (_that) {
case SignupSubmitted():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SignupSubmitted value)?  submitted,}){
final _that = this;
switch (_that) {
case SignupSubmitted() when submitted != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String firstName,  String lastName,  String email,  String phone,  String password,  String passwordConfirmation)?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SignupSubmitted() when submitted != null:
return submitted(_that.firstName,_that.lastName,_that.email,_that.phone,_that.password,_that.passwordConfirmation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String firstName,  String lastName,  String email,  String phone,  String password,  String passwordConfirmation)  submitted,}) {final _that = this;
switch (_that) {
case SignupSubmitted():
return submitted(_that.firstName,_that.lastName,_that.email,_that.phone,_that.password,_that.passwordConfirmation);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String firstName,  String lastName,  String email,  String phone,  String password,  String passwordConfirmation)?  submitted,}) {final _that = this;
switch (_that) {
case SignupSubmitted() when submitted != null:
return submitted(_that.firstName,_that.lastName,_that.email,_that.phone,_that.password,_that.passwordConfirmation);case _:
  return null;

}
}

}

/// @nodoc


class SignupSubmitted implements SignupEvent {
  const SignupSubmitted({required this.firstName, required this.lastName, required this.email, required this.phone, required this.password, required this.passwordConfirmation});
  

@override final  String firstName;
@override final  String lastName;
@override final  String email;
@override final  String phone;
@override final  String password;
@override final  String passwordConfirmation;

/// Create a copy of SignupEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignupSubmittedCopyWith<SignupSubmitted> get copyWith => _$SignupSubmittedCopyWithImpl<SignupSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is SignupSubmitted&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.password, password) || other.password == password)&&(identical(other.passwordConfirmation, passwordConfirmation) || other.passwordConfirmation == passwordConfirmation));
}


@override
int get hashCode {
    return Object.hash(runtimeType,firstName,lastName,email,phone,password,passwordConfirmation);
}

@override
String toString() {
    return 'SignupEvent.submitted(firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, password: $password, passwordConfirmation: $passwordConfirmation)';
}


}

/// @nodoc
abstract mixin class $SignupSubmittedCopyWith<$Res> implements $SignupEventCopyWith<$Res> {
  factory $SignupSubmittedCopyWith(SignupSubmitted value, $Res Function(SignupSubmitted) _then) = _$SignupSubmittedCopyWithImpl;
@override @useResult
$Res call({
 String firstName, String lastName, String email, String phone, String password, String passwordConfirmation
});




}
/// @nodoc
class _$SignupSubmittedCopyWithImpl<$Res>
    implements $SignupSubmittedCopyWith<$Res> {
  _$SignupSubmittedCopyWithImpl(this._self, this._then);

  final SignupSubmitted _self;
  final $Res Function(SignupSubmitted) _then;

/// Create a copy of SignupEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? email = null,Object? phone = null,Object? password = null,Object? passwordConfirmation = null,}) {
  return _then(SignupSubmitted(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,passwordConfirmation: null == passwordConfirmation ? _self.passwordConfirmation : passwordConfirmation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
