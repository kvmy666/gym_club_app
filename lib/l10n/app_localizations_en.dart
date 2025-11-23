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
  String get navTrack => 'Log workout';

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
  String get trackTitle => 'Log workout';

  @override
  String get trackSubtitle =>
      'Name your day, pick exercises, and capture every set.';

  @override
  String get logWorkout => 'Log workout';

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
  String get logWeightButton => 'Log workout';

  @override
  String get currentWeight => 'Current';

  @override
  String goalWeight(String value) {
    return 'Goal $value kg';
  }

  @override
  String get workoutNameLabel => 'Workout name';

  @override
  String get workoutNameHint => 'Add a name to this session';

  @override
  String get timeLabel => 'Time';

  @override
  String get timerLabel => 'Timer';

  @override
  String get restTimerLabel => 'Rest timer';

  @override
  String get volumeLabel => 'Volume';

  @override
  String get setsLabel => 'Sets';

  @override
  String get setsHeader => 'Sets';

  @override
  String get addSet => 'Add set';

  @override
  String get noSetsYet =>
      'No sets yet. Add your first set to begin tracking.';

  @override
  String get weightFieldLabel => 'Weight (kg)';

  @override
  String get invalidWeight => 'Enter a valid weight';

  @override
  String get repsFieldLabel => 'Reps';

  @override
  String get invalidReps => 'Enter a valid rep count';

  @override
  String get cancel => 'Cancel';

  @override
  String get saveSet => 'Save set';

  @override
  String get deleteSet => 'Delete set';

  @override
  String get resumeButton => 'Resume';

  @override
  String get finishButton => 'Finish';

  @override
  String get resetButton => 'Reset';

  @override
  String get resetSessionButton => 'Reset session';

  @override
  String get summaryHeader => 'Summary of sets';

  @override
  String get addExerciseButton => 'Choose exercise';

  @override
  String get exercisePickerTitle => 'Select exercise';

  @override
  String get exerciseSearchHint => 'Search exercises';

  @override
  String get exerciseCategoryAll => 'All';

  @override
  String get exerciseCategoryBack => 'Back';

  @override
  String get exerciseCategoryChest => 'Chest';

  @override
  String get exerciseCategoryLegs => 'Legs';

  @override
  String get exerciseCategoryShoulders => 'Shoulders';

  @override
  String get exerciseCategoryCore => 'Abs & core';

  @override
  String get noExercisesYet =>
      'No exercises yet. Add your first exercise to begin.';

  @override
  String get deleteExercise => 'Remove exercise';

  @override
  String exerciseSessionsLabel(int count) {
    return '$count sets';
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
  String cartTitle(int count) {
    return 'Cart • $count items';
  }

  @override
  String get cartEmpty => 'Your cart is empty';

  @override
  String get cartTotalLabel => 'Total (incl. 15% VAT)';

  @override
  String get cartCheckoutButton => 'Checkout';

  @override
  String get cartViewButton => 'View cart';

  @override
  String get personalInfoSection => 'Personal details';

  @override
  String get emailLabel => 'Email';

  @override
  String get weightLabel => 'Weight';

  @override
  String get heightLabel => 'Height';

  @override
  String get profileSaveButton => 'Save details';

  @override
  String get profileSavedMessage => 'Profile updated successfully.';

  @override
  String get membershipSection => 'Club membership';

  @override
  String membershipRemaining(int days) {
    return '$days days remaining';
  }

  @override
  String get membershipPlans => 'Plans';

  @override
  String get membershipPlanMonthly => 'Monthly';

  @override
  String get membershipPlanQuarterly => 'Quarterly';

  @override
  String get membershipPlanSemiAnnual => 'Semi-annual';

  @override
  String get membershipPlanAnnual => 'Annual';

  @override
  String get membershipComparisonTitle => 'Compare plans';

  @override
  String get membershipRenewButton => 'Renew membership';

  @override
  String membershipRenewSuccess(String plan) {
    return 'Membership renewed for $plan.';
  }

  @override
  String get supportSection => 'Support';

  @override
  String get supportEmailLabel => 'Need help? Contact us';

  @override
  String get supportEmail => 'krom306@gmail.com';

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

  @override
  String get calcTitle => 'Calorie calculator';

  @override
  String get calcAgeLabel => 'Age';

  @override
  String get calcAgeSuffix => 'yrs';

  @override
  String get calcHeightLabel => 'Height';

  @override
  String get calcHeightSuffix => 'cm';

  @override
  String get calcWeightLabel => 'Current weight';

  @override
  String get calcWeightSuffix => 'kg';

  @override
  String get calcTargetWeightLabel => 'Target weight';

  @override
  String get calcGenderMale => 'Male';

  @override
  String get calcGenderFemale => 'Female';

  @override
  String get calcActivityLabel => 'Activity level';

  @override
  String get calcActivitySedentary => 'Sedentary (office job)';

  @override
  String get calcActivityLight => 'Light (1-3 days/week)';

  @override
  String get calcActivityModerate => 'Moderate (3-5 days/week)';

  @override
  String get calcActivityActive => 'Active (6-7 days/week)';

  @override
  String get calcActivityVeryActive => 'Very active (athlete)';

  @override
  String get calcGoalLabel => 'Your goal';

  @override
  String get calcGoalLose => 'Lose weight';

  @override
  String get calcGoalMaintain => 'Maintain weight';

  @override
  String get calcGoalGain => 'Gain weight';

  @override
  String get calcResultTitle => 'Daily intake suggestion';

  @override
  String get calcResultUnit => 'kcal';

  @override
  String calcTimeEstimate(int weeks) {
    return 'Estimated time to goal: $weeks weeks';
  }
}
