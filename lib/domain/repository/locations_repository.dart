import '../entity/location_entity.dart';

abstract class LocationsRepository {
  Future<List<LocationEntity>> getLocations();
}
