class VenueEntity {
  VenueEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.favorite,
  });

  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final bool favorite;

  VenueEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    bool? favorite,
  }) =>
      VenueEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        favorite: favorite ?? this.favorite,
      );
}
