import 'package:flutter/material.dart';

class QuestionCreateWidget extends StatefulWidget {
  final ValueChanged<String> onSubmit;
  const QuestionCreateWidget({super.key, required this.onSubmit});

  @override
  State<QuestionCreateWidget> createState() => _QuestionCreateWidgetState();
}

class _QuestionCreateWidgetState extends State<QuestionCreateWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    onPressed() {
      final text = controller.text;
      controller.clear();

      if (text.trim().isEmpty) return;

      widget.onSubmit(text);
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Faça uma pergunta'),
              maxLines: 3,
              onSubmitted: (_) => onPressed(),
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 18.0),
            ElevatedButton.icon(
              onPressed: onPressed,
              icon: const Icon(Icons.send),
              label: const Text('Perguntar'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
