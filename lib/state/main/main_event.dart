part of 'main_bloc.dart';

sealed class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<dynamic> get props => [];
}

class OnMainInit extends MainEvent {}

class OnMainChangedFrom extends MainEvent {
  final String value;
  const OnMainChangedFrom(this.value);
}

class OnMainChangedTo extends MainEvent {
  final String value;
  const OnMainChangedTo(this.value);
}

class OnMainChangedDate extends MainEvent {
  final String value;
  const OnMainChangedDate(this.value);
}
