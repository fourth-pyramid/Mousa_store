// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationEvent {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationEvent()';
}


}

/// @nodoc
class $NotificationEventCopyWith<$Res>  {
$NotificationEventCopyWith(NotificationEvent _, $Res Function(NotificationEvent) __);
}


/// Adds pattern-matching-related methods to [NotificationEvent].
extension NotificationEventPatterns on NotificationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( NotificationFetchRequested value)?  fetchRequested,TResult Function( NotificationLoadMoreRequested value)?  loadMoreRequested,TResult Function( NotificationFilterChanged value)?  filterChanged,TResult Function( NotificationMarkReadRequested value)?  markReadRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case NotificationFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case NotificationLoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that);case NotificationFilterChanged() when filterChanged != null:
return filterChanged(_that);case NotificationMarkReadRequested() when markReadRequested != null:
return markReadRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( NotificationFetchRequested value)  fetchRequested,required TResult Function( NotificationLoadMoreRequested value)  loadMoreRequested,required TResult Function( NotificationFilterChanged value)  filterChanged,required TResult Function( NotificationMarkReadRequested value)  markReadRequested,}){
final _that = this;
switch (_that) {
case NotificationFetchRequested():
return fetchRequested(_that);case NotificationLoadMoreRequested():
return loadMoreRequested(_that);case NotificationFilterChanged():
return filterChanged(_that);case NotificationMarkReadRequested():
return markReadRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( NotificationFetchRequested value)?  fetchRequested,TResult? Function( NotificationLoadMoreRequested value)?  loadMoreRequested,TResult? Function( NotificationFilterChanged value)?  filterChanged,TResult? Function( NotificationMarkReadRequested value)?  markReadRequested,}){
final _that = this;
switch (_that) {
case NotificationFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case NotificationLoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that);case NotificationFilterChanged() when filterChanged != null:
return filterChanged(_that);case NotificationMarkReadRequested() when markReadRequested != null:
return markReadRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  fetchRequested,TResult Function()?  loadMoreRequested,TResult Function( int index)?  filterChanged,TResult Function( int notificationId)?  markReadRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case NotificationFetchRequested() when fetchRequested != null:
return fetchRequested();case NotificationLoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested();case NotificationFilterChanged() when filterChanged != null:
return filterChanged(_that.index);case NotificationMarkReadRequested() when markReadRequested != null:
return markReadRequested(_that.notificationId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  fetchRequested,required TResult Function()  loadMoreRequested,required TResult Function( int index)  filterChanged,required TResult Function( int notificationId)  markReadRequested,}) {final _that = this;
switch (_that) {
case NotificationFetchRequested():
return fetchRequested();case NotificationLoadMoreRequested():
return loadMoreRequested();case NotificationFilterChanged():
return filterChanged(_that.index);case NotificationMarkReadRequested():
return markReadRequested(_that.notificationId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  fetchRequested,TResult? Function()?  loadMoreRequested,TResult? Function( int index)?  filterChanged,TResult? Function( int notificationId)?  markReadRequested,}) {final _that = this;
switch (_that) {
case NotificationFetchRequested() when fetchRequested != null:
return fetchRequested();case NotificationLoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested();case NotificationFilterChanged() when filterChanged != null:
return filterChanged(_that.index);case NotificationMarkReadRequested() when markReadRequested != null:
return markReadRequested(_that.notificationId);case _:
  return null;

}
}

}

/// @nodoc


class NotificationFetchRequested implements NotificationEvent {
  const NotificationFetchRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationFetchRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationEvent.fetchRequested()';
}


}




/// @nodoc


class NotificationLoadMoreRequested implements NotificationEvent {
  const NotificationLoadMoreRequested();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationLoadMoreRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'NotificationEvent.loadMoreRequested()';
}


}




/// @nodoc


class NotificationFilterChanged implements NotificationEvent {
  const NotificationFilterChanged(this.index);
  

 final  int index;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationFilterChangedCopyWith<NotificationFilterChanged> get copyWith => _$NotificationFilterChangedCopyWithImpl<NotificationFilterChanged>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationFilterChanged&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode {
    return Object.hash(runtimeType,index);
}

@override
String toString() {
    return 'NotificationEvent.filterChanged(index: $index)';
}


}

/// @nodoc
abstract mixin class $NotificationFilterChangedCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory $NotificationFilterChangedCopyWith(NotificationFilterChanged value, $Res Function(NotificationFilterChanged) _then) = _$NotificationFilterChangedCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$NotificationFilterChangedCopyWithImpl<$Res>
    implements $NotificationFilterChangedCopyWith<$Res> {
  _$NotificationFilterChangedCopyWithImpl(this._self, this._then);

  final NotificationFilterChanged _self;
  final $Res Function(NotificationFilterChanged) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(NotificationFilterChanged(
null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class NotificationMarkReadRequested implements NotificationEvent {
  const NotificationMarkReadRequested(this.notificationId);
  

 final  int notificationId;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationMarkReadRequestedCopyWith<NotificationMarkReadRequested> get copyWith => _$NotificationMarkReadRequestedCopyWithImpl<NotificationMarkReadRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationMarkReadRequested&&(identical(other.notificationId, notificationId) || other.notificationId == notificationId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,notificationId);
}

@override
String toString() {
    return 'NotificationEvent.markReadRequested(notificationId: $notificationId)';
}


}

/// @nodoc
abstract mixin class $NotificationMarkReadRequestedCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory $NotificationMarkReadRequestedCopyWith(NotificationMarkReadRequested value, $Res Function(NotificationMarkReadRequested) _then) = _$NotificationMarkReadRequestedCopyWithImpl;
@useResult
$Res call({
 int notificationId
});




}
/// @nodoc
class _$NotificationMarkReadRequestedCopyWithImpl<$Res>
    implements $NotificationMarkReadRequestedCopyWith<$Res> {
  _$NotificationMarkReadRequestedCopyWithImpl(this._self, this._then);

  final NotificationMarkReadRequested _self;
  final $Res Function(NotificationMarkReadRequested) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? notificationId = null,}) {
  return _then(NotificationMarkReadRequested(
null == notificationId ? _self.notificationId : notificationId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
