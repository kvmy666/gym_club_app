import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/motion.dart';
import '../../l10n/app_localizations.dart';
import '../track/providers/training_days_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _selectedCategory = 0;

  static const List<String> _fallbackCategories = [
    'custom',
    'chest',
    'back',
    'legs',
    'core',
    'mobility',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final trainingDays = ref.watch(trainingDaysProvider);
    final categories = trainingDays.maybeWhen(
      data: (days) => days.isEmpty
          ? _fallbackCategories
          : days.map((d) => d.name.isEmpty ? 'Custom' : d.name).toList(),
      orElse: () => _fallbackCategories,
    );
    final selectedIndex = categories.isEmpty
        ? 0
        : _selectedCategory.clamp(0, categories.length - 1);
    final selectedCategory =
        categories.isEmpty ? 'Custom' : categories[selectedIndex];

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          _AnimatedBackdrop(controller: _controller),
          SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                  sliver: SliverToBoxAdapter(
                    child: _Header(
                      onProfileTap: () => context.push('/settings/profile'),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.homeGreeting('عبدالكريم الشدوخي'),
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l10n.homeMessage,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 24),
                        _CategorySelector(
                          categories: categories,
                          selectedIndex: selectedIndex,
                          onSelected: (index) {
                            setState(() => _selectedCategory = index);
                          },
                        ),
                        const SizedBox(height: 24),
                        _WorkoutCard(
                          category: selectedCategory,
                          onViewSchedule: () => context.go('/track'),
                        ),
                        const SizedBox(height: 24),
                        const _CalorieCalculator(),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedBackdrop extends StatelessWidget {
  const _AnimatedBackdrop({required this.controller});

  final Animation<double> controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final t = Curves.easeInOut.transform(controller.value);
        final colorA = Color.lerp(
          const Color(0xFF0D1B2A),
          theme.colorScheme.primary,
          t,
        )!;
        final colorB = Color.lerp(
          const Color(0xFF1B263B),
          theme.colorScheme.secondary,
          1 - t,
        )!;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [colorA, colorB],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
      },
      child: const SizedBox.expand(),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onProfileTap});

  final VoidCallback onProfileTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface.withValues(alpha: 0.8),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.flash_on, color: Color(0xFFFFC857), size: 20),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.dailyStreak('5'),
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Hero(
          tag: 'profile-avatar',
          child: GestureDetector(
            onTap: onProfileTap,
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.6),
                  width: 2,
                ),
              ),
              child: const Icon(Icons.person, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}

class _CategorySelector extends StatelessWidget {
  const _CategorySelector({
    required this.categories,
    required this.selectedIndex,
    required this.onSelected,
  });

  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final selected = index == selectedIndex;
          return ChoiceChip(
            label: Text(categories[index].toUpperCase()),
            selected: selected,
            onSelected: (_) => onSelected(index),
            backgroundColor: theme.chipTheme.backgroundColor,
            selectedColor: theme.colorScheme.primary.withValues(alpha: 0.12),
            labelStyle: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: selected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurfaceVariant,
              letterSpacing: 0.6,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
          );
        },
      ),
    );
  }
}

class _WorkoutCard extends StatefulWidget {
  const _WorkoutCard({required this.category, required this.onViewSchedule});

  final String category;
  final VoidCallback onViewSchedule;

