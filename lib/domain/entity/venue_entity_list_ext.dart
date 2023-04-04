import 'venue_entity.dart';

extension VenueEntityListExtension on List<VenueEntity> {
  List<VenueEntity> checkFavorites(List<String> favorites) =>
      map((venue) => venue.copyWith(favorite: favorites.contains(venue.id)))
          .toList();
}
