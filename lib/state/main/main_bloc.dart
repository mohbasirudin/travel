import 'dart:convert';

import 'package:apptravel/networks/init.dart';
import 'package:apptravel/networks/url.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

      emit(MainLoaded(
        cities: cities,
        txtFrom: "-",
        txtTo: "-",
        txtDate: "-",
      ));
    } catch (e) {
      emit(MainError());
    }
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
      emit(state.copyWith(txtTo: event.value));
    }
  }
}
