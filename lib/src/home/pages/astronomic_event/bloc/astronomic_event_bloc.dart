import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:space_admin/src/common/model/operation_model_enum.dart';
import 'package:space_admin/src/common/model/page_state_enum.dart';
import 'package:space_admin/src/home/pages/astronomic_event/model/astronomic_event_model.dart';
import 'package:space_admin/src/repository/repository.dart';

part 'astronomic_event_event.dart';

part 'astronomic_event_state.dart';

class AstronomicEventBloc
    extends Bloc<AstronomicEventEvent, AstronomicEventState> {
  final AstronomicEventRepository astronomicEventRepository;

  AstronomicEventBloc(this.astronomicEventRepository)
      : super(AstronomicEventState.initial()) {
    on<AddAstronomicEvent>((event, emit) => (_addAstronomicEvent(event, emit)));
    on<GetAstronomicEvent>((event, emit) => (_getAstronomicEvent(event, emit)));
    on<UpdateAstronomicEvent>(
        (event, emit) => (_updateAstronomicEvent(event, emit)));
  }

  Future<void> _getAstronomicEvent(
      GetAstronomicEvent event, Emitter<AstronomicEventState> emit) async {
    await astronomicEventRepository.getAstronomicEvent().then((value) {
      emit(state.copyWith(
          astronomicEventList: value.data as List<AstronomicEventModel>));
    }).catchError((e) {
      emit(state.copyWith(astronomicEventList: []));
    });
  }

  Future<void> _updateAstronomicEvent(
      UpdateAstronomicEvent event, Emitter<AstronomicEventState> emit) async {
    emit(state.copyWith(
        pageState: PageState.loading, operation: OperationType.edit));
    await Future.delayed(const Duration(seconds: 1));
    await astronomicEventRepository
        .updateAstronomicEvent(event.astronomicEventModel)
        .then((value) {
      value.statusCode == 200
          ? emit(state.copyWith(pageState: PageState.success))
          : emit(state.copyWith(
              pageState: PageState.error, errorMessage: value.message));
    }).catchError((e) {
      emit(state.copyWith(
          pageState: PageState.error, errorMessage: e.toString()));
    });
  }

  Future<void> _addAstronomicEvent(AddAstronomicEvent event, Emitter<AstronomicEventState> emit) async{
    emit(state.copyWith(pageState: PageState.loading, operation: OperationType.add));
    await Future.delayed(const Duration(seconds: 1));
    await astronomicEventRepository.addAstronomicEvent(event.astronomicEventModel).then((value) {
      value.statusCode == 200
          ? emit(state.copyWith(pageState: PageState.success))
          : emit(state.copyWith(
              pageState: PageState.error, errorMessage: value.message));
    }).catchError((e) {
      emit(state.copyWith(
          pageState: PageState.error, errorMessage: e.toString()));
    });

  }
}

