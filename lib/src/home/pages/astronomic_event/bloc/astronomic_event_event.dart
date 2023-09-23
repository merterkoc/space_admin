part of 'astronomic_event_bloc.dart';

@immutable
abstract class AstronomicEventEvent extends Equatable {
  const AstronomicEventEvent();

  @override
  List<Object> get props => [];
}

class AddAstronomicEvent extends AstronomicEventEvent {
  final AstronomicEventModel astronomicEventModel;

  const AddAstronomicEvent(this.astronomicEventModel);

  @override
  List<Object> get props => [astronomicEventModel];
}

class GetAstronomicEvent extends AstronomicEventEvent {
  const GetAstronomicEvent();
}

class UpdateAstronomicEvent extends AstronomicEventEvent {
  final AstronomicEventModel astronomicEventModel;

  const UpdateAstronomicEvent(this.astronomicEventModel);

  @override
  List<Object> get props => [astronomicEventModel];
}
