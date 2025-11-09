// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Elite Fitness';

  @override
  String get navHome => 'Home';

  @override
  String get navTrack => 'Track';

  @override
  String get navAi => 'AI';

  @override
  String get navShop => 'Shop';

  @override
  String get navSettings => 'Settings';

  @override
  String homeGreeting(String name) {
    return 'Welcome back, $name!';
  }

  @override
  String get homeMessage =>
      'Your personalised plan is ready. Let\'s crush today\'s goals.';

  @override
  String dailyStreak(String count) {
    return '$count-day streak';
  }

  @override
  String get minutesLabel => 'min';

  @override
  String get featuredClasses => 'Featured classes';

  @override
  String get viewAll => 'View all';

  @override
  String focusWorkoutTitle(String category) {
    return '$category focus session';
  }

  @override
  String get focusWorkoutSubtitle =>
      'Targeted strength with guided tempo cues and recovery timers.';

  @override
  String get startButton => 'Start';

  @override
  String get nextButton => 'Next';

  @override
  String get hiitBadge => 'HIIT';

  @override
  String get weeklySummaryTitle => 'Weekly progress';

  @override
  String get weeklySummarySubtitle => '3 of 4 workouts completed';

  @override
  String get weekdayShortLabels => 'Mon,Tue,Wed,Thu,Fri,Sat,Sun';

  @override
  String classCoachLabel(String coach) {
    return 'Coach $coach';
  }

  @override
  String classLevelTag(String level) {
    return '$level';
  }

  @override
  String get trackTitle => 'Weight tracker';

  @override
  String get trackSubtitle =>
      'Monitor trends, log sessions, and hit your target weight.';

  @override
  String get weekTab => 'Week';

  @override
  String get monthTab => 'Month';

  @override
  String get yearTab => 'Year';

  @override
  String get weightTrendTitle => 'Trend';

  @override
  String get weightTrendSubtitle => 'Last 7 sessions';

  @override
  String get logWeightButton => 'Log weight';

  @override
  String get currentWeight => 'Current';

  @override
  String goalWeight(String value) {
    return 'Goal $value kg';
  }

  @override
  String get aiCoachTitle => 'AI coach';

  @override
  String get aiCoachSubtitle =>
      'Microservice insights tuned to your recovery and goals.';

  @override
  String get aiMicroserviceHint =>
      'Connected to training, nutrition, and wearable microservices for live adjustments.';

  @override
  String get aiCoachInputHint => 'Tell your coach how you feel today...';

  @override
  String get shopTitle => 'Fuel & gear';

  @override
  String get shopSubtitle =>
      'Curated essentials that match your training plan.';

  @override
  String get shopSearchHint => 'Search supplements, apparel, gear...';

  @override
  String get addToCart => 'Add to cart';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsSubtitle =>
      'Fine-tune experience, integrations, and account.';

  @override
  String get accountSection => 'ACCOUNT';

  @override
  String get profileTile => 'Profile';

  @override
  String get profileTileSubtitle => 'Goals, contact info, and preferences';

  @override
  String get notificationsTile => 'Notifications';

  @override
  String get notificationsTileSubtitle => 'Class reminders and streak alerts';

  @override
  String get experienceSection => 'EXPERIENCE';

  @override
  String get themeTile => 'Theme';

  @override
  String themeTileSubtitle(String mode) {
    return 'Currently $mode';
  }

  @override
  String get themeSystemLabel => 'System';

  @override
  String get themeLightLabel => 'Light';

  @override
  String get themeDarkLabel => 'Dark';

  @override
  String get languageTile => 'Language';

  @override
  String get languageSystemLabel => 'Match system';

  @override
  String get integrationsSection => 'INTEGRATIONS';

  @override
  String get healthSyncTile => 'Health platforms';

  @override
  String get healthSyncSubtitle => 'Apple Health, Google Fit, Garmin';

  @override
  String get supportTile => 'Support';

  @override
  String get supportSubtitle => 'Chat with the team';

  @override
  String get logoutButton => 'Log out';

  @override
  String get profileTitle => 'Profile';

  @override
  String profileGoalLabel(String goal) {
    return 'Goal: $goal';
  }

  @override
  String membershipStatusLabel(String tier) {
    return 'Membership: $tier';
  }

  @override
  String get metricsSection => 'Metrics';

  @override
  String get metricWorkouts => 'Workouts';

  @override
  String get metricMinutes => 'Minutes';

  @override
  String get metricCalories => 'Calories';

  @override
  String get preferencesSection => 'Preferences';

  @override
  String get goalTile => 'Training goal';

  @override
  String get scheduleTile => 'Schedule';

  @override
  String get scheduleTileSubtitle => 'Monday, Tuesday, Thursday, Saturday';

  @override
  String get nutritionTile => 'Nutrition';

  @override
  String get securitySection => 'Security';

  @override
  String get passwordTile => 'Password';

  @override
  String get passwordTileSubtitle => 'Last updated 32 days ago';

  @override
  String get devicesTile => 'Devices';

  @override
  String get devicesTileSubtitle => '2 devices connected';

  @override
  String get classesTitle => 'Classes';

  @override
  String get classNotFound => 'Class not found';

  @override
  String get classOverviewHeadline => 'What to expect';

  @override
  String get classOverviewBody =>
      'Progressive pacing with tempo finishers, mobility cooldown, and heart rate coaching.';

  @override
  String get capacityLabel => 'Capacity';

  @override
  String get intensityLabel => 'Intensity';

  @override
  String get spotsLabel => 'spots';

  @override
  String get bookClassButton => 'Book class';

  @override
  String get joinWaitlistButton => 'Join waitlist';

  @override
  String get skipButton => 'Skip';

  @override
  String get onboardingTitle1 => 'Design your perfect routine';

  @override
  String get onboardingSubtitle1 =>
      'Personalised programming built from your goals, equipment, and availability.';

  @override
  String get onboardingTitle2 => 'Track every rep and recovery';

  @override
  String get onboardingSubtitle2 =>
      'Integrate wearables, monitor fatigue, and adjust your load instantly.';

  @override
  String get onboardingTitle3 => 'AI microservices on standby';

  @override
  String get onboardingSubtitle3 =>
      'Smart assistants coordinate nutrition, training, and community challenges in real time.';
}
