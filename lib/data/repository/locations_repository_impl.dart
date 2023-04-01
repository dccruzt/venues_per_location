import '../../domain/entity/location_entity.dart';
import '../../domain/repository/locations_repository.dart';
import '../data_source/locations_local_data_source.dart';
import '../mapper/mapper.dart';

class LocationsRepositoryImpl implements LocationsRepository {
  LocationsRepositoryImpl({
    required this.localDataSource,
    required this.mapper,
  });

  final LocationsLocalDataSource localDataSource;
  final Mapper mapper;

  @override
  Future<List<LocationEntity>> getLocations() async {
    try {
      final locations = await localDataSource.getLocations();
      return locations
          .map((e) => mapper.mapToLocationEntity(e))
          .toList(growable: false);
    } catch (_) {
      rethrow;
    }
  }
}
