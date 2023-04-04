import '../entity/venue_entity.dart';

abstract class VenuesRepository {
  Future<List<VenueEntity>> getVenues({
    required double lat,
    required double lon,
  });

  Future<List<String>> getFavoriteVenues();

  Future<void> setFavoriteVenue({required String id, required bool isFavorite});
}
