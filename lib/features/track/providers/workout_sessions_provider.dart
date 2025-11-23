import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/workout_api.dart';
import '../models/workout_models.dart';

final workoutSessionsProvider =
    FutureProvider<List<WorkoutSessionModel>>((ref) async {
  return WorkoutApi.fetchSessions();
});
