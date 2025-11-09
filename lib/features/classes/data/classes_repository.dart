import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/gym_class.dart';

final classesProvider = Provider<List<GymClass>>((ref) {
  final now = DateTime.now();
  return [
    GymClass(
      id: 'spin-101',
      name: 'Spin 101',
      instructor: 'Lena',
      startTime: now.add(const Duration(hours: 2)),
      capacity: 20,
      booked: 12,
    ),
    GymClass(
      id: 'hiit-pro',
      name: 'HIIT Pro',
      instructor: 'Marco',
      startTime: now.add(const Duration(hours: 5, minutes: 30)),
      capacity: 18,
      booked: 18,
    ),
    GymClass(
      id: 'yoga-flow',
      name: 'Yoga Flow',
      instructor: 'Sara',
      startTime: now.add(const Duration(days: 1, hours: 1)),
      capacity: 25,
      booked: 7,
    ),
  ];
});
