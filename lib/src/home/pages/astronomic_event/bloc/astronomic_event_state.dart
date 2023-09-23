part of 'astronomic_event_bloc.dart';

@immutable
class AstronomicEventState extends Equatable {
  final List<AstronomicEventModel> astronomicEventList;
  final OperationType? operation;
  final PageState pageState;
  final String? errorMessage;

  const AstronomicEventState({
    required this.astronomicEventList,
    this.operation,
    this.pageState = PageState.idle,
    this.errorMessage,
  });

  factory AstronomicEventState.initial() => const AstronomicEventState(
        astronomicEventList: [],
        operation: null,
        pageState: PageState.idle,
        errorMessage: null,
      );

  AstronomicEventState copyWith({
    List<AstronomicEventModel>? astronomicEventList,
    OperationType? operation,
    PageState? pageState,
    String? errorMessage,
  }) {
    return AstronomicEventState(
      astronomicEventList: astronomicEventList ?? this.astronomicEventList,
      operation: operation ?? this.operation,
      pageState: pageState ?? this.pageState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        astronomicEventList,
        operation,
        pageState,
        errorMessage,
      ];
}
