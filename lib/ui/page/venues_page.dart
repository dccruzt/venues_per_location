import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/venues_controller.dart';
import 'loading_page.dart';

class VenuesPage extends StatelessWidget {
  const VenuesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VenuesCubitProvider(
        child: BlocBuilder<VenuesCubit, VenuesState>(
          builder: (context, state) {
            final venues = state.venues;

            if (venues != null && venues.isNotEmpty) {
              return ListView.separated(
                itemBuilder: (context, index) => Text(venues[index].name),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: venues.length,
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
