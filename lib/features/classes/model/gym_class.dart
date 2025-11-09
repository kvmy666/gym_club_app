class GymClass {
  final String id;
  final String name;
  final String instructor;
  final DateTime startTime;
  final int capacity;
  final int booked;

  const GymClass({
    required this.id,
    required this.name,
    required this.instructor,
    required this.startTime,
    required this.capacity,
    required this.booked,
  });

  double get occupancy => capacity == 0 ? 0 : booked / capacity;
}
