import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/app_startup_provider.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/classes/classes_screen.dart';
import '../../features/classes/class_details_screen.dart';
import '../../features/track/weight_track_screen.dart';
import '../../features/ai/ai_coach_screen.dart';
import '../../features/shop/shop_screen.dart';
import '../../features/settings/settings_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/auth/sign_in_screen.dart';
import '../../features/auth/sign_up_screen.dart';
import '../../features/auth/reset_password_screen.dart';
import '../../l10n/app_localizations.dart';

final _rootKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final _homeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _trackKey = GlobalKey<NavigatorState>(debugLabel: 'track');
final _coachKey = GlobalKey<NavigatorState>(debugLabel: 'coach');
final _shopKey = GlobalKey<NavigatorState>(debugLabel: 'shop');
final _settingsKey = GlobalKey<NavigatorState>(debugLabel: 'settings');

final routerProvider = Provider<GoRouter>((ref) {
  final hasSeenOnboarding = ref.watch(onboardingStatusProvider);
  return _createRouter(hasSeenOnboarding);
});

GoRouter _createRouter(bool hasSeenOnboarding) => GoRouter(
  navigatorKey: _rootKey,
  initialLocation: hasSeenOnboarding ? '/home' : '/onboarding',
  routes: [
    GoRoute(path: '/onboarding', builder: (_, __) => const OnboardingScreen()),
    GoRoute(path: '/auth/sign-in', builder: (_, __) => const SignInScreen()),
    GoRoute(path: '/auth/sign-up', builder: (_, __) => const SignUpScreen()),
    GoRoute(
      path: '/auth/reset',
      builder: (_, __) => const ResetPasswordScreen(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navShell) {
        final l10n = AppLocalizations.of(context)!;
        return Scaffold(
          body: navShell,
          bottomNavigationBar: NavigationBar(
            selectedIndex: navShell.currentIndex,
            onDestinationSelected: navShell.goBranch,
            height: 72,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home),
                label: l10n.navHome,
              ),
              NavigationDestination(
                icon: const Icon(Icons.monitor_heart_outlined),
                selectedIcon: const Icon(Icons.monitor_heart),
                label: l10n.navTrack,
              ),
              NavigationDestination(
                icon: const Icon(Icons.auto_awesome_outlined),
                selectedIcon: const Icon(Icons.auto_awesome),
                label: l10n.navAi,
              ),
              NavigationDestination(
                icon: const Icon(Icons.storefront_outlined),
                selectedIcon: const Icon(Icons.storefront),
                label: l10n.navShop,
              ),
              NavigationDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                label: l10n.navSettings,
              ),
            ],
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeKey,
          routes: [
            GoRoute(
              path: '/home',
              builder: (_, __) => const HomeScreen(),
              routes: [
                GoRoute(
                  path: 'classes',
                  builder: (_, __) => const ClassesScreen(),
                  routes: [
                    GoRoute(
                      path: ':id',
                      builder: (context, state) => ClassDetailsScreen(
                        classId: state.pathParameters['id']!,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _trackKey,
          routes: [
            GoRoute(
              path: '/track',
              builder: (_, __) => const WeightTrackScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _coachKey,
          routes: [
            GoRoute(path: '/coach', builder: (_, __) => const AiCoachScreen()),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shopKey,
          routes: [
            GoRoute(path: '/shop', builder: (_, __) => const ShopScreen()),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _settingsKey,
          routes: [
            GoRoute(
              path: '/settings',
              builder: (_, __) => const SettingsScreen(),
              routes: [
                GoRoute(
                  path: 'profile',
                  builder: (_, __) => const ProfileScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
