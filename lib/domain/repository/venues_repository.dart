import '../entity/venue_entity.dart';

abstract class VenuesRepository {
  Future<List<VenueEntity>> getVenues({
    required double lat,
    required double lon,
  });
}
