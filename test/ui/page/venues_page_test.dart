import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:venues_per_location/core/design_system/components/action_row.dart';
import 'package:venues_per_location/domain/entity/venue_entity.dart';
import 'package:venues_per_location/ui/controller/venues_controller.dart';
import 'package:venues_per_location/ui/page/venues_page.dart';

class MockVenuesCubit extends MockCubit<VenuesState> implements VenuesCubit {}

class VenuesStateFake extends Fake implements VenuesState {}

void main() {
  late MockVenuesCubit venuesCubit;

  setUp(() {
    venuesCubit = MockVenuesCubit();
  });

  setUpAll(() {
    registerFallbackValue(VenuesStateFake());
  });

  List<VenueEntity> venues = [
    VenueEntity(
      id: '1',
      name: 'Venue name 1',
      description: 'Venue description 1',
      imageUrl: 'https://consumer-static-assets.wolt.com/og_image_mall_web.jpg',
      favorite: false,
    ),
    VenueEntity(
      id: '2',
      name: 'Venue name 2',
      description: 'Venue description 2',
      imageUrl: 'https://consumer-static-assets.wolt.com/og_image_mall_web.jpg',
      favorite: true,
    ),
  ];

  Widget buildVenuesScreen() => MaterialApp(
        builder: (context, widget) => MultiBlocProvider(
          providers: [
            BlocProvider<VenuesCubit>(
              create: (BuildContext ctx) => venuesCubit,
            ),
          ],
          child: const VenuesScreen(),
        ),
      );

  testWidgets('venues screen loaded renders well', (WidgetTester tester) async {
    when(() => venuesCubit.state).thenReturn(
      VenuesState(venues: venues),
    );

    mockNetworkImagesFor(
      () async {
        await tester.pumpWidget(buildVenuesScreen());

        await tester.pumpAndSettle();

        expect(find.text('Venue name 1'), findsOneWidget);
        expect(find.text('Venue name 2'), findsOneWidget);
        expect(find.byIcon(Icons.favorite), findsOneWidget);
        expect(find.byIcon(Icons.favorite_outline), findsOneWidget);
        expect(find.byType(ActionRow), findsNWidgets(2));
        expect(find.byType(Image), findsNWidgets(2));
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.text('ERROR'), findsNothing);
      },
    );
  });

  testWidgets('venues screen loading renders well',
      (WidgetTester tester) async {
    when(() => venuesCubit.state).thenReturn(
      const VenuesState(loading: true, venues: []),
    );

    mockNetworkImagesFor(
      () async {
        await tester.pumpWidget(buildVenuesScreen());

        await tester.pump();

        expect(find.text('Venue name 1'), findsNothing);
        expect(find.text('Venue name 2'), findsNothing);
        expect(find.byIcon(Icons.favorite), findsNothing);
        expect(find.byIcon(Icons.favorite_outline), findsNothing);
        expect(find.byType(ActionRow), findsNothing);
        expect(find.byType(Image), findsNothing);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('ERROR'), findsNothing);
      },
    );
  });

  testWidgets('venues screen error renders well', (WidgetTester tester) async {
    when(() => venuesCubit.state).thenReturn(
      VenuesState(error: Exception('There is an error')),
    );

    mockNetworkImagesFor(
      () async {
        await tester.pumpWidget(buildVenuesScreen());

        await tester.pump();

        expect(find.text('Venue name 1'), findsNothing);
        expect(find.text('Venue name 2'), findsNothing);
        expect(find.byIcon(Icons.favorite), findsNothing);
        expect(find.byIcon(Icons.favorite_outline), findsNothing);
        expect(find.byType(ActionRow), findsNothing);
        expect(find.byType(Image), findsNothing);
        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.text('ERROR'), findsOneWidget);
      },
    );
  });
}
