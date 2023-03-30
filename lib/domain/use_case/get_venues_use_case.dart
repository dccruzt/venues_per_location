import '../entity/venue_entity.dart';
import '../repository/venues_repository.dart';

abstract class UseCase<Result> {
  Future<Result> call({required double lat, required double lon});
}

class GetVenuesUseCase implements UseCase<List<VenueEntity>> {
  GetVenuesUseCase({required this.repository});

  final VenuesRepository repository;

  @override
  Future<List<VenueEntity>> call({required double lat, required double lon}) {
    try {
      return repository.getVenues(lat: lat, lon: lon);
    } catch (_) {
      rethrow;
    }
  }
}
