import 'package:apptravel/state/main/main_bloc.dart';
import 'package:apptravel/widget/error.dart';
import 'package:apptravel/widget/loading.dart';
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
                          showBottomSheet(
                            context: context,
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
                          showBottomSheet(
                            context: context,
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
                onTap: () {},
              ),
              Container(
                height: 48,
                margin: const EdgeInsets.only(top: 12),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.blue,
                ),
                child: Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Search",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _viewMap(),
        ),
      ],
    );
  }

  Widget _viewMap() {
    return Container();
    // return FlutterMap(
    //   mapController: state.mapController,
    //   options: MapOptions(
    //     initialCenter: cLocation,
    //     initialZoom: 18,
    //     onTap: (pos, latlang) {},
    //   ),
    //   children: [
    //     TileLayer(
    //       urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    //       userAgentPackageName: 'id.basirudin.attendanceapp',
    //     ),
    //     MarkerLayer(
    //       markers: [],
    //     ),
    //   ],
    // );
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
  void _onSearch(String value) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pilih Kota"),
      ),
      body: Column(
        children: [
          TextField(
            onChanged: _onSearch,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.cities.length,
              padding: const EdgeInsets.all(12),
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(widget.cities[index]),
                  onTap: () => widget.onTap(widget.cities[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
