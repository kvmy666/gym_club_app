import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/home_screen.dart';
import '../../features/classes/classes_screen.dart';
import '../../features/classes/class_details_screen.dart';
import '../../features/workouts/workouts_screen.dart';
import '../../features/nutrition/nutrition_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/auth/sign_in_screen.dart';
import '../../features/auth/sign_up_screen.dart';
import '../../features/auth/reset_password_screen.dart';

final _rootKey = GlobalKey<NavigatorState>();
final _homeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _classesKey = GlobalKey<NavigatorState>(debugLabel: 'classes');
final _workoutsKey = GlobalKey<NavigatorState>(debugLabel: 'workouts');
final _nutritionKey = GlobalKey<NavigatorState>(debugLabel: 'nutrition');
final _profileKey = GlobalKey<NavigatorState>(debugLabel: 'profile');

GoRouter createRouter() => GoRouter(
      navigatorKey: _rootKey,
      initialLocation: '/home',
      routes: [
        // Auth stack (modal routes outside tab shell)
        GoRoute(path: '/auth/sign-in', builder: (_, __) => const SignInScreen()),
        GoRoute(path: '/auth/sign-up', builder: (_, __) => const SignUpScreen()),
        GoRoute(path: '/auth/reset', builder: (_, __) => const ResetPasswordScreen()),
        StatefulShellRoute.indexedStack(
          builder: (context, state, navShell) {
            return Scaffold(
              body: navShell,
              bottomNavigationBar: NavigationBar(
                selectedIndex: navShell.currentIndex,
                onDestinationSelected: (index) => navShell.goBranch(index),
                destinations: const [
                  NavigationDestination(
                    icon: Icon(Icons.home_outlined),
                    selectedIcon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.calendar_month_outlined),
                    selectedIcon: Icon(Icons.calendar_month),
                    label: 'Classes',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.fitness_center_outlined),
                    selectedIcon: Icon(Icons.fitness_center),
                    label: 'Workouts',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.restaurant_outlined),
                    selectedIcon: Icon(Icons.restaurant),
                    label: 'Nutrition',
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.person_outline),
                    selectedIcon: Icon(Icons.person),
                    label: 'Profile',
                  ),
                ],
              ),
            );
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: _homeKey,
              routes: [
                GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _classesKey,
              routes: [
                GoRoute(
                  path: '/classes',
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
            StatefulShellBranch(
              navigatorKey: _workoutsKey,
              routes: [
                GoRoute(
                  path: '/workouts',
                  builder: (_, __) => const WorkoutsScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _nutritionKey,
              routes: [
                GoRoute(
                  path: '/nutrition',
                  builder: (_, __) => const NutritionScreen(),
                ),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: _profileKey,
              routes: [
                GoRoute(
                  path: '/profile',
                  builder: (_, __) => const ProfileScreen(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
