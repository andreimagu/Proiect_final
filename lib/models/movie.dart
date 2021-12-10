part of models;

abstract class Movie implements Built<Movie, MovieBuilder> {
  factory Movie([void Function(MovieBuilder) updates]) = _$Movie;

  factory Movie.fromJson(dynamic json) {
    return serializers.deserializeWith(serializer, json)!;
  }

  Movie._();

  int get id;

  String get title;

  @BuiltValueField(wireName: 'medium_cover_image')
  String get image;

  static Serializer<Movie> get serializer => _$movieSerializer;
}
