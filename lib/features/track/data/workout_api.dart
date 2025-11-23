import 'package:dio/dio.dart';

import '../../../core/api/api_client.dart';
import '../../../core/api/api_config.dart';
import '../models/training_day.dart';
import '../models/workout_models.dart';
import '../models/exercise_catalog.dart';

class WorkoutApi {
  static Future<List<ExerciseCatalogEntry>> fetchExerciseCatalog() async {
    try {
      final res = await ApiClient.http.get('/exercises');
      final raw = res.data;
      final list = <ExerciseCatalogEntry>[];

      // Accept either a plain list or wrapped { data: [...] }
      final data = raw is List
          ? raw
          : (raw is Map && raw['data'] is List ? raw['data'] : null);
      if (data is List) {
        for (final item in data) {
          if (item is Map<String, dynamic>) {
            try {
              list.add(ExerciseCatalogEntry.fromJson(item));
            } catch (_) {
              // Skip malformed entry and keep loading the rest
            }
          }
        }
      }
      if (list.isNotEmpty) return list;
    } catch (_) {
      // fall through to fallback below
    }
    return _fallbackExercises;
  }

  static Future<List<TrainingDay>> fetchTrainingDays() async {
    final res = await ApiClient.http.get('/users/$apiUserId/training-days');
    final data = res.data as List<dynamic>;
    return data
        .map((e) => TrainingDay.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<TrainingDay> createTrainingDay(String name,
      {int displayOrder = 0}) async {
    final res = await ApiClient.http.post(
      '/users/$apiUserId/training-days',
      data: {'name': name, 'displayOrder': displayOrder},
    );
    return TrainingDay.fromJson(res.data as Map<String, dynamic>);
  }

  static Future<TrainingDay> renameTrainingDay(int id, String name) async {
    final res = await ApiClient.http.patch(
      '/training-days/$id',
      data: {'name': name},
    );
    return TrainingDay.fromJson(res.data as Map<String, dynamic>);
  }

  static Future<void> deleteTrainingDay(int id) async {
    await ApiClient.http.delete('/training-days/$id');
  }

  static Future<WorkoutSessionModel> createSession({
    required int trainingDayId,
    required DateTime startedAt,
  }) async {
    final res = await ApiClient.http.post(
      '/users/$apiUserId/workouts',
      data: {
        'trainingDayId': trainingDayId,
        'startedAt': startedAt.toIso8601String(),
      },
    );
    return WorkoutSessionModel.fromJson(res.data as Map<String, dynamic>);
  }

  static Future<List<WorkoutSessionModel>> fetchSessions() async {
    final res = await ApiClient.http.get('/users/$apiUserId/workouts');
    final data = res.data as List<dynamic>;
    return data
        .map((e) => WorkoutSessionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<WorkoutSessionDetail> fetchSessionDetail(int sessionId) async {
    final res = await ApiClient.http.get('/workouts/$sessionId');
    return WorkoutSessionDetail.fromJson(res.data as Map<String, dynamic>);
  }

  static Future<WorkoutSessionExerciseModel> addExercise({
    required int sessionId,
    required String exerciseType,
    required int exerciseId,
    int displayOrder = 0,
  }) async {
    final res = await ApiClient.http.post(
      '/workouts/$sessionId/exercises',
      data: {
        'exerciseType': exerciseType,
        'exerciseId': exerciseId,
        'displayOrder': displayOrder,
      },
    );
    return WorkoutSessionExerciseModel.fromJson(
        res.data as Map<String, dynamic>);
  }

  static Future<WorkoutSetModel> addSet({
    required int sessionExerciseId,
    required double weight,
    required int reps,
    DateTime? performedAt,
  }) async {
    final res = await ApiClient.http.post(
      '/workouts/exercises/$sessionExerciseId/sets',
      data: {
        'weight': weight,
        'reps': reps,
        'performedAt': (performedAt ?? DateTime.now()).toIso8601String(),
      },
    );
    return WorkoutSetModel.fromJson(res.data as Map<String, dynamic>);
  }

  static Future<UserExerciseModel> createUserExercise({
    required String name,
    required String category,
    String? description,
  }) async {
    final Response res = await ApiClient.http.post(
      '/users/$apiUserId/exercises',
      data: {
        'name': name,
        'category': category,
        'description': description,
      },
    );
    return UserExerciseModel.fromJson(res.data as Map<String, dynamic>);
  }
}

// Fallback catalog to keep the picker usable even if parsing fails or API is empty
const _fallbackExercises = <ExerciseCatalogEntry>[
  ExerciseCatalogEntry(id: 1001, name: 'Barbell Bench Press', muscleGroup: 'chest'),
  ExerciseCatalogEntry(id: 1101, name: 'Deadlift', muscleGroup: 'back'),
  ExerciseCatalogEntry(id: 1501, name: 'Back Squat', muscleGroup: 'legs'),
  ExerciseCatalogEntry(id: 1701, name: 'Plank', muscleGroup: 'core'),
];
