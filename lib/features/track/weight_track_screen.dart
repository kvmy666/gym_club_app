import 'dart:math' as math;

import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

import '../../core/theme/motion.dart';

class WeightTrackScreen extends StatefulWidget {
  const WeightTrackScreen({super.key});

  @override
  State<WeightTrackScreen> createState() => _WeightTrackScreenState();
}

class _WeightTrackScreenState extends State<WeightTrackScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  int _selectedTab = 0;

  final data = const [76.5, 76.2, 75.8, 75.6, 75.1, 74.9, 74.6];
  final labels = const ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();
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
    final min = data.reduce(math.min);
    final max = data.reduce(math.max);

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.surface,
                  theme.colorScheme.surfaceContainerHighest,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(
                    l10n.trackTitle,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n.trackSubtitle,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SegmentedButton<int>(
                    segments: [
                      ButtonSegment(value: 0, label: Text(l10n.weekTab)),
                      ButtonSegment(value: 1, label: Text(l10n.monthTab)),
                      ButtonSegment(value: 2, label: Text(l10n.yearTab)),
                    ],
                    selected: {_selectedTab},
                    onSelectionChanged: (value) =>
                        setState(() => _selectedTab = value.first),
                  ),
                  const SizedBox(height: 24),
                  _WeightCard(current: data.last, goal: 72, l10n: l10n),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Card(
                      elevation: 0,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.weightTrendTitle,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              l10n.weightTrendSubtitle,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Expanded(
                              child: AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  return CustomPaint(
                                    painter: _WeightLinePainter(
                                      animationValue: Curves.easeOutCubic
                                          .transform(_controller.value),
                                      data: data,
                                      min: min,
                                      max: max,
                                      color: theme.colorScheme.primary,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: labels
                                  .map(
                                    (label) => Text(
                                      label,
                                      style: theme.textTheme.labelSmall
                                          ?.copyWith(
                                            color: theme
                                                .colorScheme
                                                .onSurfaceVariant,
                                          ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    label: Text(l10n.logWeightButton),
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      minimumSize: const Size.fromHeight(56),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeightCard extends StatelessWidget {
  const _WeightCard({
    required this.current,
    required this.goal,
    required this.l10n,
  });

  final double current;
  final double goal;
  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = (goal / current).clamp(0.0, 1.0).toDouble();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.secondary.withValues(alpha: 0.85),
            theme.colorScheme.primary.withValues(alpha: 0.9),
          ],
        ),
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.currentWeight,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${current.toStringAsFixed(1)} kg',
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.goalWeight(goal.toStringAsFixed(1)),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 18),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: LinearProgressIndicator(
                    value: 1 - progress,
                    minHeight: 10,
                    backgroundColor: Colors.white24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 24),
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.22),
            ),
            child: Center(
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: current - goal),
                duration: AppMotion.cardEntrance,
                builder: (context, value, child) {
                  return Text(
                    '${value.toStringAsFixed(1)} kg',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeightLinePainter extends CustomPainter {
  _WeightLinePainter({
    required this.animationValue,
    required this.data,
    required this.min,
    required this.max,
    required this.color,
  });

  final double animationValue;
  final List<double> data;
  final double min;
  final double max;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [color.withValues(alpha: 0.28), Colors.transparent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final path = Path();
    final fillPath = Path();
    final step = size.width / (data.length - 1);
    final normalized = data
        .map((value) => 1 - ((value - min) / (max - min)).clamp(0, 1))
        .toList();

    for (int i = 0; i < data.length; i++) {
      final dx = step * i;
      final dy = normalized[i] * size.height;
      final animatedDx = dx * animationValue;
      final animatedDy =
          dy * animationValue + (1 - animationValue) * size.height;
      if (i == 0) {
        path.moveTo(animatedDx, animatedDy);
        fillPath.moveTo(animatedDx, size.height);
        fillPath.lineTo(animatedDx, animatedDy);
      } else {
        path.lineTo(animatedDx, animatedDy);
        fillPath.lineTo(animatedDx, animatedDy);
      }
      if (i == data.length - 1) {
        fillPath.lineTo(animatedDx, size.height);
        fillPath.close();
      }
    }

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _WeightLinePainter oldDelegate) {
    return animationValue != oldDelegate.animationValue ||
        data != oldDelegate.data;
  }
}
