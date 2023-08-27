import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  final String message;
  final VoidCallback onTap;

  const FailureWidget({super.key, required this.message, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message),
          ElevatedButton(
            onPressed: onTap,
            child: const Text('Tentar novamente'),
          )
        ],
      ),
    );
  }
}
