// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'channel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Channel {

 String get id; String get name; List<String> get altNames; String? get network; List<String> get owners; String? get country; String? get subdivision; String? get city; List<String> get categories; List<String> get languages; bool get isNsfw; String? get launched; String? get closed; String? get replacedBy; String? get website; String? get logo;
/// Create a copy of Channel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChannelCopyWith<Channel> get copyWith => _$ChannelCopyWithImpl<Channel>(this as Channel, _$identity);

  /// Serializes this Channel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Channel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.altNames, altNames)&&(identical(other.network, network) || other.network == network)&&const DeepCollectionEquality().equals(other.owners, owners)&&(identical(other.country, country) || other.country == country)&&(identical(other.subdivision, subdivision) || other.subdivision == subdivision)&&(identical(other.city, city) || other.city == city)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.languages, languages)&&(identical(other.isNsfw, isNsfw) || other.isNsfw == isNsfw)&&(identical(other.launched, launched) || other.launched == launched)&&(identical(other.closed, closed) || other.closed == closed)&&(identical(other.replacedBy, replacedBy) || other.replacedBy == replacedBy)&&(identical(other.website, website) || other.website == website)&&(identical(other.logo, logo) || other.logo == logo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(altNames),network,const DeepCollectionEquality().hash(owners),country,subdivision,city,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(languages),isNsfw,launched,closed,replacedBy,website,logo);

@override
String toString() {
  return 'Channel(id: $id, name: $name, altNames: $altNames, network: $network, owners: $owners, country: $country, subdivision: $subdivision, city: $city, categories: $categories, languages: $languages, isNsfw: $isNsfw, launched: $launched, closed: $closed, replacedBy: $replacedBy, website: $website, logo: $logo)';
}


}

