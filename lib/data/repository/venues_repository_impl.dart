import '../../domain/entity/venue_entity.dart';
import '../../domain/repository/venues_repository.dart';
import '../data_source/venues_local_data_source.dart';
import '../data_source/venues_remote_data_source.dart';
import '../mapper/mapper.dart';

class VenuesRepositoryImpl implements VenuesRepository {
  VenuesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.mapper,
  });

  final VenuesRemoteDataSource remoteDataSource;
  final VenuesLocalDataSource localDataSource;
  final Mapper mapper;

  @override
  Future<List<VenueEntity>> getVenues({
    required double lat,
    required double lon,
  }) async {
    try {
      final venues = await remoteDataSource.getVenues(lat: lat, lon: lon);
      return venues
          .map((e) => mapper.mapToVenueEntity(e))
          .toList(growable: false);
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<List<String>> getFavoriteVenues() async {
    try {
      return await localDataSource.getFavoriteVenues();
    } catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> setFavoriteVenue({
    required String id,
    required bool isFavorite,
  }) {
    try {
      return localDataSource.setFavoriteVenue(id: id, isFavorite: isFavorite);
    } catch (_) {
      rethrow;
    }
  }
}
