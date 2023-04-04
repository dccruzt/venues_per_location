import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/design_system/components/action_row.dart';
import '../../core/design_system/components/custom_divider.dart';
import '../../core/design_system/spacings.dart';
import '../controller/venues_controller.dart';
import '../widget/favorite_button_icon.dart';
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
              return ListView.separated(
                itemBuilder: (context, index) {
                  final venue = venues[index];

                  return ActionRow(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(x2),
                      child: Image.network(
                        venue.imageUrl,
                        fit: BoxFit.cover,
                        width: x20,
                        height: x20,
                      ),
                    ),
                    primary: Text(
                      venue.name,
                      maxLines: 2,
                      style: theme.textTheme.titleMedium,
                    ),
                    secondary: Text(venue.description, maxLines: 2),
                    trailing: FavoriteButtonIcon(
                      venue.favorite ? Icons.favorite : Icons.favorite_outline,
                      onPressed: () =>
                          VenuesCubitProvider.of(context).setFavorite(
                        id: venue.id,
                        isFavorite: !venue.favorite,
                      ),
                    ),
                    onTap: () {},
                  );
                },
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
