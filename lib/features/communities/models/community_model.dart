class CommunityModel {
  final String id;
  final String title;
  final String description;
  final String type;
  final List<String> category;
  final String? imageUrl;
  final bool? isJoined;
  final int? membersCount;
  final int? eventsCount;
  final List<String>? memberImages;

  CommunityModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    this.imageUrl,
    this.isJoined,
    this.membersCount,
    this.eventsCount,
    this.memberImages,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      category:
          json['category'] != null ? List<String>.from(json['category']) : [],
      imageUrl: json['imageUrl'] ?? json['image'] ?? json['imagePath'],
      isJoined: json['isJoined'] ?? json['joined'] ?? false,
      membersCount: _parseCount(
          json['membersCount'] ?? json['members'] ?? json['memberCount']),
      eventsCount: _parseCount(
          json['eventsCount'] ?? json['events'] ?? json['eventCount']),
      memberImages: [
        "https://randomuser.me/api/portraits/men/1.jpg",
        "https://randomuser.me/api/portraits/women/2.jpg",
        "https://randomuser.me/api/portraits/men/3.jpg",
      ],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'type': type,
      'category': category,
      'imageUrl': imageUrl,
      'isJoined': isJoined,
      'membersCount': membersCount,
      'eventsCount': eventsCount,
    };
  }

  /// Helper method to safely parse count values that might be int or List
  static int? _parseCount(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is List) return value.length;
    if (value is String) {
      final parsed = int.tryParse(value);
      return parsed;
    }
    return null;
  }

  // Helper method to check if community belongs to a specific category (case-insensitive)
  bool hasCategory(String categoryName) {
    final lowerCategoryName = categoryName.toLowerCase();
    return category.any((cat) => cat.toLowerCase() == lowerCategoryName);
  }

  // Helper method to check if community belongs to any of the given categories (case-insensitive, EXACT match only)
  bool hasAnyCategory(List<String> categories) {
    if (category.isEmpty) return false;

    // Convert to lowercase for case-insensitive comparison
    final lowerCategories =
        categories.map((c) => c.toLowerCase().trim()).toList();
    final lowerCommunityCategories =
        category.map((c) => c.toLowerCase().trim()).toList();

    // Only check for EXACT matches (case-insensitive)
    for (var keyword in lowerCategories) {
      for (var cat in lowerCommunityCategories) {
        // Exact match only - no partial matching
        if (cat == keyword) {
          return true;
        }
      }
    }

    return false;
  }
}
