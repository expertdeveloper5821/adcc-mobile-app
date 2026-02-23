class CommunityModel {
  final String id;
  final String title;
  final String description;


  final String type;


  final List<String> category;

 
  final String? location;
  final String? trackName;
  final String? terrain;
  final double? distance;


  final String? imageUrl;

 bool isJoined;
  final int? membersCount;
  final int? eventsCount;

  CommunityModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    this.location,
    this.trackName,
    this.terrain,
    this.distance,
    this.imageUrl,
  this.isJoined = false,   
    this.membersCount,
    this.eventsCount,
  });

 factory CommunityModel.fromJson(Map<String, dynamic> json) {
  return CommunityModel(
    id: json['_id'] ?? '',
    title: json['title'] ?? '',
    description: json['description'] ?? '',

    // type can be List or String
    type: json['type'] is List
        ? (json['type'] as List).join(', ')
        : json['type']?.toString() ?? '',

    // FIXED CATEGORY PARSING
    category: _parseCategory(json['category']),

    location: json['location']?.toString(),
    trackName: json['trackName']?.toString(),
    terrain: json['terrain']?.toString(),
    distance: _parseDouble(json['distance']),

    imageUrl: json['imageUrl'] ?? json['image'] ?? json['imagePath'],

    isJoined: (json['isJoined'] ??
            json['joined'] ??
            json['isMember'] ??
            false) ==
        true,

    membersCount: _parseCount(
      json['membersCount'] ??
          json['members'] ??
          json['memberCount'],
    ),

    eventsCount: _parseCount(
      json['eventsCount'] ??
          json['events'] ??
          json['eventCount'],
    ),
  );
}
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'type': type,
      'category': category,
      'location': location,
      'trackName': trackName,
      'terrain': terrain,
      'distance': distance,
      'imageUrl': imageUrl,
      'isJoined': isJoined,
      'membersCount': membersCount,
      'eventsCount': eventsCount,
    };
  }

  static int? _parseCount(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is List) return value.length;
    if (value is String) return int.tryParse(value);
    return null;
  }

  static double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  bool hasCategory(String categoryName) {
    final lowerCategoryName = categoryName.toLowerCase().trim();
    return category.any((cat) => cat.toLowerCase().trim() == lowerCategoryName);
  }

  bool hasAnyCategory(List<String> categories) {
    if (category.isEmpty) return false;

    final lowerCategories =
        categories.map((c) => c.toLowerCase().trim()).toList();
    final lowerCommunityCategories =
        category.map((c) => c.toLowerCase().trim()).toList();

    for (final keyword in lowerCategories) {
      for (final cat in lowerCommunityCategories) {
        if (cat == keyword) return true;
      }
    }
    return false;
  }

  static List<String> _parseCategory(dynamic value) {
  if (value == null) return [];

  if (value is List) {
    return value.map((e) => e.toString()).toList();
  }

  if (value is String) {
    return [value];
  }

  return [];
}
}
