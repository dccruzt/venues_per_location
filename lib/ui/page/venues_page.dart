import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:venues_per_location/ui/widget/venues_list_view.dart';

import '../controller/venues_controller.dart';
import 'loading_page.dart';

class VenuesPage extends StatelessWidget {
  const VenuesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(),
      body: VenuesCubitProvider(
        child: BlocBuilder<VenuesCubit, VenuesState>(
          builder: (context, state) {
            final venues = state.venues;

            if (venues != null && venues.isNotEmpty) {
              return VenuesListView(
                venues: venues,
                onPressed: (id, isFavorite) => VenuesCubitProvider.of(context)
                    .setFavorite(id: id, isFavorite: isFavorite),
              );
            }
            if (state.error != null) {
              return const Text('ERROR');
            }
            return const LoadingPage();
          },
        ),
      ),
    );
  }
}
