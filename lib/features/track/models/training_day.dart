class TrainingDay {
  const TrainingDay({
    required this.id,
    required this.userId,
    required this.name,
    required this.displayOrder,
  });

  final int id;
  final int userId;
  final String name;
  final int displayOrder;

  factory TrainingDay.fromJson(Map<String, dynamic> json) {
    return TrainingDay(
      id: _asInt(json['id']),
      userId: _asInt(json['userId'] ?? json['user_id']),
      name: json['name'] as String? ?? '',
      displayOrder:
          _asInt(json['displayOrder'] ?? json['display_order'] ?? 0),
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
