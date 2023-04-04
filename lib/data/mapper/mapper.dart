import '../../domain/entity/location_entity.dart';
import '../../domain/entity/venue_entity.dart';
import '../dto/location_dto.dart';
import '../dto/venue_dto.dart';

mixin Mapper {
  VenueEntity mapToVenueEntity(VenueDTO from);

  LocationEntity mapToLocationEntity(LocationDTO from);
}

class MapperImpl implements Mapper {
  @override
  VenueEntity mapToVenueEntity(VenueDTO from) => VenueEntity(
        id: from.id,
        name: from.name,
        description: from.description,
        imageUrl: from.imageUrl,
        favorite: false,
      );

  @override
  LocationEntity mapToLocationEntity(LocationDTO from) => LocationEntity(
        lat: from.lat,
        lon: from.lon,
      );
}