  @override
  State<_WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<_WorkoutCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapCancel: () => setState(() => _pressed = false),
      onTapUp: (_) => setState(() => _pressed = false),
      onTap: widget.onViewSchedule,
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1.0,
        duration: AppMotion.microInteraction,
        curve: AppMotion.easeOut,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primary.withValues(alpha: 0.92),
                theme.colorScheme.primary.withValues(alpha: 0.65),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        '${widget.category.toUpperCase()} • 45 ${l10n.minutesLabel}',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      l10n.focusWorkoutTitle(widget.category),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      l10n.focusWorkoutSubtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.86),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FilledButton.icon(
                      onPressed: widget.onViewSchedule,
                      icon: const Icon(Icons.play_arrow_rounded),
                      label: Text(l10n.startButton),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: theme.colorScheme.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              _WorkoutPreview(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CalorieCalculator extends StatefulWidget {
  const _CalorieCalculator();

  @override
  State<_CalorieCalculator> createState() => _CalorieCalculatorState();
}

enum _CalcGender { male, female }

enum _CalcActivity { sedentary, light, moderate, active, veryActive }

enum _CalcGoal { lose, maintain, gain }

class _CalorieCalculatorState extends State<_CalorieCalculator> {
  int _age = 28;
  double _height = 172;
  double _weight = 72;
  double _targetWeight = 68;
  _CalcGender _gender = _CalcGender.male;
  _CalcActivity _activity = _CalcActivity.moderate;
  _CalcGoal _goal = _CalcGoal.maintain;

  double get _maintenanceCalories {
    final base = 10 * _weight + 6.25 * _height - 5 * _age;
    final genderAdjustment = _gender == _CalcGender.male ? 5 : -161;
    return (base + genderAdjustment) * _activityMultiplier(_activity);
  }

  double get _suggestedCalories {
    final maintenance = _maintenanceCalories;
    switch (_goal) {
      case _CalcGoal.lose:
        return (maintenance - 400).clamp(1200, double.infinity);
      case _CalcGoal.maintain:
        return maintenance;
      case _CalcGoal.gain:
        return maintenance + 300;
    }
  }

  int? get _weeksEstimate {
    final weeklyChange = switch (_goal) {
      _CalcGoal.lose => 0.5,
      _CalcGoal.maintain => 0.0,
      _CalcGoal.gain => 0.25,
    };
    final delta = (_targetWeight - _weight).abs();
    if (weeklyChange == 0 || delta < 0.1) return null;
    return (delta / weeklyChange).ceil();
  }

  double _activityMultiplier(_CalcActivity activity) {
    switch (activity) {
      case _CalcActivity.sedentary:
        return 1.2;
      case _CalcActivity.light:
        return 1.375;
      case _CalcActivity.moderate:
        return 1.55;
      case _CalcActivity.active:
        return 1.725;
      case _CalcActivity.veryActive:
        return 1.9;
    }
  }

  String _activityLabel(AppLocalizations l10n, _CalcActivity activity) {
    switch (activity) {
      case _CalcActivity.sedentary:
        return l10n.calcActivitySedentary;
      case _CalcActivity.light:
        return l10n.calcActivityLight;
      case _CalcActivity.moderate:
        return l10n.calcActivityModerate;
      case _CalcActivity.active:
        return l10n.calcActivityActive;
      case _CalcActivity.veryActive:
        return l10n.calcActivityVeryActive;
    }
  }

  String _goalLabel(AppLocalizations l10n, _CalcGoal goal) {
    switch (goal) {
      case _CalcGoal.lose:
        return l10n.calcGoalLose;
      case _CalcGoal.maintain:
        return l10n.calcGoalMaintain;
      case _CalcGoal.gain:
        return l10n.calcGoalGain;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final calories = _suggestedCalories.round();
    final weeks = _weeksEstimate;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  l10n.calcTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.local_fire_department_outlined,
                  color: theme.colorScheme.primary,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              children: _CalcGender.values.map((gender) {
                final selected = _gender == gender;
                final label = gender == _CalcGender.male
                    ? l10n.calcGenderMale
                    : l10n.calcGenderFemale;
                return ChoiceChip(
                  label: Text(label),
                  selected: selected,
                  onSelected: (_) => setState(() => _gender = gender),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            _buildSlider(
              context: context,
              label: l10n.calcAgeLabel,
              valueLabel: '$_age${l10n.calcAgeSuffix}',
              min: 16,
              max: 70,
              value: _age.toDouble(),
              onChanged: (value) => setState(() => _age = value.round()),
            ),
            const SizedBox(height: 16),
            _buildSlider(
              context: context,
              label: l10n.calcHeightLabel,
              valueLabel: '${_height.round()}${l10n.calcHeightSuffix}',
              min: 145,
              max: 210,
              value: _height,
              onChanged: (value) => setState(() => _height = value),
            ),
            const SizedBox(height: 16),
            _buildSlider(
              context: context,
              label: l10n.calcWeightLabel,
              valueLabel: '${_weight.toStringAsFixed(1)}${l10n.calcWeightSuffix}',
              min: 45,
              max: 140,
              value: _weight,
              onChanged: (value) => setState(() => _weight = value),
            ),
            const SizedBox(height: 16),
            _buildSlider(
              context: context,
              label: l10n.calcTargetWeightLabel,
              valueLabel:
                  '${_targetWeight.toStringAsFixed(1)}${l10n.calcWeightSuffix}',
              min: 45,
              max: 140,
              value: _targetWeight,
              onChanged: (value) => setState(() => _targetWeight = value),
            ),
            const SizedBox(height: 16),
            DropdownMenu<_CalcActivity>(
              initialSelection: _activity,
              label: Text(l10n.calcActivityLabel),
              dropdownMenuEntries: _CalcActivity.values
                  .map(
                    (activity) => DropdownMenuEntry(
                      value: activity,
                      label: _activityLabel(l10n, activity),
                    ),
                  )
                  .toList(),
              onSelected: (value) {
                if (value == null) return;
                setState(() => _activity = value);
              },
            ),
            const SizedBox(height: 20),
            Text(
              l10n.calcGoalLabel,
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _CalcGoal.values.map((goal) {
                final selected = _goal == goal;
                return ChoiceChip(
                  selected: selected,
                  label: Text(_goalLabel(l10n, goal)),
                  onSelected: (_) => setState(() => _goal = goal),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: theme.colorScheme.primary.withValues(alpha: 0.08),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.calcResultTitle,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$calories ${l10n.calcResultUnit}',
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (weeks != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      l10n.calcTimeEstimate(weeks),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSlider({
    required BuildContext context,
    required String label,
    required String valueLabel,
    required double min,
    required double max,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              valueLabel,
              style: theme.textTheme.labelLarge,
            ),
          ],
        ),
        Slider(
          min: min,
          max: max,
          value: value.clamp(min, max),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _WorkoutPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 140,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.white.withValues(alpha: 0.18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.32),
          width: 1.2,
        ),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Icon(
              Icons.fitness_center,
              color: Colors.white.withValues(alpha: 0.5),
              size: 110,
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.all(12),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.secondary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                AppLocalizations.of(context)!.hiitBadge,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
