import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoWidget extends StatelessWidget {
  final double size;

  const LogoWidget({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Perguntando',
          style: GoogleFonts.ubuntu(
            fontSize: size,
          ),
        ),
        Text(
          'by Flutterando',
          style: TextStyle(fontSize: size * 0.5),
        ),
      ],
    );
  }
}
