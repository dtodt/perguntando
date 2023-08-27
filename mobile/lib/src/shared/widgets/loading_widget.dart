import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Center(
      child: SizedBox(
        width: size.width * 0.3,
        child: const RiveAnimation.asset(
          'assets/animations/loading.riv',
          animations: ['loading-1'],
        ),
      ),
    );
  }
}
