import '../entity/venue_entity.dart';
import '../repository/venues_repository.dart';

abstract class UseCase<Result> {
  Future<Result> call();
}

class UpdateLocationUseCase implements UseCase<List<VenueEntity>> {
  UpdateLocationUseCase({required this.repository});

  final VenuesRepository repository;

  @override
  Future<List<VenueEntity>> call() {
    try {
      return repository.getVenues(lat: 60.170187, lon: 24.930599);
    } catch (_) {
      rethrow;
    }
  }
}
