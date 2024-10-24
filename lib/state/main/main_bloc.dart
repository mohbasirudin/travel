import 'dart:convert';

import 'package:apptravel/networks/init.dart';
import 'package:apptravel/networks/models/hotels.dart';
import 'package:apptravel/networks/url.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(MainInitial()) {
    on<OnMainInit>(_onInit);
    on<OnMainChangedFrom>(_onChangeFrom);
    on<OnMainChangedTo>(_onChangeTo);
    on<OnMainChangedDate>(_onChangeDate);
  }

  void _onInit(var event, var emit) async {
    emit(MainLoading());
    try {
      var response = await http.get(Uri.parse(ApiUrl.provinces));
      var provinces = <String>[];
      if (response.statusCode == 200) {
        var maps = jsonDecode(response.body);
        for (var i = 0; i < maps.length; i++) {
          print("map: ${maps[i]}");
          var name = maps[i]["name"];
          provinces.add(name);
        }
      }

      var cities = <String>[
        "Jakarta",
        "Surabaya",
        "Bandung",
        "Medan",
        "Bekasi",
        "Depok",
        "Tangerang",
        "Palembang",
        "Semarang",
        "Makassar",
        "Batam",
        "Pekanbaru",
        "Bogor",
        "Malang",
        "Padang",
        "Denpasar",
        "Samarinda",
        "Tasikmalaya",
        "Serang",
        "Pontianak",
        "Banjarmasin",
        "Balikpapan",
        "Jambi",
        "Lampung",
        "Mataram",
        "Kupang",
        "Manado",
        "Jayapura",
        "Ambon",
        "Ternate",
        "Sorong",
        "Palu",
        "Kendari",
        "Gorontalo",
        "Yogyakarta",
        "Cirebon",
        "Tegal",
        "Purwokerto",
        "Solo",
        "Magelang",
        "Salatiga",
        "Cilacap",
        "Jember",
        "Banyuwangi",
        "Probolinggo",
        "Pasuruan",
        "Kediri",
        "Blitar",
        "Madiun",
        "Sidoarjo",
        "Gresik",
        "Batu",
        "Pontianak",
        "Samarinda",
        "Tarakan",
        "Tanjung Selor",
        "Palangkaraya",
        "Banjarmasin",
        "Banjarbaru",
        "Denpasar",
        "Mataram",
        "Kupang",
        "Jayapura",
        "Sorong"
      ];

      final mapController = MapController();
      var cLocation = await getCurrentLocation();
      var currentLatLng = const LatLng(0, 0);
      var hotels = <Map>[];
      if (cLocation != null) {
        currentLatLng = LatLng(cLocation.latitude, cLocation.longitude);
        var respHotel = await http.get(
          Uri.parse(
            ApiUrl.hotels(
              lat: currentLatLng.latitude,
              long: currentLatLng.longitude,
            ),
          ),
        );
        print("hotels: ${currentLatLng.latitude}, ${currentLatLng.longitude}");

        if (respHotel.statusCode == 200) {
          var maps = jsonDecode(respHotel.body);
          var features = maps["features"];
          for (var i = 0; i < features.length; i++) {
            var props = features[i]["properties"];
            if (props.containsKey("name")) {
              var name = props["name"];
              var lat = props["lat"];
              var long = props["lon"];

              hotels.add({
                "name": name,
                "lat": lat,
                "long": long,
              });
            }
          }
        }
      }

      var locHotels = <LatLng>[];
      for (var i = 0; i < hotels.length; i++) {
        locHotels.add(LatLng(hotels[i]["lat"], hotels[i]["long"]));
      }

      emit(MainLoaded(
        cities: cities,
        txtFrom: "-",
        txtTo: "-",
        txtDate: "-",
        mapController: mapController,
        currentLatLng: currentLatLng,
        locHotels: locHotels,
        hotels: hotels,
      ));
    } catch (e) {
      print("main error: $e");
      emit(MainError());
    }
  }

  static Future<Position?> getCurrentLocation() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }
    final location = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return location;
  }

  void _onChangeFrom(OnMainChangedFrom event, var emit) {
    final state = this.state;
    if (state is MainLoaded) {
      emit(state.copyWith(txtFrom: event.value));
    }
  }

  void _onChangeTo(OnMainChangedTo event, var emit) {
    final state = this.state;
    if (state is MainLoaded) {
      emit(state.copyWith(txtTo: event.value));
    }
  }

  void _onChangeDate(OnMainChangedDate event, var emit) {
    final state = this.state;
    if (state is MainLoaded) {
      emit(state.copyWith(txtDate: event.value));
    }
  }
}
