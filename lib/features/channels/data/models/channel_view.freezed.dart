// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'channel_view.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChannelView {

 Channel get channel; StreamLink get stream;
/// Create a copy of ChannelView
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChannelViewCopyWith<ChannelView> get copyWith => _$ChannelViewCopyWithImpl<ChannelView>(this as ChannelView, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChannelView&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.stream, stream) || other.stream == stream));
}


@override
int get hashCode => Object.hash(runtimeType,channel,stream);

@override
String toString() {
  return 'ChannelView(channel: $channel, stream: $stream)';
}


}

/// @nodoc
abstract mixin class $ChannelViewCopyWith<$Res>  {
  factory $ChannelViewCopyWith(ChannelView value, $Res Function(ChannelView) _then) = _$ChannelViewCopyWithImpl;
@useResult
$Res call({
 Channel channel, StreamLink stream
});


$ChannelCopyWith<$Res> get channel;$StreamLinkCopyWith<$Res> get stream;

}
/// @nodoc
class _$ChannelViewCopyWithImpl<$Res>
    implements $ChannelViewCopyWith<$Res> {
  _$ChannelViewCopyWithImpl(this._self, this._then);

  final ChannelView _self;
  final $Res Function(ChannelView) _then;

/// Create a copy of ChannelView
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? channel = null,Object? stream = null,}) {
  return _then(_self.copyWith(
channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as Channel,stream: null == stream ? _self.stream : stream // ignore: cast_nullable_to_non_nullable
as StreamLink,
  ));
}
/// Create a copy of ChannelView
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChannelCopyWith<$Res> get channel {
  
  return $ChannelCopyWith<$Res>(_self.channel, (value) {
    return _then(_self.copyWith(channel: value));
  });
}/// Create a copy of ChannelView
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StreamLinkCopyWith<$Res> get stream {
  
  return $StreamLinkCopyWith<$Res>(_self.stream, (value) {
    return _then(_self.copyWith(stream: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChannelView].
extension ChannelViewPatterns on ChannelView {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChannelView value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChannelView() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChannelView value)  $default,){
final _that = this;
switch (_that) {
case _ChannelView():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChannelView value)?  $default,){
final _that = this;
switch (_that) {
case _ChannelView() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Channel channel,  StreamLink stream)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChannelView() when $default != null:
return $default(_that.channel,_that.stream);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Channel channel,  StreamLink stream)  $default,) {final _that = this;
switch (_that) {
case _ChannelView():
return $default(_that.channel,_that.stream);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Channel channel,  StreamLink stream)?  $default,) {final _that = this;
switch (_that) {
case _ChannelView() when $default != null:
return $default(_that.channel,_that.stream);case _:
  return null;

}
}

}

/// @nodoc


class _ChannelView extends ChannelView {
  const _ChannelView({required this.channel, required this.stream}): super._();
  

@override final  Channel channel;
@override final  StreamLink stream;

/// Create a copy of ChannelView
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChannelViewCopyWith<_ChannelView> get copyWith => __$ChannelViewCopyWithImpl<_ChannelView>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChannelView&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.stream, stream) || other.stream == stream));
}


@override
int get hashCode => Object.hash(runtimeType,channel,stream);

@override
String toString() {
  return 'ChannelView(channel: $channel, stream: $stream)';
}


}

/// @nodoc
abstract mixin class _$ChannelViewCopyWith<$Res> implements $ChannelViewCopyWith<$Res> {
  factory _$ChannelViewCopyWith(_ChannelView value, $Res Function(_ChannelView) _then) = __$ChannelViewCopyWithImpl;
@override @useResult
$Res call({
 Channel channel, StreamLink stream
});


@override $ChannelCopyWith<$Res> get channel;@override $StreamLinkCopyWith<$Res> get stream;

}
/// @nodoc
class __$ChannelViewCopyWithImpl<$Res>
    implements _$ChannelViewCopyWith<$Res> {
  __$ChannelViewCopyWithImpl(this._self, this._then);

  final _ChannelView _self;
  final $Res Function(_ChannelView) _then;

/// Create a copy of ChannelView
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? channel = null,Object? stream = null,}) {
  return _then(_ChannelView(
channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as Channel,stream: null == stream ? _self.stream : stream // ignore: cast_nullable_to_non_nullable
as StreamLink,
  ));
}

/// Create a copy of ChannelView
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ChannelCopyWith<$Res> get channel {
  
  return $ChannelCopyWith<$Res>(_self.channel, (value) {
    return _then(_self.copyWith(channel: value));
  });
}/// Create a copy of ChannelView
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StreamLinkCopyWith<$Res> get stream {
  
  return $StreamLinkCopyWith<$Res>(_self.stream, (value) {
    return _then(_self.copyWith(stream: value));
  });
}
}

// dart format on