/// @nodoc
abstract mixin class $ChannelCopyWith<$Res>  {
  factory $ChannelCopyWith(Channel value, $Res Function(Channel) _then) = _$ChannelCopyWithImpl;
@useResult
$Res call({
 String id, String name, List<String> altNames, String? network, List<String> owners, String? country, String? subdivision, String? city, List<String> categories, List<String> languages, bool isNsfw, String? launched, String? closed, String? replacedBy, String? website, String? logo
});




}
/// @nodoc
class _$ChannelCopyWithImpl<$Res>
    implements $ChannelCopyWith<$Res> {
  _$ChannelCopyWithImpl(this._self, this._then);

  final Channel _self;
  final $Res Function(Channel) _then;

/// Create a copy of Channel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? altNames = null,Object? network = freezed,Object? owners = null,Object? country = freezed,Object? subdivision = freezed,Object? city = freezed,Object? categories = null,Object? languages = null,Object? isNsfw = null,Object? launched = freezed,Object? closed = freezed,Object? replacedBy = freezed,Object? website = freezed,Object? logo = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,altNames: null == altNames ? _self.altNames : altNames // ignore: cast_nullable_to_non_nullable
as List<String>,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,owners: null == owners ? _self.owners : owners // ignore: cast_nullable_to_non_nullable
as List<String>,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,subdivision: freezed == subdivision ? _self.subdivision : subdivision // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,isNsfw: null == isNsfw ? _self.isNsfw : isNsfw // ignore: cast_nullable_to_non_nullable
as bool,launched: freezed == launched ? _self.launched : launched // ignore: cast_nullable_to_non_nullable
as String?,closed: freezed == closed ? _self.closed : closed // ignore: cast_nullable_to_non_nullable
as String?,replacedBy: freezed == replacedBy ? _self.replacedBy : replacedBy // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Channel].
extension ChannelPatterns on Channel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Channel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Channel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Channel value)  $default,){
final _that = this;
switch (_that) {
case _Channel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Channel value)?  $default,){
final _that = this;
switch (_that) {
case _Channel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  List<String> altNames,  String? network,  List<String> owners,  String? country,  String? subdivision,  String? city,  List<String> categories,  List<String> languages,  bool isNsfw,  String? launched,  String? closed,  String? replacedBy,  String? website,  String? logo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Channel() when $default != null:
return $default(_that.id,_that.name,_that.altNames,_that.network,_that.owners,_that.country,_that.subdivision,_that.city,_that.categories,_that.languages,_that.isNsfw,_that.launched,_that.closed,_that.replacedBy,_that.website,_that.logo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  List<String> altNames,  String? network,  List<String> owners,  String? country,  String? subdivision,  String? city,  List<String> categories,  List<String> languages,  bool isNsfw,  String? launched,  String? closed,  String? replacedBy,  String? website,  String? logo)  $default,) {final _that = this;
switch (_that) {
case _Channel():
return $default(_that.id,_that.name,_that.altNames,_that.network,_that.owners,_that.country,_that.subdivision,_that.city,_that.categories,_that.languages,_that.isNsfw,_that.launched,_that.closed,_that.replacedBy,_that.website,_that.logo);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  List<String> altNames,  String? network,  List<String> owners,  String? country,  String? subdivision,  String? city,  List<String> categories,  List<String> languages,  bool isNsfw,  String? launched,  String? closed,  String? replacedBy,  String? website,  String? logo)?  $default,) {final _that = this;
switch (_that) {
case _Channel() when $default != null:
return $default(_that.id,_that.name,_that.altNames,_that.network,_that.owners,_that.country,_that.subdivision,_that.city,_that.categories,_that.languages,_that.isNsfw,_that.launched,_that.closed,_that.replacedBy,_that.website,_that.logo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Channel implements Channel {
  const _Channel({required this.id, required this.name, final  List<String> altNames = const <String>[], this.network, final  List<String> owners = const <String>[], this.country, this.subdivision, this.city, final  List<String> categories = const <String>[], final  List<String> languages = const <String>[], this.isNsfw = false, this.launched, this.closed, this.replacedBy, this.website, this.logo}): _altNames = altNames,_owners = owners,_categories = categories,_languages = languages;
  factory _Channel.fromJson(Map<String, dynamic> json) => _$ChannelFromJson(json);

@override final  String id;
@override final  String name;
 final  List<String> _altNames;
@override@JsonKey() List<String> get altNames {
  if (_altNames is EqualUnmodifiableListView) return _altNames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_altNames);
}

@override final  String? network;
 final  List<String> _owners;
@override@JsonKey() List<String> get owners {
  if (_owners is EqualUnmodifiableListView) return _owners;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_owners);
}

@override final  String? country;
@override final  String? subdivision;
@override final  String? city;
 final  List<String> _categories;
@override@JsonKey() List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<String> _languages;
@override@JsonKey() List<String> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}

@override@JsonKey() final  bool isNsfw;
@override final  String? launched;
@override final  String? closed;
@override final  String? replacedBy;
@override final  String? website;
@override final  String? logo;

/// Create a copy of Channel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChannelCopyWith<_Channel> get copyWith => __$ChannelCopyWithImpl<_Channel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChannelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Channel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._altNames, _altNames)&&(identical(other.network, network) || other.network == network)&&const DeepCollectionEquality().equals(other._owners, _owners)&&(identical(other.country, country) || other.country == country)&&(identical(other.subdivision, subdivision) || other.subdivision == subdivision)&&(identical(other.city, city) || other.city == city)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._languages, _languages)&&(identical(other.isNsfw, isNsfw) || other.isNsfw == isNsfw)&&(identical(other.launched, launched) || other.launched == launched)&&(identical(other.closed, closed) || other.closed == closed)&&(identical(other.replacedBy, replacedBy) || other.replacedBy == replacedBy)&&(identical(other.website, website) || other.website == website)&&(identical(other.logo, logo) || other.logo == logo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,const DeepCollectionEquality().hash(_altNames),network,const DeepCollectionEquality().hash(_owners),country,subdivision,city,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_languages),isNsfw,launched,closed,replacedBy,website,logo);

@override
String toString() {
  return 'Channel(id: $id, name: $name, altNames: $altNames, network: $network, owners: $owners, country: $country, subdivision: $subdivision, city: $city, categories: $categories, languages: $languages, isNsfw: $isNsfw, launched: $launched, closed: $closed, replacedBy: $replacedBy, website: $website, logo: $logo)';
}


}

/// @nodoc
abstract mixin class _$ChannelCopyWith<$Res> implements $ChannelCopyWith<$Res> {
  factory _$ChannelCopyWith(_Channel value, $Res Function(_Channel) _then) = __$ChannelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, List<String> altNames, String? network, List<String> owners, String? country, String? subdivision, String? city, List<String> categories, List<String> languages, bool isNsfw, String? launched, String? closed, String? replacedBy, String? website, String? logo
});




}
/// @nodoc
class __$ChannelCopyWithImpl<$Res>
    implements _$ChannelCopyWith<$Res> {
  __$ChannelCopyWithImpl(this._self, this._then);

  final _Channel _self;
  final $Res Function(_Channel) _then;

/// Create a copy of Channel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? altNames = null,Object? network = freezed,Object? owners = null,Object? country = freezed,Object? subdivision = freezed,Object? city = freezed,Object? categories = null,Object? languages = null,Object? isNsfw = null,Object? launched = freezed,Object? closed = freezed,Object? replacedBy = freezed,Object? website = freezed,Object? logo = freezed,}) {
  return _then(_Channel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,altNames: null == altNames ? _self._altNames : altNames // ignore: cast_nullable_to_non_nullable
as List<String>,network: freezed == network ? _self.network : network // ignore: cast_nullable_to_non_nullable
as String?,owners: null == owners ? _self._owners : owners // ignore: cast_nullable_to_non_nullable
as List<String>,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,subdivision: freezed == subdivision ? _self.subdivision : subdivision // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,isNsfw: null == isNsfw ? _self.isNsfw : isNsfw // ignore: cast_nullable_to_non_nullable
as bool,launched: freezed == launched ? _self.launched : launched // ignore: cast_nullable_to_non_nullable
as String?,closed: freezed == closed ? _self.closed : closed // ignore: cast_nullable_to_non_nullable
as String?,replacedBy: freezed == replacedBy ? _self.replacedBy : replacedBy // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,logo: freezed == logo ? _self.logo : logo // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
