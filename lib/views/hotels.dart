import 'package:apptravel/networks/models/hotels.dart';
import 'package:flutter/material.dart';

class SheetHotels extends StatefulWidget {
  final List<Map> hotels;
  const SheetHotels({required this.hotels, super.key});

  @override
  State<SheetHotels> createState() => _SheetHotelsState();
}

class _SheetHotelsState extends State<SheetHotels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hotels"),
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
      body: ListView.builder(
        itemCount: widget.hotels.length,
        itemBuilder: (context, index) {
          var hotel = widget.hotels[index];
          return Container(
            padding: EdgeInsets.all(12),
            child: Text(hotel["name"].toString()),
          );
        },
      ),
    );
  }
}
