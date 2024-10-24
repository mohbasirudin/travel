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
  final LatLng? currentLatLng;
  final MapController? mapController;
  final List<LatLng> locHotels;
  final List<Feature> hotels;

  const MainLoaded({
    required this.cities,
    required this.txtFrom,
    required this.txtTo,
    required this.txtDate,
    this.currentLatLng,
    this.mapController,
    this.locHotels = const [],
    this.hotels = const [],
  });

  MainLoaded copyWith({
    List<String>? cities,
    String? txtFrom,
    String? txtTo,
    String? txtDate,
    LatLng? currentLatLng,
    MapController? mapController,
    List<LatLng>? locHotels,
    List<Feature>? hotels,
  }) =>
      MainLoaded(
        cities: cities ?? this.cities,
        txtFrom: txtFrom ?? this.txtFrom,
        txtTo: txtTo ?? this.txtTo,
        txtDate: txtDate ?? this.txtDate,
        currentLatLng: currentLatLng ?? this.currentLatLng,
        mapController: mapController ?? this.mapController,
        locHotels: locHotels ?? this.locHotels,
        hotels: hotels ?? this.hotels,
      );

  @override
  List<dynamic> get props => [
        cities,
        txtFrom,
        txtTo,
        txtDate,
        currentLatLng,
        mapController,
        locHotels,
        hotels,
      ];
}

class MainError extends MainState {}
