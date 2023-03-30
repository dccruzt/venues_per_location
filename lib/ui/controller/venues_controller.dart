import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/dependency_injection.dart';
import '../../domain/entity/venue_entity.dart';
import '../../domain/use_case/update_location_use_case.dart';

class VenuesCubitProvider extends BlocProvider<VenuesCubit> {
  VenuesCubitProvider({super.key, super.child})
      : super(
            create: (context) =>
                VenuesCubit(updateLocationUseCase: di())..init());

  static VenuesCubit of(BuildContext context) =>
      BlocProvider.of<VenuesCubit>(context);
}

class VenuesCubit extends Cubit<VenuesState> {
  VenuesCubit({
    required this.updateLocationUseCase,
  }) : super(const VenuesState());

  final UpdateLocationUseCase updateLocationUseCase;

  void init() => updateLocationUseCase
      .call()
      .then((venues) => emit(state.copyWith(venues: venues)))
      .catchError((error) => emit(state.copyWith(error: error)));
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
