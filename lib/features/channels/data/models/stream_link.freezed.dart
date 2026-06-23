// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stream_link.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StreamLink {

 String get channel; String? get feed; String? get title; String get url; String? get referrer; String? get userAgent; String? get quality;
/// Create a copy of StreamLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StreamLinkCopyWith<StreamLink> get copyWith => _$StreamLinkCopyWithImpl<StreamLink>(this as StreamLink, _$identity);

  /// Serializes this StreamLink to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StreamLink&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.feed, feed) || other.feed == feed)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.referrer, referrer) || other.referrer == referrer)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.quality, quality) || other.quality == quality));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,channel,feed,title,url,referrer,userAgent,quality);

@override
String toString() {
  return 'StreamLink(channel: $channel, feed: $feed, title: $title, url: $url, referrer: $referrer, userAgent: $userAgent, quality: $quality)';
}


}

/// @nodoc
abstract mixin class $StreamLinkCopyWith<$Res>  {
  factory $StreamLinkCopyWith(StreamLink value, $Res Function(StreamLink) _then) = _$StreamLinkCopyWithImpl;
@useResult
$Res call({
 String channel, String? feed, String? title, String url, String? referrer, String? userAgent, String? quality
});




}
/// @nodoc
class _$StreamLinkCopyWithImpl<$Res>
    implements $StreamLinkCopyWith<$Res> {
  _$StreamLinkCopyWithImpl(this._self, this._then);

  final StreamLink _self;
  final $Res Function(StreamLink) _then;

/// Create a copy of StreamLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? channel = null,Object? feed = freezed,Object? title = freezed,Object? url = null,Object? referrer = freezed,Object? userAgent = freezed,Object? quality = freezed,}) {
  return _then(_self.copyWith(
channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String,feed: freezed == feed ? _self.feed : feed // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,referrer: freezed == referrer ? _self.referrer : referrer // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,quality: freezed == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [StreamLink].
extension StreamLinkPatterns on StreamLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StreamLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StreamLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StreamLink value)  $default,){
final _that = this;
switch (_that) {
case _StreamLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StreamLink value)?  $default,){
final _that = this;
switch (_that) {
case _StreamLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String channel,  String? feed,  String? title,  String url,  String? referrer,  String? userAgent,  String? quality)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StreamLink() when $default != null:
return $default(_that.channel,_that.feed,_that.title,_that.url,_that.referrer,_that.userAgent,_that.quality);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String channel,  String? feed,  String? title,  String url,  String? referrer,  String? userAgent,  String? quality)  $default,) {final _that = this;
switch (_that) {
case _StreamLink():
return $default(_that.channel,_that.feed,_that.title,_that.url,_that.referrer,_that.userAgent,_that.quality);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String channel,  String? feed,  String? title,  String url,  String? referrer,  String? userAgent,  String? quality)?  $default,) {final _that = this;
switch (_that) {
case _StreamLink() when $default != null:
return $default(_that.channel,_that.feed,_that.title,_that.url,_that.referrer,_that.userAgent,_that.quality);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StreamLink implements StreamLink {
  const _StreamLink({required this.channel, this.feed, this.title, required this.url, this.referrer, this.userAgent, this.quality});
  factory _StreamLink.fromJson(Map<String, dynamic> json) => _$StreamLinkFromJson(json);

@override final  String channel;
@override final  String? feed;
@override final  String? title;
@override final  String url;
@override final  String? referrer;
@override final  String? userAgent;
@override final  String? quality;

/// Create a copy of StreamLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StreamLinkCopyWith<_StreamLink> get copyWith => __$StreamLinkCopyWithImpl<_StreamLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StreamLinkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StreamLink&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.feed, feed) || other.feed == feed)&&(identical(other.title, title) || other.title == title)&&(identical(other.url, url) || other.url == url)&&(identical(other.referrer, referrer) || other.referrer == referrer)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.quality, quality) || other.quality == quality));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,channel,feed,title,url,referrer,userAgent,quality);

@override
String toString() {
  return 'StreamLink(channel: $channel, feed: $feed, title: $title, url: $url, referrer: $referrer, userAgent: $userAgent, quality: $quality)';
}


}

/// @nodoc
abstract mixin class _$StreamLinkCopyWith<$Res> implements $StreamLinkCopyWith<$Res> {
  factory _$StreamLinkCopyWith(_StreamLink value, $Res Function(_StreamLink) _then) = __$StreamLinkCopyWithImpl;
@override @useResult
$Res call({
 String channel, String? feed, String? title, String url, String? referrer, String? userAgent, String? quality
});




}
/// @nodoc
class __$StreamLinkCopyWithImpl<$Res>
    implements _$StreamLinkCopyWith<$Res> {
  __$StreamLinkCopyWithImpl(this._self, this._then);

  final _StreamLink _self;
  final $Res Function(_StreamLink) _then;

/// Create a copy of StreamLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? channel = null,Object? feed = freezed,Object? title = freezed,Object? url = null,Object? referrer = freezed,Object? userAgent = freezed,Object? quality = freezed,}) {
  return _then(_StreamLink(
channel: null == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String,feed: freezed == feed ? _self.feed : feed // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,referrer: freezed == referrer ? _self.referrer : referrer // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,quality: freezed == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
