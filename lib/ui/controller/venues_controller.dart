import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:venues_per_location/domain/entity/venue_entity_list_ext.dart';

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
              (venues) => venues.isEmpty
                  ? emit(state.copyWith(loading: true))
                  : emit(state.copyWith(loading: false, venues: venues)),
              onError: (error) =>
                  emit(state.copyWith(loading: false, error: error)),
            );

    setFavoriteSubscription = setFavoriteVenueUseCase.stream.listen(
      (favoriteIds) => emit(
        state.copyWith(
          venues: List<VenueEntity>.of(state.venues ?? [])
              .checkFavorites(favoriteIds),
        ),
      ),
      onError: (error) => emit(state.copyWith(error: error)),
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
  const VenuesState({this.loading, this.venues, this.error});

  final bool? loading;
  final List<VenueEntity>? venues;
  final Object? error;

  VenuesState copyWith({
    bool? loading,
    List<VenueEntity>? venues,
    Object? error,
  }) =>
      VenuesState(
        loading: loading ?? this.loading,
        venues: venues ?? this.venues,
        error: error ?? this.error,
      );

  @override
  List<Object?> get props => [loading, venues, error];
}
