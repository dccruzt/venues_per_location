import 'package:get_it/get_it.dart';

import '../data/data_source/locations_local_data_source.dart';
import '../data/data_source/venues_local_data_source.dart';
import '../data/data_source/venues_remote_data_source.dart';
import '../data/mapper/mapper.dart';
import '../data/repository/locations_repository_impl.dart';
import '../data/repository/venues_repository_impl.dart';
import '../domain/repository/locations_repository.dart';
import '../domain/repository/venues_repository.dart';
import '../domain/use_case/get_venues_per_location_use_case.dart';
import '../domain/use_case/set_favorite_venue_use_case.dart';

GetIt get di => GetIt.instance;

Future<void> setUpDependencies() async {
  di.registerLazySingleton(
    () => SetFavoriteVenueUseCase(
      venuesRepository: di(),
    ),
  );

  di.registerFactory(
    () => GetVenuesPerLocationUseCase(
      venuesRepository: di(),
      locationsRepository: di(),
      setFavoriteVenueUseCase: di(),
    ),
  );

  di.registerFactory<VenuesRepository>(
    () => VenuesRepositoryImpl(
      remoteDataSource: di(),
      localDataSource: di(),
      mapper: di(),
    ),
  );

  di.registerFactory(() => VenuesRemoteDataSource());

  di.registerFactory(() => VenuesLocalDataSource());

  di.registerFactory<LocationsRepository>(
    () => LocationsRepositoryImpl(
      localDataSource: di(),
      mapper: di(),
    ),
  );

  di.registerFactory(() => LocationsLocalDataSource());

  di.registerFactory<Mapper>(() => MapperImpl());
}
