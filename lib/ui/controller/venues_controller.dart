import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/dependency_injection.dart';
import '../../domain/entity/venue_entity.dart';
import '../../domain/use_case/get_venues_per_location_use_case.dart';
import '../../domain/use_case/set_favorite_venue_use_case.dart';

class VenuesCubitProvider extends BlocProvider<VenuesCubit> {
  VenuesCubitProvider({super.key, super.child})
      : super(
            create: (context) => VenuesCubit(
                  getVenuesPerLocationUseCase: di(),
                  setFavoriteVenueUseCase: di(),
                )..init());

  static VenuesCubit of(BuildContext context) =>
      BlocProvider.of<VenuesCubit>(context);
}

class VenuesCubit extends Cubit<VenuesState> {
  VenuesCubit({
    required this.getVenuesPerLocationUseCase,
    required this.setFavoriteVenueUseCase,
  }) : super(const VenuesState());

  final GetVenuesPerLocationUseCase getVenuesPerLocationUseCase;
  final SetFavoriteVenueUseCase setFavoriteVenueUseCase;

  late StreamSubscription<List<VenueEntity>> getVenuesPerLocationSubscription;
  late StreamSubscription<List<String>> setFavoriteSubscription;

  void init() {
    getVenuesPerLocationSubscription =
        getVenuesPerLocationUseCase.call().listen(
      (venues) {
        emit(state.copyWith(venues: venues));
      },
      onError: (error) {
        emit(state.copyWith(error: error));
      },
    );
    setFavoriteSubscription = setFavoriteVenueUseCase.stream.listen(
      (favoriteIds) {
        final venuesUpdated = List<VenueEntity>.of(state.venues ?? [])
            .map((venue) =>
                venue.copyWith(favorite: favoriteIds.contains(venue.id)))
            .toList();
        emit(state.copyWith(venues: venuesUpdated));
      },
      onError: (error) {
        emit(state.copyWith(error: error));
      },
    );
  }

  void setFavorite({required String id, required bool isFavorite}) {
    setFavoriteVenueUseCase.call(id: id, isFavorite: isFavorite);
  }

  @override
  Future<void> close() {
    getVenuesPerLocationSubscription.cancel();
    setFavoriteSubscription.cancel();
    return super.close();
  }
}

class VenuesState extends Equatable {
  const VenuesState({this.venues, this.error});

  final List<VenueEntity>? venues;
  final Object? error;

  VenuesState copyWith({
    List<VenueEntity>? venues,
    Object? error,
  }) =>
      VenuesState(
        venues: venues ?? this.venues,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [venues, error];
}
