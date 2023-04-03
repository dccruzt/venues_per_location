import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/design_system/components/action_row.dart';
import '../../core/design_system/components/custom_divider.dart';
import '../../core/design_system/spacings.dart';
import '../controller/venues_controller.dart';
import 'loading_page.dart';

class VenuesPage extends StatelessWidget {
  const VenuesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: VenuesCubitProvider(
        child: BlocBuilder<VenuesCubit, VenuesState>(
          builder: (context, state) {
            final venues = state.venues;

            if (venues != null && venues.isNotEmpty) {
              return ListView.separated(
                itemBuilder: (context, index) => ActionRow(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      venues[index].imageUrl,
                      fit: BoxFit.cover,
                      width: x20,
                      height: x20,
                    ),
                  ),
                  primary: Text(venues[index].name, maxLines: 2),
                  secondary: Text(venues[index].description, maxLines: 2),
                  trailing: const Icon(Icons.favorite),
                  onTap: () {},
                ),
                separatorBuilder: (context, index) => const CustomDivider(),
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
