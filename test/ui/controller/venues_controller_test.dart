// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/annotations.dart';
// import 'package:mockito/mockito.dart';
// import 'package:venues_per_location/domain/entity/venue_entity.dart';
// import 'package:venues_per_location/domain/use_case/get_venues_per_location_use_case.dart';
// import 'package:venues_per_location/domain/use_case/set_favorite_venue_use_case.dart';
// import 'package:venues_per_location/ui/controller/venues_controller.dart';
//
// import 'venues_controller_test.mocks.dart';
//
// class MockStream extends Mock implements Stream<List<VenueEntity>> {}
//
// @GenerateMocks([GetVenuesPerLocationUseCase, SetFavoriteVenueUseCase])
// void main() {
//   late MockGetVenuesPerLocationUseCase getVenuesPerLocationUseCase;
//   late MockSetFavoriteVenueUseCase setFavoriteVenueUseCase;
//   late MockStream stream;
//
//   setUp(() {
//     getVenuesPerLocationUseCase = MockGetVenuesPerLocationUseCase();
//     setFavoriteVenueUseCase = MockSetFavoriteVenueUseCase();
//     stream = MockStream();
//   });
//
//   final venue1 = VenueEntity(
//     id: '1',
//     name: 'Venue name 1',
//     description: 'Venue description 1',
//     imageUrl: 'image://venue-1',
//     favorite: false,
//   );
//
//   final venue2 = VenueEntity(
//     id: '2',
//     name: 'Venue name 2',
//     description: 'Venue description 2',
//     imageUrl: 'image://venue-2',
//     favorite: true,
//   );
//
//   final venue3 = VenueEntity(
//     id: '3',
//     name: 'Venue name 3',
//     description: 'Venue description 3',
//     imageUrl: 'image://venue-3',
//     favorite: true,
//   );
//
//   final venues = [venue1, venue2, venue3];
//
//   var error = Error();
//
//   Stream<List<VenueEntity>> streamFunc() async* {
//     yield [venue1, venue2, venue3];
//   }
//
//   group('#validate', () {
//     blocTest(
//       'should return venues',
//       build: () => VenuesCubit(
//         getVenuesPerLocationUseCase: getVenuesPerLocationUseCase,
//         setFavoriteVenueUseCase: setFavoriteVenueUseCase,
//       ),
//       setUp: () {
//         when(stream.listen(any)).thenAnswer((Invocation inv) =>
//             streamFunc().listen(inv.positionalArguments.single));
//       },
//       act: (cubit) => cubit.init(),
//       expect: () => [VenuesState(venues: venues)],
//       verify: (cubit) => verify(getVenuesPerLocationUseCase.call()).called(1),
//     );
//   });
// }
