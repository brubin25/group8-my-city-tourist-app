class TouristSpot {
  final int id;
  final String title;
  final String synopsis;
  final String thumbnailUrl;

  static const _thumbBase = 'https://webapi.driftscape.com/document/id';
  static const _thumbParams = '?Img=300&Crop=1:1;16:9;5:4&Contain';

  TouristSpot._({
    required this.id,
    required this.title,
    required this.synopsis,
    required this.thumbnailUrl,
  });

  factory TouristSpot.fromJson(Map<String, dynamic> json) {
    final rawId = json['FEATURE_THUMBNAIL_URL'] as String;
    final fullUrl = '$_thumbBase/$rawId$_thumbParams';
    return TouristSpot._(
      id: json['ID'] as int,
      title: json['FEATURE_TITLE'] as String,
      synopsis: json['FEATURE_SYNOPSIS'] as String? ?? '',
      thumbnailUrl: fullUrl,
    );
  }
}
