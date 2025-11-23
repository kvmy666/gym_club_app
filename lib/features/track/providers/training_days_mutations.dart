import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/workout_api.dart';
import '../models/training_day.dart';
import 'training_days_provider.dart';

final trainingDayMutationProvider = Provider<TrainingDayMutations>((ref) {
  return TrainingDayMutations(ref);
});

class TrainingDayMutations {
  TrainingDayMutations(this.ref);
  final Ref ref;

  Future<TrainingDay> create(String name) async {
    final created = await WorkoutApi.createTrainingDay(name);
    ref.invalidate(trainingDaysProvider);
    return created;
  }

  Future<TrainingDay> rename(int id, String name) async {
    final updated = await WorkoutApi.renameTrainingDay(id, name);
    ref.invalidate(trainingDaysProvider);
    return updated;
  }

  Future<void> delete(int id) async {
    await WorkoutApi.deleteTrainingDay(id);
    ref.invalidate(trainingDaysProvider);
  }
}
