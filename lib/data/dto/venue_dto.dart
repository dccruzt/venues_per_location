class VenueDTO {
  VenueDTO({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String description;
  final String imageUrl;

  factory VenueDTO.fromJson(Map<String, dynamic> json) => VenueDTO(
        id: json['venue']['id'],
        name: json['venue']['name'],
        description: json['venue']['short_description'],
        imageUrl: json['image']['url'],
      );
}
