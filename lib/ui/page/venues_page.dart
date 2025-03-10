import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/venues_controller.dart';
import '../widget/error_view.dart';
import '../widget/loading_wrap.dart';
import '../widget/venues_list_view.dart';

class VenuesPage extends StatelessWidget {
  const VenuesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return VenuesCubitProvider(
      child: const VenuesScreen(),
    );
  }
}

class VenuesScreen extends StatelessWidget {
  const VenuesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<VenuesCubit, VenuesState>(
        builder: (context, state) {
          final venues = state.venues;
          if (venues != null) {
            return LoadingWrap(
              visible: state.loading == true,
              child: VenuesListView(
                venues: venues,
                onPressed: (id, isFavorite) => VenuesCubitProvider.of(context)
                    .setFavorite(id: id, isFavorite: isFavorite),
              ),
            );
          }
          if (state.error != null) {
            return const ErrorView();
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
