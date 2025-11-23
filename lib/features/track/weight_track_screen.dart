import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import 'data/workout_api.dart';
import 'models/training_day.dart';
import 'models/exercise_catalog.dart';
import 'models/workout_models.dart';
import 'providers/training_days_provider.dart';
import 'providers/training_days_mutations.dart';
import 'providers/exercise_catalog_provider.dart';
import 'providers/workout_sessions_provider.dart';

class WeightTrackScreen extends ConsumerStatefulWidget {
  const WeightTrackScreen({super.key});

  @override
  ConsumerState<WeightTrackScreen> createState() => _WeightTrackScreenState();
}

class _WeightTrackScreenState extends ConsumerState<WeightTrackScreen>
    with SingleTickerProviderStateMixin {
  final _dayNameController = TextEditingController();
  int? _lastDayId;
  int _selectedDayIndex = 0;
  int? _activeSessionId;
  bool _saving = false;

  Duration _elapsed = Duration.zero;
  Timer? _timer;
  DateTime? _sessionStart;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _dayNameController.dispose();
    super.dispose();
  }

  Future<void> _ensureSession(TrainingDay day) async {
    if (_activeSessionId != null) return;
    final created = await WorkoutApi.createSession(
      trainingDayId: day.id,
      startedAt: DateTime.now(),
    );
    setState(() {
      _activeSessionId = created.id;
      _sessionStart = created.startedAt;
    });
    ref.invalidate(workoutSessionsProvider);
  }

  void _startTimer() {
    _timer?.cancel();
    _sessionStart ??= DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        _elapsed = DateTime.now().difference(_sessionStart!);
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  Future<void> _renameDay(TrainingDay day, String name) async {
    await ref
        .read(trainingDayMutationProvider)
        .rename(day.id, name.trim().isEmpty ? 'Custom' : name.trim());
  }

  Future<void> _chooseExercise(
    List<ExerciseCatalogEntry> catalog,
    TrainingDay day,
  ) async {
    try {
      if (_activeSessionId == null) await _ensureSession(day);
      if (!mounted) return;
      final l10n = AppLocalizations.of(context)!;
      ExerciseCatalogEntry? picked;
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (context) {
          final muscles = [
            'all',
            'chest',
            'back',
            'legs',
            'shoulders',
            'core',
            'arms',
            'other',
          ];
          String selectedMuscle = 'all';
          final filtered = ValueNotifier<List<ExerciseCatalogEntry>>(catalog);
          return StatefulBuilder(
            builder: (context, setState) {
              void apply(String muscle) {
                selectedMuscle = muscle;
                filtered.value = muscle == 'all'
                    ? catalog
                    : catalog
                        .where((e) =>
                            (e.muscleGroup.isEmpty ? 'other' : e.muscleGroup)
                                .toLowerCase() ==
                            muscle.toLowerCase())
                        .toList();
              }

              return Padding(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 16,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 24,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.exercisePickerTitle,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: muscles
                          .map(
                            (m) => ChoiceChip(
                              label: Text(m.toUpperCase()),
                              selected: selectedMuscle == m,
                              onSelected: (_) => setState(() {
                                apply(m);
                              }),
                            ),
                          )
                          .toList(),
                    ),
                    const SizedBox(height: 12),
                    ValueListenableBuilder<List<ExerciseCatalogEntry>>(
                      valueListenable: filtered,
                      builder: (context, items, _) {
                        return SizedBox(
                          height: 360,
                          child: ListView.separated(
                            itemCount: items.length,
                            separatorBuilder: (_, __) =>
                                const Divider(height: 1),
                            itemBuilder: (context, index) {
                              final ex = items[index];
                              return ListTile(
                                title: Text(ex.name),
                                subtitle: Text(
                                  (ex.muscleGroup.isEmpty
                                          ? 'other'
                                          : ex.muscleGroup)
                                      .toUpperCase(),
                                ),
                                onTap: () {
                                  picked = ex;
                                  Navigator.of(context).pop();
                                },
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      );
      if (picked != null && _activeSessionId != null) {
        await WorkoutApi.addExercise(
          sessionId: _activeSessionId!,
          exerciseType: 'global',
          exerciseId: picked!.id,
        );
        ref.invalidate(workoutSessionsProvider);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load exercises: $e')),
      );
    }
  }

  Future<void> _addSet({
    required WorkoutSessionExerciseModel sessionExercise,
    required double weight,
    required int reps,
  }) async {
    await WorkoutApi.addSet(
      sessionExerciseId: sessionExercise.id,
      weight: weight,
      reps: reps,
    );
    ref.invalidate(workoutSessionsProvider);
  }

  Future<void> _finishSession(TrainingDay day) async {
    if (_activeSessionId == null) return;
    setState(() => _saving = true);
    _stopTimer();
    // could patch end time/volume if needed; backend currently accepts created fields
    await Future.delayed(const Duration(milliseconds: 300));
    ref.invalidate(workoutSessionsProvider);
    setState(() {
      _activeSessionId = null;
      _saving = false;
      _elapsed = Duration.zero;
      _sessionStart = null;
    });
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Session saved for ${day.name}')),
    );
  }

  Future<void> _showHistory(List<WorkoutSessionModel> sessions,
      List<TrainingDay> days) async {
    final dayMap = {for (final d in days) d.id: d.name};
    await showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final s = sessions[index];
                final dayName = dayMap[s.trainingDayId] ?? 'Day';
                return ListTile(
                  title: Text(dayName),
                  subtitle: Text(s.startedAt.toLocal().toString()),
                  onTap: () async {
                    final detail =
                        await WorkoutApi.fetchSessionDetail(s.id);
                    if (!mounted) return;
                    Navigator.of(context).pop();
                    _showSessionDetail(detail, dayName);
                  },
                );
              },
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemCount: sessions.length,
            ),
          ),
        );
      },
    );
  }

  void _showSessionDetail(WorkoutSessionDetail detail, String dayName) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${l10n.workoutNameLabel}: $dayName',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text('Date: ${detail.session.startedAt.toLocal()}'),
                const Divider(),
                ...detail.exercises.map(
                  (ex) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Exercise ${ex.exerciseId}',
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        ...ex.sets.map(
                          (set) => Text(
                            '${set.weight.toStringAsFixed(1)} kg × ${set.reps}',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final trainingDays = ref.watch(trainingDaysProvider);
    final catalog = ref.watch(exerciseCatalogProvider);
    final sessions = ref.watch(workoutSessionsProvider);
    return trainingDays.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (e, _) => Scaffold(body: Center(child: Text('Error: $e'))),
      data: (days) {
        if (days.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: Text(l10n.logWorkout)),
            body: Center(
              child: ElevatedButton(
                onPressed: () async {
                  await ref
                      .read(trainingDayMutationProvider)
                      .create('Custom');
                },
                child: const Text('Create first day'),
              ),
            ),
          );
        }
        final selectedDay = days[_selectedDayIndex.clamp(0, days.length - 1)];
        if (_lastDayId != selectedDay.id) {
          // Update the controller text after build to avoid rebuild assertions.
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _dayNameController.text =
                selectedDay.name == 'Custom' ? '' : selectedDay.name;
            _lastDayId = selectedDay.id;
          });
        }
        final sessionsData = sessions.asData?.value ?? const [];
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.logWorkout),
            actions: [
              TextButton(
                onPressed: _saving
                    ? null
                    : () => _finishSession(selectedDay),
                child: Text(l10n.finishButton),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PlanTabs(
                    days: days,
                    selected: _selectedDayIndex,
                    onSelected: (index) {
                      setState(() {
                        _selectedDayIndex = index;
                        _activeSessionId = null;
                        _elapsed = Duration.zero;
                        _sessionStart = null;
                      });
                    },
                  ),
                const SizedBox(height: 16),
                _MetricsRow(
                  time: _formatDuration(_elapsed),
                  volume: _calcCurrentVolume(sessionsData),
                  sets: _calcCurrentSets(sessionsData),
                  l10n: l10n,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _dayNameController,
                  decoration: InputDecoration(labelText: l10n.workoutNameLabel),
                  onSubmitted: (value) => _renameDay(selectedDay, value),
                  onChanged: (value) => _renameDay(selectedDay, value),
                ),
                  const SizedBox(height: 16),
                  _TimerCard(
                    l10n: l10n,
                    timerLabel: _formatDuration(_elapsed),
                    isRunning: _timer?.isActive ?? false,
                    onStart: () => _startTimer(),
                    onStop: () => _stopTimer(),
                  ),
                  const SizedBox(height: 16),
                  catalog.when(
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) => Text('Failed to load exercises: $e'),
                    data: (list) => FilledButton.icon(
                      onPressed: list.isEmpty
                          ? null
                          : () => _chooseExercise(list, selectedDay),
                      icon: const Icon(Icons.fitness_center),
                      label: const Text('Choose exercise'),
                    ),
                  ),
                  const SizedBox(height: 16),
                  _ActiveSessionList(
                    sessions: sessionsData,
                    activeSessionId: _activeSessionId,
                    onAddSet: _showAddSetPicker,
                    addSetHandler: _addSet,
                  ),
                  const SizedBox(height: 24),
                  OutlinedButton.icon(
                    onPressed: () =>
                        _showHistory(sessionsData, days),
                    icon: const Icon(Icons.history),
                    label: const Text('View previous workouts'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  double _calcCurrentVolume(List<WorkoutSessionModel> sessions) {
    // crude: totalVolume from session if available
    final found = sessions.firstWhere(
      (s) => s.id == _activeSessionId,
      orElse: () => WorkoutSessionModel(
        id: -1,
        userId: -1,
        trainingDayId: null,
        startedAt: DateTime(0),
      ),
    );
    return found.totalVolume ?? 0;
  }

  int _calcCurrentSets(List<WorkoutSessionModel> sessions) {
    // without detail, return 0
    return 0;
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    final hours = duration.inHours;
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }

  Future<void> _showAddSetPicker(
    WorkoutSessionExerciseModel sessionExercise,
  ) async {
    double weight = 20;
    int reps = 8;
    await showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          height: 320,
          child: Column(
            children: [
              const Text('Add Set', style: TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 12),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 32,
                        scrollController:
                            FixedExtentScrollController(initialItem: 20),
                        onSelectedItemChanged: (i) => weight = (i + 1).toDouble(),
                        children: List.generate(
                          200,
                          (i) => Center(child: Text('${i + 1} kg')),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent: 32,
                        scrollController:
                            FixedExtentScrollController(initialItem: reps),
                        onSelectedItemChanged: (i) => reps = i + 1,
                        children: List.generate(
                          50,
                          (i) => Center(child: Text('${i + 1} reps')),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              FilledButton(
                onPressed: () async {
                  try {
                    await _addSet(
                      sessionExercise: sessionExercise,
                      weight: weight,
                      reps: reps,
                    );
                    if (context.mounted) Navigator.of(context).pop();
                  } catch (e) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to save set: $e')),
                    );
                  }
                },
                child: const Text('Save set'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PlanTabs extends StatelessWidget {
  const _PlanTabs({
    required this.days,
    required this.selected,
    required this.onSelected,
  });

  final List<TrainingDay> days;
  final int selected;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(days.length, (index) {
          final day = days[index];
          final label = day.name.isEmpty || day.name == 'Custom'
              ? 'DAY ${index + 1}'
              : day.name;
          final isSelected = index == selected;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(label.toUpperCase()),
              selected: isSelected,
              onSelected: (_) => onSelected(index),
              selectedColor: theme.colorScheme.primary.withValues(alpha: 0.15),
            ),
          );
        }),
      ),
    );
  }
}

class _MetricsRow extends StatelessWidget {
  const _MetricsRow({
    required this.time,
    required this.volume,
    required this.sets,
    required this.l10n,
  });

  final String time;
  final double volume;
  final int sets;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Metric(label: l10n.timeLabel, value: time),
            _Metric(label: l10n.volumeLabel, value: '${volume.toStringAsFixed(1)} kg'),
            _Metric(label: l10n.setsLabel, value: '$sets'),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelMedium
              ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style:
              theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _TimerCard extends StatelessWidget {
  const _TimerCard({
    required this.l10n,
    required this.timerLabel,
    required this.isRunning,
    required this.onStart,
    required this.onStop,
  });

  final AppLocalizations l10n;
  final String timerLabel;
  final bool isRunning;
  final VoidCallback onStart;
  final VoidCallback onStop;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.timer_outlined),
            const SizedBox(width: 12),
            Text(
              l10n.timerLabel,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Spacer(),
            Text(timerLabel),
            const SizedBox(width: 12),
            FilledButton.tonal(
              onPressed: isRunning ? onStop : onStart,
              child: Text(isRunning ? l10n.finishButton : l10n.startButton),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActiveSessionList extends ConsumerWidget {
  const _ActiveSessionList({
    required this.sessions,
    required this.activeSessionId,
    required this.onAddSet,
    required this.addSetHandler,
  });

  final List<WorkoutSessionModel> sessions;
  final int? activeSessionId;
  final Future<void> Function(WorkoutSessionExerciseModel) onAddSet;
  final Future<void> Function({
    required WorkoutSessionExerciseModel sessionExercise,
    required double weight,
    required int reps,
  }) addSetHandler;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (activeSessionId == null) {
      return const SizedBox.shrink();
    }
    final catalog = ref.watch(exerciseCatalogProvider);
    String nameFor(int id) {
      return catalog.maybeWhen(
        data: (list) {
          for (final e in list) {
            if (e.id == id) return e.name;
          }
          return 'Exercise $id';
        },
        orElse: () => 'Exercise $id',
      );
    }
    return FutureBuilder<WorkoutSessionDetail>(
      future: WorkoutApi.fetchSessionDetail(activeSessionId!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'Failed to load session: ${snapshot.error}',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Theme.of(context).colorScheme.error),
          );
        }
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final detail = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Exercises',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 12),
            ...detail.exercises.map(
              (ex) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            nameFor(ex.exerciseId),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () => onAddSet(ex),
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      ...ex.sets.map(
                        (set) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Text(
                            '${set.weight.toStringAsFixed(1)} kg × ${set.reps}',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
