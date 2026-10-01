// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationState {

 NotificationStatus get status; List<NotificationModel> get notifications; List<NotificationModel> get filteredNotifications; int get selectedIndex; int get allCount; int get ordersCount; int get offersCount; int get alertsCount; String? get errorMessage; int get currentPage; int get lastPage; int get total; bool get isFetchingMore;
/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationStateCopyWith<NotificationState> get copyWith => _$NotificationStateCopyWithImpl<NotificationState>(this as NotificationState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as NotificationState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationState&&(identical(other.status, _this.status) || other.status == _this.status)&&const DeepCollectionEquality().equals(other.notifications, _this.notifications)&&const DeepCollectionEquality().equals(other.filteredNotifications, _this.filteredNotifications)&&(identical(other.selectedIndex, _this.selectedIndex) || other.selectedIndex == _this.selectedIndex)&&(identical(other.allCount, _this.allCount) || other.allCount == _this.allCount)&&(identical(other.ordersCount, _this.ordersCount) || other.ordersCount == _this.ordersCount)&&(identical(other.offersCount, _this.offersCount) || other.offersCount == _this.offersCount)&&(identical(other.alertsCount, _this.alertsCount) || other.alertsCount == _this.alertsCount)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage)&&(identical(other.currentPage, _this.currentPage) || other.currentPage == _this.currentPage)&&(identical(other.lastPage, _this.lastPage) || other.lastPage == _this.lastPage)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.isFetchingMore, _this.isFetchingMore) || other.isFetchingMore == _this.isFetchingMore));
}


@override
int get hashCode {
  final _this = this as NotificationState;
  return Object.hash(runtimeType,_this.status,const DeepCollectionEquality().hash(_this.notifications),const DeepCollectionEquality().hash(_this.filteredNotifications),_this.selectedIndex,_this.allCount,_this.ordersCount,_this.offersCount,_this.alertsCount,_this.errorMessage,_this.currentPage,_this.lastPage,_this.total,_this.isFetchingMore);
}

@override
String toString() {
  final _this = this as NotificationState;
  return 'NotificationState(status: ${_this.status}, notifications: ${_this.notifications}, filteredNotifications: ${_this.filteredNotifications}, selectedIndex: ${_this.selectedIndex}, allCount: ${_this.allCount}, ordersCount: ${_this.ordersCount}, offersCount: ${_this.offersCount}, alertsCount: ${_this.alertsCount}, errorMessage: ${_this.errorMessage}, currentPage: ${_this.currentPage}, lastPage: ${_this.lastPage}, total: ${_this.total}, isFetchingMore: ${_this.isFetchingMore})';
}


}

