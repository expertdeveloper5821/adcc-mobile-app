class TrackModel {
  final String id;
  final String title;
  final String description;
  final String image; 
  final String city;
  final String address;
  final String zipcode;
  final num? distance;
  final String elevation;
  final String type;
  final String avgtime;
  final String pace;
  final List<String> facilities;

  final String status;
  final String country;
  final String difficulty;
  final int? displayPriority;
  final String estimatedTime;
  final bool helmetRequired;
  final bool nightRidingAllowed;
  final String slug;
  final String trackType;
  final String visibility;
  final String surfaceType;

  TrackModel({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.city,
    required this.address,
    required this.zipcode,
    required this.distance,
    required this.elevation,
    required this.type,
    required this.avgtime,
    required this.pace,
    required this.facilities,
    required this.status,
    required this.country,
    required this.difficulty,
    required this.displayPriority,
    required this.estimatedTime,
    required this.helmetRequired,
    required this.nightRidingAllowed,
    required this.slug,
    required this.trackType,
    required this.visibility,
    required this.surfaceType,
  });

  factory TrackModel.fromJson(Map<String, dynamic> json) {
    return TrackModel(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      image: json["image"] ?? "",
      city: json["city"] ?? "",
      address: json["address"] ?? "",
      zipcode: json["zipcode"] ?? "",
      distance: json["distance"],
      elevation: json["elevation"] ?? "",
      type: json["type"] ?? "",
      avgtime: json["avgtime"] ?? "",
      pace: json["pace"] ?? "",
      facilities: (json["facilities"] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          [],
      status: json["status"] ?? "",
      country: json["country"] ?? "",
      difficulty: json["difficulty"] ?? "",
      displayPriority: json["displayPriority"],
      estimatedTime: json["estimatedTime"]?.toString() ?? "",
      helmetRequired: json["helmetRequired"] ?? false,
      nightRidingAllowed: json["nightRidingAllowed"] ?? false,
      slug: json["slug"] ?? "",
      trackType: json["trackType"] ?? "",
      visibility: json["visibility"] ?? "",
      surfaceType: json["surfaceType"] ?? "",
    );
  }
}
