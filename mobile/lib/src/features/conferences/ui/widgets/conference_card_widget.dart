import 'package:flutter/material.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/conference_entity.dart';

class ConferenceCardWidget extends StatelessWidget {
  final ConferenceEntryEntity entity;
  final VoidCallback onTap;

  const ConferenceCardWidget({
    super.key,
    required this.entity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        child: Card(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Stack(
              children: [
                Image.network(entity.imageUrl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
