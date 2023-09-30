import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../providers/database_providers.dart';

class DialogWidget extends ConsumerWidget {
  const DialogWidget({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final titleController = ref.watch(titleProvider);
    final bodyController = ref.watch(bodyProvider);
  
    ScrollController scrollController = ScrollController();

    return Stack(
      children: [
        const Icon(Icons.add),
        AlertDialog(
          title: TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'title'),
          ),
          content: TextField(
            controller: bodyController,
            decoration: const InputDecoration(hintText: 'body'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                ref
                    .read(userIdGetProvider.notifier)
                    .postData(title: titleController.text,body: bodyController.text);
                scrollController.initialScrollOffset;
                Navigator.pop(context);
              },
              child: const Text('OK'),
            )
          ],
        ),
      ],
    );
  }
}
