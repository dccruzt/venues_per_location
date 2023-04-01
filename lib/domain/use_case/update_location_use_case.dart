import '../entity/venue_entity.dart';
import '../repository/locations_repository.dart';
import '../repository/venues_repository.dart';

const int _period = 10;

abstract class UseCase<Result> {
  Stream<Result> call();
}

class UpdateLocationUseCase implements UseCase<List<VenueEntity>> {
  UpdateLocationUseCase({
    required this.venuesRepository,
    required this.locationsRepository,
  });

  final VenuesRepository venuesRepository;
  final LocationsRepository locationsRepository;

  @override
  Stream<List<VenueEntity>> call() async* {
    try {
      final locations = await locationsRepository.getLocations();

      yield* Stream.periodic(const Duration(seconds: _period), (i) {
        final index = (i + 1) % 10;
        return venuesRepository.getVenues(
          lat: locations[index].lat,
          lon: locations[index].lon,
        );
      }).asyncMap((value) async => await value);
    } catch (_) {
      rethrow;
    }
  }
}
