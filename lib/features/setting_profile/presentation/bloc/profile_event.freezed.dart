// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProfileEvent()';
}


}

/// @nodoc
class $ProfileEventCopyWith<$Res>  {
$ProfileEventCopyWith(ProfileEvent _, $Res Function(ProfileEvent) __);
}


/// Adds pattern-matching-related methods to [ProfileEvent].
extension ProfileEventPatterns on ProfileEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProfileFetchRequested value)?  fetchRequested,TResult Function( ProfileNameUpdated value)?  nameUpdated,TResult Function( ProfileEmailUpdated value)?  emailUpdated,TResult Function( ProfilePhoneUpdated value)?  phoneUpdated,TResult Function( ProfilePasswordChanged value)?  passwordChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProfileFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case ProfileNameUpdated() when nameUpdated != null:
return nameUpdated(_that);case ProfileEmailUpdated() when emailUpdated != null:
return emailUpdated(_that);case ProfilePhoneUpdated() when phoneUpdated != null:
return phoneUpdated(_that);case ProfilePasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProfileFetchRequested value)  fetchRequested,required TResult Function( ProfileNameUpdated value)  nameUpdated,required TResult Function( ProfileEmailUpdated value)  emailUpdated,required TResult Function( ProfilePhoneUpdated value)  phoneUpdated,required TResult Function( ProfilePasswordChanged value)  passwordChanged,}){
final _that = this;
switch (_that) {
case ProfileFetchRequested():
return fetchRequested(_that);case ProfileNameUpdated():
return nameUpdated(_that);case ProfileEmailUpdated():
return emailUpdated(_that);case ProfilePhoneUpdated():
return phoneUpdated(_that);case ProfilePasswordChanged():
return passwordChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProfileFetchRequested value)?  fetchRequested,TResult? Function( ProfileNameUpdated value)?  nameUpdated,TResult? Function( ProfileEmailUpdated value)?  emailUpdated,TResult? Function( ProfilePhoneUpdated value)?  phoneUpdated,TResult? Function( ProfilePasswordChanged value)?  passwordChanged,}){
final _that = this;
switch (_that) {
case ProfileFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case ProfileNameUpdated() when nameUpdated != null:
return nameUpdated(_that);case ProfileEmailUpdated() when emailUpdated != null:
return emailUpdated(_that);case ProfilePhoneUpdated() when phoneUpdated != null:
return phoneUpdated(_that);case ProfilePasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchRequested,TResult Function( String? firstName,  String? lastName)?  nameUpdated,TResult Function( String email)?  emailUpdated,TResult Function( String phone)?  phoneUpdated,TResult Function( String oldPassword,  String password,  String confirmPassword)?  passwordChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProfileFetchRequested() when fetchRequested != null:
return fetchRequested();case ProfileNameUpdated() when nameUpdated != null:
return nameUpdated(_that.firstName,_that.lastName);case ProfileEmailUpdated() when emailUpdated != null:
return emailUpdated(_that.email);case ProfilePhoneUpdated() when phoneUpdated != null:
return phoneUpdated(_that.phone);case ProfilePasswordChanged() when passwordChanged != null:
return passwordChanged(_that.oldPassword,_that.password,_that.confirmPassword);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchRequested,required TResult Function( String? firstName,  String? lastName)  nameUpdated,required TResult Function( String email)  emailUpdated,required TResult Function( String phone)  phoneUpdated,required TResult Function( String oldPassword,  String password,  String confirmPassword)  passwordChanged,}) {final _that = this;
switch (_that) {
case ProfileFetchRequested():
return fetchRequested();case ProfileNameUpdated():
return nameUpdated(_that.firstName,_that.lastName);case ProfileEmailUpdated():
return emailUpdated(_that.email);case ProfilePhoneUpdated():
return phoneUpdated(_that.phone);case ProfilePasswordChanged():
return passwordChanged(_that.oldPassword,_that.password,_that.confirmPassword);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchRequested,TResult? Function( String? firstName,  String? lastName)?  nameUpdated,TResult? Function( String email)?  emailUpdated,TResult? Function( String phone)?  phoneUpdated,TResult? Function( String oldPassword,  String password,  String confirmPassword)?  passwordChanged,}) {final _that = this;
switch (_that) {
case ProfileFetchRequested() when fetchRequested != null:
return fetchRequested();case ProfileNameUpdated() when nameUpdated != null:
return nameUpdated(_that.firstName,_that.lastName);case ProfileEmailUpdated() when emailUpdated != null:
return emailUpdated(_that.email);case ProfilePhoneUpdated() when phoneUpdated != null:
return phoneUpdated(_that.phone);case ProfilePasswordChanged() when passwordChanged != null:
return passwordChanged(_that.oldPassword,_that.password,_that.confirmPassword);case _:
  return null;

}
}

}

/// @nodoc


class ProfileFetchRequested implements ProfileEvent {
  const ProfileFetchRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileFetchRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'ProfileEvent.fetchRequested()';
}


}




/// @nodoc


class ProfileNameUpdated implements ProfileEvent {
  const ProfileNameUpdated({this.firstName, this.lastName});
  

