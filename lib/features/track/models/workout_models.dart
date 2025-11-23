class UserExerciseModel {
  const UserExerciseModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.category,
    this.description,
  });

  final int id;
  final int userId;
  final String name;
  final String category;
  final String? description;

  factory UserExerciseModel.fromJson(Map<String, dynamic> json) {
    return UserExerciseModel(
      id: _asInt(json['id']),
      userId: _asInt(json['user_id'] ?? json['userId']),
      name: json['name'] as String? ?? '',
      category: json['category'] as String? ?? 'other',
      description: json['description'] as String?,
    );
  }
}

class WorkoutSessionModel {
  const WorkoutSessionModel({
    required this.id,
    required this.userId,
    this.trainingDayId,
    required this.startedAt,
    this.endedAt,
    this.totalVolume,
    this.notes,
  });

  final int id;
  final int userId;
  final int? trainingDayId;
  final DateTime startedAt;
  final DateTime? endedAt;
  final double? totalVolume;
  final String? notes;

  factory WorkoutSessionModel.fromJson(Map<String, dynamic> json) {
    return WorkoutSessionModel(
      id: _asInt(json['id']),
      userId: _asInt(json['user_id'] ?? json['userId']),
      trainingDayId: _asNullableInt(json['training_day_id'] ?? json['trainingDayId']),
      startedAt: _asDate(json['started_at'] ?? json['startedAt']),
      endedAt: _asNullableDate(json['ended_at'] ?? json['endedAt']),
      totalVolume: (json['total_volume'] as num?)?.toDouble(),
      notes: json['notes'] as String?,
    );
  }
}

class WorkoutSessionExerciseModel {
  const WorkoutSessionExerciseModel({
    required this.id,
    required this.sessionId,
    required this.exerciseType,
    required this.exerciseId,
    required this.displayOrder,
    this.totalVolume,
    this.totalSets,
    this.sets = const [],
  });

  final int id;
  final int sessionId;
  final String exerciseType;
  final int exerciseId;
  final int displayOrder;
  final double? totalVolume;
  final int? totalSets;
  final List<WorkoutSetModel> sets;

  factory WorkoutSessionExerciseModel.fromJson(Map<String, dynamic> json) {
    return WorkoutSessionExerciseModel(
      id: _asInt(json['id']),
      sessionId: _asInt(json['session_id'] ?? json['sessionId']),
      exerciseType: json['exercise_type'] as String? ?? 'user',
      exerciseId: _asInt(json['exercise_id'] ?? json['exerciseId']),
      displayOrder: _asInt(json['display_order'] ?? 0),
      totalVolume: (json['total_volume'] as num?)?.toDouble(),
      totalSets: json['total_sets'] != null ? _asInt(json['total_sets']) : null,
      sets: (json['sets'] as List<dynamic>? ?? const [])
          .map((e) => WorkoutSetModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class WorkoutSetModel {
  const WorkoutSetModel({
    required this.id,
    required this.sessionExerciseId,
    required this.weight,
    required this.reps,
    required this.performedAt,
  });

  final int id;
  final int sessionExerciseId;
  final double weight;
  final int reps;
  final DateTime performedAt;

  double get volume => weight * reps;

  factory WorkoutSetModel.fromJson(Map<String, dynamic> json) {
    return WorkoutSetModel(
      id: _asInt(json['id']),
      sessionExerciseId:
          _asInt(json['session_exercise_id'] ?? json['sessionExerciseId']),
      weight: _asDouble(json['weight']),
      reps: _asInt(json['reps']),
      performedAt: _asDate(json['performed_at'] ?? json['performedAt']),
    );
  }
}

class WorkoutSessionDetail {
  const WorkoutSessionDetail({
    required this.session,
    required this.exercises,
  });

  final WorkoutSessionModel session;
  final List<WorkoutSessionExerciseModel> exercises;

  factory WorkoutSessionDetail.fromJson(Map<String, dynamic> json) {
    return WorkoutSessionDetail(
      session: WorkoutSessionModel.fromJson(json),
      exercises: (json['exercises'] as List<dynamic>? ?? const [])
          .map((e) =>
              WorkoutSessionExerciseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

int _asInt(dynamic value) {
  if (value is int) return value;
  if (value is String) {
    final parsed = int.tryParse(value);
    if (parsed != null) return parsed;
  }
  if (value is num) return value.toInt();
  return 0;
}

double _asDouble(dynamic value) {
  if (value is double) return value;
  if (value is num) return value.toDouble();
  if (value is String) {
    final parsed = double.tryParse(value);
    if (parsed != null) return parsed;
  }
  return 0;
}

int? _asNullableInt(dynamic value) {
  if (value == null) return null;
  return _asInt(value);
}

DateTime _asDate(dynamic value) {
  if (value is DateTime) return value;
  if (value is String && value.isNotEmpty) return DateTime.parse(value);
  // fallback to epoch to avoid null crashes
  return DateTime.fromMillisecondsSinceEpoch(0);
}

DateTime? _asNullableDate(dynamic value) {
  if (value == null) return null;
  if (value is DateTime) return value;
  if (value is String && value.isNotEmpty) return DateTime.parse(value);
  return null;
}
