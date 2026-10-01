// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_details_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OrderDetailsEvent {

 int get orderId;
/// Create a copy of OrderDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailsEventCopyWith<OrderDetailsEvent> get copyWith => _$OrderDetailsEventCopyWithImpl<OrderDetailsEvent>(this as OrderDetailsEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as OrderDetailsEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsEvent&&(identical(other.orderId, _this.orderId) || other.orderId == _this.orderId));
}


@override
int get hashCode {
  final _this = this as OrderDetailsEvent;
  return Object.hash(runtimeType,_this.orderId);
}

@override
String toString() {
  final _this = this as OrderDetailsEvent;
  return 'OrderDetailsEvent(orderId: ${_this.orderId})';
}


}

/// @nodoc
abstract mixin class $OrderDetailsEventCopyWith<$Res>  {
  factory $OrderDetailsEventCopyWith(OrderDetailsEvent value, $Res Function(OrderDetailsEvent) _then) = _$OrderDetailsEventCopyWithImpl;
@useResult
$Res call({
 int orderId
});




}
/// @nodoc
class _$OrderDetailsEventCopyWithImpl<$Res>
    implements $OrderDetailsEventCopyWith<$Res> {
  _$OrderDetailsEventCopyWithImpl(this._self, this._then);

  final OrderDetailsEvent _self;
  final $Res Function(OrderDetailsEvent) _then;

/// Create a copy of OrderDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? orderId = null,}) {
  return _then(OrderDetailsEvent.fetchRequested(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [OrderDetailsEvent].
extension OrderDetailsEventPatterns on OrderDetailsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OrderDetailsFetchRequested value)?  fetchRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OrderDetailsFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OrderDetailsFetchRequested value)  fetchRequested,}){
final _that = this;
switch (_that) {
case OrderDetailsFetchRequested():
return fetchRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OrderDetailsFetchRequested value)?  fetchRequested,}){
final _that = this;
switch (_that) {
case OrderDetailsFetchRequested() when fetchRequested != null:
return fetchRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int orderId)?  fetchRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OrderDetailsFetchRequested() when fetchRequested != null:
return fetchRequested(_that.orderId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int orderId)  fetchRequested,}) {final _that = this;
switch (_that) {
case OrderDetailsFetchRequested():
return fetchRequested(_that.orderId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int orderId)?  fetchRequested,}) {final _that = this;
switch (_that) {
case OrderDetailsFetchRequested() when fetchRequested != null:
return fetchRequested(_that.orderId);case _:
  return null;

}
}

}

/// @nodoc


class OrderDetailsFetchRequested implements OrderDetailsEvent {
  const OrderDetailsFetchRequested(this.orderId);
  

@override final  int orderId;

/// Create a copy of OrderDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OrderDetailsFetchRequestedCopyWith<OrderDetailsFetchRequested> get copyWith => _$OrderDetailsFetchRequestedCopyWithImpl<OrderDetailsFetchRequested>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OrderDetailsFetchRequested&&(identical(other.orderId, orderId) || other.orderId == orderId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,orderId);
}

@override
String toString() {
    return 'OrderDetailsEvent.fetchRequested(orderId: $orderId)';
}


}

/// @nodoc
abstract mixin class $OrderDetailsFetchRequestedCopyWith<$Res> implements $OrderDetailsEventCopyWith<$Res> {
  factory $OrderDetailsFetchRequestedCopyWith(OrderDetailsFetchRequested value, $Res Function(OrderDetailsFetchRequested) _then) = _$OrderDetailsFetchRequestedCopyWithImpl;
@override @useResult
$Res call({
 int orderId
});




}
/// @nodoc
class _$OrderDetailsFetchRequestedCopyWithImpl<$Res>
    implements $OrderDetailsFetchRequestedCopyWith<$Res> {
  _$OrderDetailsFetchRequestedCopyWithImpl(this._self, this._then);

  final OrderDetailsFetchRequested _self;
  final $Res Function(OrderDetailsFetchRequested) _then;

/// Create a copy of OrderDetailsEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? orderId = null,}) {
  return _then(OrderDetailsFetchRequested(
null == orderId ? _self.orderId : orderId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
