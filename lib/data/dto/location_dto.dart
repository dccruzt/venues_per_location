class LocationDTO {
  LocationDTO({
    required this.lat,
    required this.lon,
  });

  final double lat;
  final double lon;

  factory LocationDTO.fromJson(Map<String, dynamic> json) => LocationDTO(
        lat: json['lat'],
        lon: json['lon'],
      );
}
