class ExerciseCatalogEntry {
  const ExerciseCatalogEntry({
    required this.id,
    required this.name,
    required this.muscleGroup,
  });

  final int id;
  final String name;
  final String muscleGroup;

  factory ExerciseCatalogEntry.fromJson(Map<String, dynamic> json) {
    return ExerciseCatalogEntry(
      id: _asInt(json['id']),
      name: _safeString(json['name'], fallback: 'Exercise'),
      muscleGroup: _asMuscleGroup(
        json['muscle_group'] ??
            json['category'] ??
            json['muscleGroup'] ??
            json['muscle'],
      ),
    );
  }
}

int _asInt(dynamic value) {
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) {
    final parsed = int.tryParse(value);
    if (parsed != null) return parsed;
  }
  return 0;
}

String _safeString(dynamic value, {required String fallback}) {
  final raw = (value is String) ? value.trim() : value?.toString().trim();
  if (raw == null || raw.isEmpty || raw.toLowerCase() == 'null') {
    return fallback;
  }
  return raw;
}

String _asMuscleGroup(dynamic value) {
  final raw = (value is String) ? value.trim() : value?.toString().trim();
  if (raw == null || raw.isEmpty || raw.toLowerCase() == 'null') {
    return 'other';
  }
  return raw.toLowerCase();
}
