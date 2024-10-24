import 'package:apptravel/networks/models/hotels.dart' as h;
import 'package:flutter/material.dart';

class SheetHotels extends StatefulWidget {
  final List<h.Feature> hotels;
  const SheetHotels({required this.hotels, super.key});

  @override
  State<SheetHotels> createState() => _SheetHotelsState();
}

class _SheetHotelsState extends State<SheetHotels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: widget.hotels.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(widget.hotels[index].properties.name),
            ),
          );
        },
      ),
    );
  }
}
