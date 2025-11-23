import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/training_day.dart';
import '../data/workout_api.dart';

final trainingDaysProvider = FutureProvider<List<TrainingDay>>((ref) async {
  final data = await WorkoutApi.fetchTrainingDays();
  return data..sort((a, b) => a.displayOrder.compareTo(b.displayOrder));
});
