import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../dto/venue_dto.dart';

class VenuesRemoteDataSource {
  Future<List<VenueDTO>> getVenues({
    required double lat,
    required double lon,
  }) async {
    try {
      final url = Uri.https(
        'restaurant-api.wolt.com',
        'v1/pages/restaurants',
        {'lat': lat.toString(), 'lon': lon.toString()},
      );

      final response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final json =
            jsonDecode(response.body)['sections'][1]['items'] as Iterable;
        return json
            .take(15)
            .map((venue) => VenueDTO.fromJson(venue))
            .toList(growable: false);
      }
      throw Exception();
    } catch (_) {
      rethrow;
    }
  }
}
