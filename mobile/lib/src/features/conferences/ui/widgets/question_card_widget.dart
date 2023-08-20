import 'package:flutter/material.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/question_entity.dart';

class QuestionCardWidget extends StatelessWidget {
  final QuestionEntryEntity entity;
  final VoidCallback onLike;
  final VoidCallback onRemove;

  const QuestionCardWidget({
    super.key,
    required this.entity,
    required this.onLike,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(entity.profileImage),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          entity.profileName,
                          style: theme.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8.0),
                        Text(entity.text),
                      ],
                    ),
                  ),
                ),
                if (entity.isMine && !entity.isLikedForMe)
                  IconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    onPressed: onRemove,
                  ),
              ],
            ),
            const SizedBox(height: 18.0),
            Directionality(
              textDirection: TextDirection.rtl,
              child: ElevatedButton.icon(
                icon: Icon(
                  entity.isLikedForMe ? Icons.favorite : Icons.favorite_border,
                ),
                label: Text('${entity.likes}'),
                onPressed: onLike,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
