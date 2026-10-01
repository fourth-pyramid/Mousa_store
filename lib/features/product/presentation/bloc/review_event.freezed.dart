// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReviewEvent {

 int get productId; double get rate; String get comment;
/// Create a copy of ReviewEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewEventCopyWith<ReviewEvent> get copyWith => _$ReviewEventCopyWithImpl<ReviewEvent>(this as ReviewEvent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ReviewEvent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewEvent&&(identical(other.productId, _this.productId) || other.productId == _this.productId)&&(identical(other.rate, _this.rate) || other.rate == _this.rate)&&(identical(other.comment, _this.comment) || other.comment == _this.comment));
}


@override
int get hashCode {
  final _this = this as ReviewEvent;
  return Object.hash(runtimeType,_this.productId,_this.rate,_this.comment);
}

@override
String toString() {
  final _this = this as ReviewEvent;
  return 'ReviewEvent(productId: ${_this.productId}, rate: ${_this.rate}, comment: ${_this.comment})';
}


}

/// @nodoc
abstract mixin class $ReviewEventCopyWith<$Res>  {
  factory $ReviewEventCopyWith(ReviewEvent value, $Res Function(ReviewEvent) _then) = _$ReviewEventCopyWithImpl;
@useResult
$Res call({
 int productId, double rate, String comment
});




}
/// @nodoc
class _$ReviewEventCopyWithImpl<$Res>
    implements $ReviewEventCopyWith<$Res> {
  _$ReviewEventCopyWithImpl(this._self, this._then);

  final ReviewEvent _self;
  final $Res Function(ReviewEvent) _then;

/// Create a copy of ReviewEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? productId = null,Object? rate = null,Object? comment = null,}) {
  return _then(ReviewEvent.submitted(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewEvent].
extension ReviewEventPatterns on ReviewEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ReviewSubmitted value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ReviewSubmitted() when submitted != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ReviewSubmitted value)  submitted,}){
final _that = this;
switch (_that) {
case ReviewSubmitted():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ReviewSubmitted value)?  submitted,}){
final _that = this;
switch (_that) {
case ReviewSubmitted() when submitted != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int productId,  double rate,  String comment)?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ReviewSubmitted() when submitted != null:
return submitted(_that.productId,_that.rate,_that.comment);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int productId,  double rate,  String comment)  submitted,}) {final _that = this;
switch (_that) {
case ReviewSubmitted():
return submitted(_that.productId,_that.rate,_that.comment);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int productId,  double rate,  String comment)?  submitted,}) {final _that = this;
switch (_that) {
case ReviewSubmitted() when submitted != null:
return submitted(_that.productId,_that.rate,_that.comment);case _:
  return null;

}
}

}

/// @nodoc


class ReviewSubmitted implements ReviewEvent {
  const ReviewSubmitted({required this.productId, required this.rate, required this.comment});
  

@override final  int productId;
@override final  double rate;
@override final  String comment;

/// Create a copy of ReviewEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewSubmittedCopyWith<ReviewSubmitted> get copyWith => _$ReviewSubmittedCopyWithImpl<ReviewSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewSubmitted&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.comment, comment) || other.comment == comment));
}


@override
int get hashCode {
    return Object.hash(runtimeType,productId,rate,comment);
}

@override
String toString() {
    return 'ReviewEvent.submitted(productId: $productId, rate: $rate, comment: $comment)';
}


}

/// @nodoc
abstract mixin class $ReviewSubmittedCopyWith<$Res> implements $ReviewEventCopyWith<$Res> {
  factory $ReviewSubmittedCopyWith(ReviewSubmitted value, $Res Function(ReviewSubmitted) _then) = _$ReviewSubmittedCopyWithImpl;
@override @useResult
$Res call({
 int productId, double rate, String comment
});




}
/// @nodoc
class _$ReviewSubmittedCopyWithImpl<$Res>
    implements $ReviewSubmittedCopyWith<$Res> {
  _$ReviewSubmittedCopyWithImpl(this._self, this._then);

  final ReviewSubmitted _self;
  final $Res Function(ReviewSubmitted) _then;

/// Create a copy of ReviewEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? productId = null,Object? rate = null,Object? comment = null,}) {
  return _then(ReviewSubmitted(
productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as int,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as double,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
