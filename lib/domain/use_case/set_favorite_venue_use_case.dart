import 'package:rxdart/rxdart.dart';

import '../repository/venues_repository.dart';

abstract class UseCase<Result> {
  Future<void> call({required String id, required bool isFavorite});
}

class SetFavoriteVenueUseCase implements UseCase<void> {
  SetFavoriteVenueUseCase({
    required this.venuesRepository,
  });

  final VenuesRepository venuesRepository;

  late final controller =
      BehaviorSubject<List<String>>.seeded([], onListen: read);

  Stream<List<String>> get stream => controller.stream;

  Future<void> read() async {
    final favorites = await venuesRepository.getFavoriteVenues();
    controller.add(favorites);
  }

  @override
  Future<void> call({required String id, required bool isFavorite}) async {
    try {
      await venuesRepository.setFavoriteVenue(id: id, isFavorite: isFavorite);
      if (controller.hasValue) {
        final updatedVenues =
            List.of(await venuesRepository.getFavoriteVenues());
        controller.add(updatedVenues);
      }
    } catch (_) {
      rethrow;
    }
  }
}
