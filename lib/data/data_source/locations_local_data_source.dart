import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../dto/location_dto.dart';

class LocationsLocalDataSource {
  Future<Iterable<LocationDTO>> getLocations() async {
    try {
      String data = await rootBundle.loadString("assets/json/locations.json");

      final json = (jsonDecode(data) as Iterable);
      return json.map((item) => LocationDTO.fromJson(item));
    } catch (_) {
      rethrow;
    }
  }
}
