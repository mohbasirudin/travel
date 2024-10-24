part of 'main_bloc.dart';

sealed class MainState extends Equatable {
  const MainState();

  @override
  List<dynamic> get props => [];
}

class MainInitial extends MainState {}

class MainLoading extends MainState {}

class MainLoaded extends MainState {
  final List<String> cities;
  final String txtFrom;
  final String txtTo;
  final String txtDate;

  const MainLoaded({
    required this.cities,
    required this.txtFrom,
    required this.txtTo,
    required this.txtDate,
  });

  MainLoaded copyWith({
    List<String>? cities,
    String? txtFrom,
    String? txtTo,
    String? txtDate,
  }) =>
      MainLoaded(
        cities: cities ?? this.cities,
        txtFrom: txtFrom ?? this.txtFrom,
        txtTo: txtTo ?? this.txtTo,
        txtDate: txtDate ?? this.txtDate,
      );

  @override
  List<dynamic> get props => [
        cities,
        txtFrom,
        txtTo,
        txtDate,
      ];
}

class MainError extends MainState {}