 final  String? firstName;
 final  String? lastName;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileNameUpdatedCopyWith<ProfileNameUpdated> get copyWith => _$ProfileNameUpdatedCopyWithImpl<ProfileNameUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileNameUpdated&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName));
}


@override
int get hashCode {
    return Object.hash(runtimeType,firstName,lastName);
}

@override
String toString() {
    return 'ProfileEvent.nameUpdated(firstName: $firstName, lastName: $lastName)';
}


}

/// @nodoc
abstract mixin class $ProfileNameUpdatedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $ProfileNameUpdatedCopyWith(ProfileNameUpdated value, $Res Function(ProfileNameUpdated) _then) = _$ProfileNameUpdatedCopyWithImpl;
@useResult
$Res call({
 String? firstName, String? lastName
});




}
/// @nodoc
class _$ProfileNameUpdatedCopyWithImpl<$Res>
    implements $ProfileNameUpdatedCopyWith<$Res> {
  _$ProfileNameUpdatedCopyWithImpl(this._self, this._then);

  final ProfileNameUpdated _self;
  final $Res Function(ProfileNameUpdated) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? firstName = freezed,Object? lastName = freezed,}) {
  return _then(ProfileNameUpdated(
firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ProfileEmailUpdated implements ProfileEvent {
  const ProfileEmailUpdated({required this.email});
  

 final  String email;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileEmailUpdatedCopyWith<ProfileEmailUpdated> get copyWith => _$ProfileEmailUpdatedCopyWithImpl<ProfileEmailUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEmailUpdated&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode {
    return Object.hash(runtimeType,email);
}

@override
String toString() {
    return 'ProfileEvent.emailUpdated(email: $email)';
}


}

/// @nodoc
abstract mixin class $ProfileEmailUpdatedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $ProfileEmailUpdatedCopyWith(ProfileEmailUpdated value, $Res Function(ProfileEmailUpdated) _then) = _$ProfileEmailUpdatedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$ProfileEmailUpdatedCopyWithImpl<$Res>
    implements $ProfileEmailUpdatedCopyWith<$Res> {
  _$ProfileEmailUpdatedCopyWithImpl(this._self, this._then);

  final ProfileEmailUpdated _self;
  final $Res Function(ProfileEmailUpdated) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(ProfileEmailUpdated(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ProfilePhoneUpdated implements ProfileEvent {
  const ProfilePhoneUpdated({required this.phone});
  

 final  String phone;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfilePhoneUpdatedCopyWith<ProfilePhoneUpdated> get copyWith => _$ProfilePhoneUpdatedCopyWithImpl<ProfilePhoneUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfilePhoneUpdated&&(identical(other.phone, phone) || other.phone == phone));
}


@override
int get hashCode {
    return Object.hash(runtimeType,phone);
}

@override
String toString() {
    return 'ProfileEvent.phoneUpdated(phone: $phone)';
}


}

/// @nodoc
abstract mixin class $ProfilePhoneUpdatedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $ProfilePhoneUpdatedCopyWith(ProfilePhoneUpdated value, $Res Function(ProfilePhoneUpdated) _then) = _$ProfilePhoneUpdatedCopyWithImpl;
@useResult
$Res call({
 String phone
});




}
/// @nodoc
class _$ProfilePhoneUpdatedCopyWithImpl<$Res>
    implements $ProfilePhoneUpdatedCopyWith<$Res> {
  _$ProfilePhoneUpdatedCopyWithImpl(this._self, this._then);

  final ProfilePhoneUpdated _self;
  final $Res Function(ProfilePhoneUpdated) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? phone = null,}) {
  return _then(ProfilePhoneUpdated(
phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ProfilePasswordChanged implements ProfileEvent {
  const ProfilePasswordChanged({required this.oldPassword, required this.password, required this.confirmPassword});
  

 final  String oldPassword;
 final  String password;
 final  String confirmPassword;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfilePasswordChangedCopyWith<ProfilePasswordChanged> get copyWith => _$ProfilePasswordChangedCopyWithImpl<ProfilePasswordChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfilePasswordChanged&&(identical(other.oldPassword, oldPassword) || other.oldPassword == oldPassword)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword));
}


@override
int get hashCode {
    return Object.hash(runtimeType,oldPassword,password,confirmPassword);
}

@override
String toString() {
    return 'ProfileEvent.passwordChanged(oldPassword: $oldPassword, password: $password, confirmPassword: $confirmPassword)';
}


}

/// @nodoc
abstract mixin class $ProfilePasswordChangedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $ProfilePasswordChangedCopyWith(ProfilePasswordChanged value, $Res Function(ProfilePasswordChanged) _then) = _$ProfilePasswordChangedCopyWithImpl;
@useResult
$Res call({
 String oldPassword, String password, String confirmPassword
});




}
/// @nodoc
class _$ProfilePasswordChangedCopyWithImpl<$Res>
    implements $ProfilePasswordChangedCopyWith<$Res> {
  _$ProfilePasswordChangedCopyWithImpl(this._self, this._then);

  final ProfilePasswordChanged _self;
  final $Res Function(ProfilePasswordChanged) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? oldPassword = null,Object? password = null,Object? confirmPassword = null,}) {
  return _then(ProfilePasswordChanged(
oldPassword: null == oldPassword ? _self.oldPassword : oldPassword // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