/// @nodoc
abstract mixin class $NotificationStateCopyWith<$Res>  {
  factory $NotificationStateCopyWith(NotificationState value, $Res Function(NotificationState) _then) = _$NotificationStateCopyWithImpl;
@useResult
$Res call({
 NotificationStatus status, List<NotificationModel> notifications, List<NotificationModel> filteredNotifications, int selectedIndex, int allCount, int ordersCount, int offersCount, int alertsCount, String? errorMessage, int currentPage, int lastPage, int total, bool isFetchingMore
});




}
/// @nodoc
class _$NotificationStateCopyWithImpl<$Res>
    implements $NotificationStateCopyWith<$Res> {
  _$NotificationStateCopyWithImpl(this._self, this._then);

  final NotificationState _self;
  final $Res Function(NotificationState) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? notifications = null,Object? filteredNotifications = null,Object? selectedIndex = null,Object? allCount = null,Object? ordersCount = null,Object? offersCount = null,Object? alertsCount = null,Object? errorMessage = freezed,Object? currentPage = null,Object? lastPage = null,Object? total = null,Object? isFetchingMore = null,}) {
  return _then(NotificationState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NotificationStatus,notifications: null == notifications ? _self.notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<NotificationModel>,filteredNotifications: null == filteredNotifications ? _self.filteredNotifications : filteredNotifications // ignore: cast_nullable_to_non_nullable
as List<NotificationModel>,selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,allCount: null == allCount ? _self.allCount : allCount // ignore: cast_nullable_to_non_nullable
as int,ordersCount: null == ordersCount ? _self.ordersCount : ordersCount // ignore: cast_nullable_to_non_nullable
as int,offersCount: null == offersCount ? _self.offersCount : offersCount // ignore: cast_nullable_to_non_nullable
as int,alertsCount: null == alertsCount ? _self.alertsCount : alertsCount // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,isFetchingMore: null == isFetchingMore ? _self.isFetchingMore : isFetchingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationState].
extension NotificationStatePatterns on NotificationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationState value)  $default,){
final _that = this;
switch (_that) {
case _NotificationState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationState value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NotificationStatus status,  List<NotificationModel> notifications,  List<NotificationModel> filteredNotifications,  int selectedIndex,  int allCount,  int ordersCount,  int offersCount,  int alertsCount,  String? errorMessage,  int currentPage,  int lastPage,  int total,  bool isFetchingMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationState() when $default != null:
return $default(_that.status,_that.notifications,_that.filteredNotifications,_that.selectedIndex,_that.allCount,_that.ordersCount,_that.offersCount,_that.alertsCount,_that.errorMessage,_that.currentPage,_that.lastPage,_that.total,_that.isFetchingMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NotificationStatus status,  List<NotificationModel> notifications,  List<NotificationModel> filteredNotifications,  int selectedIndex,  int allCount,  int ordersCount,  int offersCount,  int alertsCount,  String? errorMessage,  int currentPage,  int lastPage,  int total,  bool isFetchingMore)  $default,) {final _that = this;
switch (_that) {
case _NotificationState():
return $default(_that.status,_that.notifications,_that.filteredNotifications,_that.selectedIndex,_that.allCount,_that.ordersCount,_that.offersCount,_that.alertsCount,_that.errorMessage,_that.currentPage,_that.lastPage,_that.total,_that.isFetchingMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NotificationStatus status,  List<NotificationModel> notifications,  List<NotificationModel> filteredNotifications,  int selectedIndex,  int allCount,  int ordersCount,  int offersCount,  int alertsCount,  String? errorMessage,  int currentPage,  int lastPage,  int total,  bool isFetchingMore)?  $default,) {final _that = this;
switch (_that) {
case _NotificationState() when $default != null:
return $default(_that.status,_that.notifications,_that.filteredNotifications,_that.selectedIndex,_that.allCount,_that.ordersCount,_that.offersCount,_that.alertsCount,_that.errorMessage,_that.currentPage,_that.lastPage,_that.total,_that.isFetchingMore);case _:
  return null;

}
}

}

/// @nodoc


class _NotificationState implements NotificationState {
  const _NotificationState({this.status = NotificationStatus.initial,  List<NotificationModel> notifications = const [],  List<NotificationModel> filteredNotifications = const [], this.selectedIndex = 0, this.allCount = 0, this.ordersCount = 0, this.offersCount = 0, this.alertsCount = 0, this.errorMessage, this.currentPage = 1, this.lastPage = 1, this.total = 0, this.isFetchingMore = false}): _notifications = notifications,_filteredNotifications = filteredNotifications;
  

@override@JsonKey() final  NotificationStatus status;
 final  List<NotificationModel> _notifications;
@override@JsonKey() List<NotificationModel> get notifications {
  if (_notifications is EqualUnmodifiableListView) return _notifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notifications);
}

 final  List<NotificationModel> _filteredNotifications;
@override@JsonKey() List<NotificationModel> get filteredNotifications {
  if (_filteredNotifications is EqualUnmodifiableListView) return _filteredNotifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredNotifications);
}

