import 'package:flutter/material.dart';

class PageLoading extends StatefulWidget {
  const PageLoading({super.key});

  @override
  State<PageLoading> createState() => _PageLoadingState();
}

class _PageLoadingState extends State<PageLoading> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
