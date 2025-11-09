import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers/app_startup_provider.dart';
import '../../core/theme/motion.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _controller;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_index == 2) {
      ref.completeOnboarding();
      context.go('/home');
    } else {
      _controller.nextPage(
        duration: AppMotion.pageTransition,
        curve: AppMotion.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      ref.completeOnboarding();
                      context.go('/home');
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white70,
                    ),
                    child: Text(l10n.skipButton),
                  ),
                ),
                Expanded(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (value) => setState(() => _index = value),
                    children: [
                      _OnboardingStep(
                        illustration: Icons.sports_gymnastics,
                        title: l10n.onboardingTitle1,
                        subtitle: l10n.onboardingSubtitle1,
                      ),
                      _OnboardingStep(
                        illustration: Icons.monitor_heart,
                        title: l10n.onboardingTitle2,
                        subtitle: l10n.onboardingSubtitle2,
                      ),
                      _OnboardingStep(
                        illustration: Icons.auto_awesome,
                        title: l10n.onboardingTitle3,
                        subtitle: l10n.onboardingSubtitle3,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (i) {
                    final active = _index == i;
                    return AnimatedContainer(
                      duration: AppMotion.microInteraction,
                      margin: const EdgeInsets.all(6),
                      height: 8,
                      width: active ? 32 : 12,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(
                          alpha: active ? 0.9 : 0.4,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    );
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                  child: FilledButton(
                    onPressed: _next,
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: theme.colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      _index == 2 ? l10n.startButton : l10n.nextButton,
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

class _OnboardingStep extends StatelessWidget {
  const _OnboardingStep({
    required this.illustration,
    required this.title,
    required this.subtitle,
  });

  final IconData illustration;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 220,
            width: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withValues(alpha: 0.1),
              border: Border.all(color: Colors.white24, width: 2),
            ),
            child: Icon(illustration, color: Colors.white, size: 120),
          ),
          const SizedBox(height: 36),
          Text(
            title,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.8),
            ),
          ),
        ],
      ),
    );
  }
}