@override@JsonKey() final  int selectedIndex;
@override@JsonKey() final  int allCount;
@override@JsonKey() final  int ordersCount;
@override@JsonKey() final  int offersCount;
@override@JsonKey() final  int alertsCount;
@override final  String? errorMessage;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  int lastPage;
@override@JsonKey() final  int total;
@override@JsonKey() final  bool isFetchingMore;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationStateCopyWith<_NotificationState> get copyWith => __$NotificationStateCopyWithImpl<_NotificationState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.notifications, _notifications)&&const DeepCollectionEquality().equals(other.filteredNotifications, _filteredNotifications)&&(identical(other.selectedIndex, selectedIndex) || other.selectedIndex == selectedIndex)&&(identical(other.allCount, allCount) || other.allCount == allCount)&&(identical(other.ordersCount, ordersCount) || other.ordersCount == ordersCount)&&(identical(other.offersCount, offersCount) || other.offersCount == offersCount)&&(identical(other.alertsCount, alertsCount) || other.alertsCount == alertsCount)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.total, total) || other.total == total)&&(identical(other.isFetchingMore, isFetchingMore) || other.isFetchingMore == isFetchingMore));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_notifications),const DeepCollectionEquality().hash(_filteredNotifications),selectedIndex,allCount,ordersCount,offersCount,alertsCount,errorMessage,currentPage,lastPage,total,isFetchingMore);
}

@override
String toString() {
    return 'NotificationState(status: $status, notifications: $notifications, filteredNotifications: $filteredNotifications, selectedIndex: $selectedIndex, allCount: $allCount, ordersCount: $ordersCount, offersCount: $offersCount, alertsCount: $alertsCount, errorMessage: $errorMessage, currentPage: $currentPage, lastPage: $lastPage, total: $total, isFetchingMore: $isFetchingMore)';
}


}

/// @nodoc
abstract mixin class _$NotificationStateCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory _$NotificationStateCopyWith(_NotificationState value, $Res Function(_NotificationState) _then) = __$NotificationStateCopyWithImpl;
@override @useResult
$Res call({
 NotificationStatus status, List<NotificationModel> notifications, List<NotificationModel> filteredNotifications, int selectedIndex, int allCount, int ordersCount, int offersCount, int alertsCount, String? errorMessage, int currentPage, int lastPage, int total, bool isFetchingMore
});




}
/// @nodoc
class __$NotificationStateCopyWithImpl<$Res>
    implements _$NotificationStateCopyWith<$Res> {
  __$NotificationStateCopyWithImpl(this._self, this._then);

  final _NotificationState _self;
  final $Res Function(_NotificationState) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? notifications = null,Object? filteredNotifications = null,Object? selectedIndex = null,Object? allCount = null,Object? ordersCount = null,Object? offersCount = null,Object? alertsCount = null,Object? errorMessage = freezed,Object? currentPage = null,Object? lastPage = null,Object? total = null,Object? isFetchingMore = null,}) {
  return _then(_NotificationState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NotificationStatus,notifications: null == notifications ? _self._notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<NotificationModel>,filteredNotifications: null == filteredNotifications ? _self._filteredNotifications : filteredNotifications // ignore: cast_nullable_to_non_nullable
as List<NotificationModel>,selectedIndex: null == selectedIndex ? _self.selectedIndex : selectedIndex // ignore: cast_nullable_to_non_nullable
as int,allCount: null == allCount ? _self.allCount : allCount // ignore: cast_nullable_to_non_nullable
as int,ordersCount: null == ordersCount ? _self.ordersCount : ordersCount // ignore: cast_nullable_to_non_nullable
as int,offersCount: null == offersCount ? _self.offersCount : offersCount // ignore: cast_nullable_to_non_nullable
as int,alertsCount: null == alertsCount ? _self.alertsCount : alertsCount // ignore: cast_nullable_to_non_nullable
as int,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,isFetchingMore: null == isFetchingMore ? _self.isFetchingMore : isFetchingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
