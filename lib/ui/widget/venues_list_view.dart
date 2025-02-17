import 'package:flutter/material.dart';

import '../../core/design_system/components/action_row.dart';
import '../../core/design_system/components/custom_divider.dart';
import '../../core/design_system/spacings.dart';
import '../../domain/entity/venue_entity.dart';
import 'favorite_button_icon.dart';

class VenuesListView extends StatelessWidget {
  const VenuesListView({
    super.key,
    required this.venues,
    required this.onPressed,
  });

  final List<VenueEntity> venues;
  final Function(String id, bool isFavorite) onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            onPressed: () => onPressed.call(venue.id, !venue.favorite),
          ),
          onTap: () {},
        );
      },
      separatorBuilder: (context, index) => const CustomDivider(),
      itemCount: venues.length,
    );
  }
}
