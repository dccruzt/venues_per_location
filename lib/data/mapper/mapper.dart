import '../../domain/entity/venue_entity.dart';
import '../dto/venue_dto.dart';

mixin Mapper {
  VenueEntity mapToVenueEntity(VenueDTO from);
}

class MapperImpl implements Mapper {
  @override
  VenueEntity mapToVenueEntity(VenueDTO from) => VenueEntity(
        id: from.id,
        name: from.name,
        description: from.description,
        imageUrl: from.imageUrl,
      );
}
