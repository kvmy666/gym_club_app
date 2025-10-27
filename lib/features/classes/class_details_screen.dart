import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/classes_repository.dart';

class ClassDetailsScreen extends ConsumerWidget {
  const ClassDetailsScreen({super.key, required this.classId});
  final String classId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(classesProvider);
    final matches = list.where((c) => c.id == classId).toList();
    if (matches.isEmpty) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Class not found')),
      );
    }
    final klass = matches.first;
    final time = TimeOfDay.fromDateTime(klass.startTime).format(context);
    return Scaffold(
      appBar: AppBar(title: Text(klass.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Instructor: ${klass.instructor}',
                style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Starts at: $time'),
            const SizedBox(height: 16),
            Text('${klass.booked}/${klass.capacity} booked'),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text('Book Class'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Join Waitlist'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
