import 'package:get_it/get_it.dart';

import '../data/data_source/venues_remote_data_source.dart';
import '../data/mapper/mapper.dart';
import '../data/repository/venues_repository_impl.dart';
import '../domain/repository/venues_repository.dart';
import '../domain/use_case/update_location_use_case.dart';

GetIt get di => GetIt.instance;

Future<void> setUpDependencies() async {
  di.registerFactory<Mapper>(() => MapperImpl());

  di.registerFactory(() => VenuesRemoteDataSource());

  di.registerFactory<VenuesRepository>(() => VenuesRepositoryImpl(
        remoteDataSource: di(),
        mapper: di(),
      ));

  di.registerFactory(() => UpdateLocationUseCase(repository: di()));
}
