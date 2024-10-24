import 'package:apptravel/state/main/main_bloc.dart';
import 'package:apptravel/views/hotels.dart';
import 'package:apptravel/widget/error.dart';
import 'package:apptravel/widget/loading.dart';
import 'package:apptravel/widget/notif.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';

class PageMain extends StatefulWidget {
  const PageMain({super.key});

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  late MainBloc bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _onInit();
  }

  void _onInit() {
    bloc = context.read<MainBloc>();
    bloc.add(OnMainInit());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Travel"),
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainLoading) {
            return const PageLoading();
          }
          if (state is MainError) {
            return PageError(onReload: _onInit);
          }
          if (state is MainLoaded) {
            return _body(state);
          }
          return Container();
        },
      ),
      // body: _body(),
    );
  }

  Widget _body(MainLoaded state) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: _boxField(
                        "From",
                        value: state.copyWith().txtFrom,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            useSafeArea: true,
                            builder: (context) {
                              return _SheetBottom(
                                cities: state.copyWith().cities,
                                onTap: (value) {
                                  bloc.add(OnMainChangedFrom(value));
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _boxField(
                        "To",
                        value: state.copyWith().txtTo,
                        onTap: () {
                          if (state.copyWith().isMapLoading) {
                            Notif.snackbar(context, message: "Please wait...");
                            return;
                          }

                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            useSafeArea: true,
                            builder: (context) {
                              return _SheetBottom(
                                cities: state.copyWith().cities,
                                onTap: (value) {
                                  bloc.add(OnMainChangedTo(value));
                                  Navigator.pop(context);
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              _boxField(
                "Date",
                value: state.copyWith().txtDate,
                onTap: () async {
                  var result = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now().add(const Duration(days: 1)),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                  );
                  if (result != null) {
                    bloc.add(OnMainChangedDate(result.toString()));
                  }
                },
              ),
              // Container(
              //   height: 48,
              //   margin: const EdgeInsets.only(top: 12),
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(12),
              //     color: Colors.blue,
              //   ),
              //   child: Center(
              //     child: TextButton(
              //       onPressed: () {
              //         showModalBottomSheet(
              //           context: context,
              //           isScrollControlled: true,
              //           useSafeArea: true,
              //           builder: (context) {
              //             return SheetHotels(
              //               hotels: state.hotels,
              //             );
              //           },
              //         );
              //       },
              //       child: const Text(
              //         "Search",
              //         style: TextStyle(
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        Expanded(
          child: _viewMap(state),
        ),
      ],
    );
  }

  Widget _viewMap(MainLoaded state) {
    // var isMapLoading = state.copyWith().isMapLoading;
    // if (isMapLoading) {
    //   return const PageLoading();
    // }

    var locHotels = state.copyWith().locHotels;
    var cLoc = state.copyWith().currentLatLng;
    return FlutterMap(
      mapController: state.copyWith().mapController,
      options: MapOptions(
        initialCenter: cLoc!,
        initialZoom: 13,
        onTap: (pos, latlang) {},
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'id.basirudin.attendanceapp',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: state.copyWith().currentLatLng!,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ),
            if (locHotels.isNotEmpty)
              for (var i = 0; i < locHotels.length; i++)
                Marker(
                  point: locHotels[i],
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.blue),
                        child: const Icon(
                          Icons.hotel_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      Text(
                        state.hotels[i]['name'].toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "${state.hotels[i]['distance']} km",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
          ],
        ),
        CircleLayer(
          circles: [
            CircleMarker(
              point: state.copyWith().currentLatLng!,
              radius: 50,
              useRadiusInMeter: true,
              color: Colors.blue.withOpacity(0.1),
              borderColor: Colors.blue.withOpacity(0.7),
              borderStrokeWidth: 1,
            ),
          ],
        ),
      ],
    );
  }

  Widget _boxField(
    String label, {
    required String value,
    required Function() onTap,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 12,
          ),
          child: Text(label),
        ),
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1,
              ),
            ),
            child: Text(value),
          ),
        ),
      ],
    );
  }
}

class _SheetBottom extends StatefulWidget {
  final List<String> cities;
  final Function(String) onTap;
  const _SheetBottom({
    required this.cities,
    required this.onTap,
    super.key,
  });

  @override
  State<_SheetBottom> createState() => _SheetBottomState();
}

class _SheetBottomState extends State<_SheetBottom> {
  var data = <String>[];
  var cities = <String>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cities = widget.cities;
    data = cities;
  }

  void _onSearch(String value) {
    if (value.isEmpty) {
      data = cities;
    } else {
      data = cities
          .where(
              (element) => element.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cities"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: TextField(
              onChanged: _onSearch,
              decoration: InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
                fillColor: Colors.grey.shade200,
                filled: true,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index]),
                  onTap: () => widget.onTap(data[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
