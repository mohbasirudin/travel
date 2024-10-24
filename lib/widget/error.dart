import 'package:flutter/material.dart';

class PageError extends StatefulWidget {
  final String? message;
  final Function() onReload;
  const PageError({
    this.message,
    required this.onReload,
    super.key,
  });

  @override
  State<PageError> createState() => _PageErrorState();
}

class _PageErrorState extends State<PageError> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.message ?? "Failed, try again!"),
          IconButton(
            onPressed: widget.onReload,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
