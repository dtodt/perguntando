import 'package:flutter/material.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/talk_entity.dart';

class TalkCardWidget extends StatelessWidget {
  final TalkEntryEntity entity;
  final VoidCallback onTap;

  const TalkCardWidget({super.key, required this.entity, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(entity.imageUrl)),
      title: Text(entity.description),
      subtitle: Text(entity.speaker),
      onTap: onTap,
    );
  }
}
