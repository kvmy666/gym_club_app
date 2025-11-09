import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart' as riverpod;
import 'package:shared_preferences/shared_preferences.dart';

const kOnboardingSeenKey = 'hasSeenOnboarding';

final sharedPreferencesProvider = riverpod.Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences not initialized');
});

final onboardingStatusProvider =
    riverpod.NotifierProvider<OnboardingNotifier, bool>(OnboardingNotifier.new);

extension OnboardingUpdater on WidgetRef {
  Future<void> completeOnboarding() async {
    await read(onboardingStatusProvider.notifier).markComplete();
  }
}

class OnboardingNotifier extends riverpod.Notifier<bool> {
  @override
  bool build() {
    final prefs = ref.read(sharedPreferencesProvider);
    return prefs.getBool(kOnboardingSeenKey) ?? false;
  }

  Future<void> markComplete() async {
    state = true;
    await ref.read(sharedPreferencesProvider).setBool(kOnboardingSeenKey, true);
  }
}
