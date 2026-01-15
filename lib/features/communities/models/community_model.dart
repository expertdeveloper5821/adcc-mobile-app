class CommunityModel {
  final String id;
  final String title;
  final String description;
  final String type;
  final List<String> category;
  final String? imageUrl;
  final bool? isJoined;

  CommunityModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.category,
    this.imageUrl,
    this.isJoined,
  });

  factory CommunityModel.fromJson(Map<String, dynamic> json) {
    return CommunityModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      type: json['type'] ?? '',
      category: json['category'] != null
          ? List<String>.from(json['category'])
          : [],
      imageUrl: json['imageUrl'] ?? json['image'] ?? json['imagePath'],
      isJoined: json['isJoined'] ?? json['joined'] ?? false,
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
    };
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
    final lowerCategories = categories.map((c) => c.toLowerCase().trim()).toList();
    final lowerCommunityCategories = category.map((c) => c.toLowerCase().trim()).toList();
    
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
