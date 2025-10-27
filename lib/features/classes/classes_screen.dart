import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'data/classes_repository.dart';
import 'model/gym_class.dart';

class ClassesScreen extends ConsumerWidget {
  const ClassesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final classes = ref.watch(classesProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Classes')),
      body: ListView.separated(
        itemCount: classes.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final c = classes[index];
          return _ClassTile(c: c);
        },
      ),
    );
  }
}

class _ClassTile extends StatelessWidget {
  const _ClassTile({required this.c});
  final GymClass c;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final time = TimeOfDay.fromDateTime(c.startTime).format(context);
    final full = c.booked >= c.capacity;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: cs.primaryContainer,
        child: Icon(
          full ? Icons.event_busy : Icons.event_available,
          color: cs.onPrimaryContainer,
        ),
      ),
      title: Text(c.name),
      subtitle: Text('${c.instructor} • $time'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('${c.booked}/${c.capacity}'),
          SizedBox(
            width: 80,
            child: LinearProgressIndicator(
              value: c.occupancy.clamp(0, 1),
            ),
          ),
        ],
      ),
      onTap: () => context.go('/classes/${c.id}'),
    );
  }
}

