import 'package:venues_per_location/domain/entity/venue_entity_list_ext.dart';

import '../entity/venue_entity.dart';
import '../repository/locations_repository.dart';
import '../repository/venues_repository.dart';
import 'set_favorite_venue_use_case.dart';

const int _period = 10;

abstract class UseCase<Result> {
  Stream<Result> call();
}

class GetVenuesPerLocationUseCase implements UseCase<List<VenueEntity>> {
  GetVenuesPerLocationUseCase({
    required this.venuesRepository,
    required this.locationsRepository,
    required this.setFavoriteVenueUseCase,
  });

  final VenuesRepository venuesRepository;
  final LocationsRepository locationsRepository;
  final SetFavoriteVenueUseCase setFavoriteVenueUseCase;

  Future<List<VenueEntity>> _firstCall({
    required double lat,
    required double lon,
  }) async =>
      (await venuesRepository.getVenues(lat: lat, lon: lon))
          .checkFavorites(setFavoriteVenueUseCase.controller.value);

  @override
  Stream<List<VenueEntity>> call() async* {
    try {
      final locations = await locationsRepository.getLocations();

      yield await _firstCall(lat: locations[0].lat, lon: locations[0].lon);

      yield* Stream.periodic(const Duration(seconds: _period), (i) {
        final index = (i + 1) % 10;
        return venuesRepository.getVenues(
          lat: locations[index].lat,
          lon: locations[index].lon,
        );
      }).asyncMap((value) async {
        return (await value)
            .checkFavorites(setFavoriteVenueUseCase.controller.value);
      });
    } catch (_) {
      rethrow;
    }
  }
}
