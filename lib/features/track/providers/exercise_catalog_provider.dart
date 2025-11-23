import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/workout_api.dart';
import '../models/exercise_catalog.dart';

final exerciseCatalogProvider =
    FutureProvider<List<ExerciseCatalogEntry>>((ref) async {
  try {
    final list = await WorkoutApi.fetchExerciseCatalog();
    list.sort((a, b) => a.name.compareTo(b.name));
    return list;
  } catch (_) {
    // In the rare case parsing still throws, fall back to a minimal list so the UI stays usable.
    return const [
      ExerciseCatalogEntry(
          id: 1001, name: 'Barbell Bench Press', muscleGroup: 'chest'),
      ExerciseCatalogEntry(id: 1101, name: 'Deadlift', muscleGroup: 'back'),
      ExerciseCatalogEntry(id: 1501, name: 'Back Squat', muscleGroup: 'legs'),
      ExerciseCatalogEntry(id: 1701, name: 'Plank', muscleGroup: 'core'),
    ];
  }
});
