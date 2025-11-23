import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Elite Fitness'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navTrack.
  ///
  /// In en, this message translates to:
  /// **'Track'**
  String get navTrack;

  /// No description provided for @navAi.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get navAi;

  /// No description provided for @navShop.
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get navShop;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// Dashboard greeting
  ///
  /// In en, this message translates to:
  /// **'Welcome back, {name}!'**
  String homeGreeting(String name);

  /// No description provided for @homeMessage.
  ///
  /// In en, this message translates to:
  /// **'Your personalised plan is ready. Let\'s crush today\'s goals.'**
  String get homeMessage;

  /// No description provided for @dailyStreak.
  ///
  /// In en, this message translates to:
  /// **'{count}-day streak'**
  String dailyStreak(String count);

  /// No description provided for @minutesLabel.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get minutesLabel;

  /// No description provided for @featuredClasses.
  ///
  /// In en, this message translates to:
  /// **'Featured classes'**
  String get featuredClasses;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get viewAll;

  /// No description provided for @focusWorkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'{category} focus session'**
  String focusWorkoutTitle(String category);

  /// No description provided for @focusWorkoutSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Targeted strength with guided tempo cues and recovery timers.'**
  String get focusWorkoutSubtitle;

  /// No description provided for @startButton.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get startButton;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @hiitBadge.
  ///
  /// In en, this message translates to:
  /// **'HIIT'**
  String get hiitBadge;

  /// No description provided for @weeklySummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Weekly progress'**
  String get weeklySummaryTitle;

  /// No description provided for @weeklySummarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'3 of 4 workouts completed'**
  String get weeklySummarySubtitle;

  /// No description provided for @weekdayShortLabels.
  ///
  /// In en, this message translates to:
  /// **'Mon,Tue,Wed,Thu,Fri,Sat,Sun'**
  String get weekdayShortLabels;

  /// No description provided for @classCoachLabel.
  ///
  /// In en, this message translates to:
  /// **'Coach {coach}'**
  String classCoachLabel(String coach);

  /// No description provided for @classLevelTag.
  ///
  /// In en, this message translates to:
  /// **'{level}'**
  String classLevelTag(String level);

  /// No description provided for @trackTitle.
  ///
  /// In en, this message translates to:
  /// **'Log workout'**
  String get trackTitle;

  /// No description provided for @trackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Name your day, pick exercises, and capture every set.'**
  String get trackSubtitle;

  /// No description provided for @logWorkout.
  ///
  /// In en, this message translates to:
  /// **'Log workout'**
  String get logWorkout;

  /// No description provided for @weekTab.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get weekTab;

  /// No description provided for @monthTab.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get monthTab;

  /// No description provided for @yearTab.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get yearTab;

  /// No description provided for @weightTrendTitle.
  ///
  /// In en, this message translates to:
  /// **'Trend'**
  String get weightTrendTitle;

  /// No description provided for @weightTrendSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Last 7 sessions'**
  String get weightTrendSubtitle;

  /// No description provided for @logWeightButton.
  ///
  /// In en, this message translates to:
  /// **'Log workout'**
  String get logWeightButton;

  /// No description provided for @currentWeight.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get currentWeight;

  /// No description provided for @goalWeight.
  ///
  /// In en, this message translates to:
  /// **'Goal {value} kg'**
  String goalWeight(String value);

  /// No description provided for @workoutNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Workout name'**
  String get workoutNameLabel;

  /// No description provided for @workoutNameHint.
  ///
  /// In en, this message translates to:
  /// **'Add a name to this session'**
  String get workoutNameHint;

  /// No description provided for @timeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get timeLabel;

  /// No description provided for @timerLabel.
  ///
  /// In en, this message translates to:
  /// **'Timer'**
  String get timerLabel;

  /// No description provided for @restTimerLabel.
  ///
  /// In en, this message translates to:
  /// **'Rest timer'**
  String get restTimerLabel;

  /// No description provided for @volumeLabel.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get volumeLabel;

  /// No description provided for @setsLabel.
  ///
  /// In en, this message translates to:
  /// **'Sets'**
  String get setsLabel;

  /// No description provided for @setsHeader.
  ///
  /// In en, this message translates to:
  /// **'Sets'**
  String get setsHeader;

  /// No description provided for @addSet.
  ///
  /// In en, this message translates to:
  /// **'Add set'**
  String get addSet;

  /// No description provided for @noSetsYet.
  ///
  /// In en, this message translates to:
  /// **'No sets yet. Add your first set to begin tracking.'**
  String get noSetsYet;

  /// No description provided for @weightFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weightFieldLabel;

  /// No description provided for @invalidWeight.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid weight'**
  String get invalidWeight;

  /// No description provided for @repsFieldLabel.
  ///
  /// In en, this message translates to:
  /// **'Reps'**
  String get repsFieldLabel;

  /// No description provided for @invalidReps.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid rep count'**
  String get invalidReps;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @saveSet.
  ///
  /// In en, this message translates to:
  /// **'Save set'**
  String get saveSet;

  /// No description provided for @deleteSet.
  ///
  /// In en, this message translates to:
  /// **'Delete set'**
  String get deleteSet;

  /// No description provided for @resumeButton.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resumeButton;

  /// No description provided for @finishButton.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finishButton;

  /// No description provided for @resetButton.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get resetButton;

  /// No description provided for @resetSessionButton.
  ///
  /// In en, this message translates to:
  /// **'Reset session'**
  String get resetSessionButton;

  /// No description provided for @summaryHeader.
  ///
  /// In en, this message translates to:
  /// **'Summary of sets'**
  String get summaryHeader;

  /// No description provided for @addExerciseButton.
  ///
  /// In en, this message translates to:
  /// **'Choose exercise'**
  String get addExerciseButton;

  /// No description provided for @exercisePickerTitle.
  ///
  /// In en, this message translates to:
  /// **'Select exercise'**
  String get exercisePickerTitle;

  /// No description provided for @exerciseSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search exercises'**
  String get exerciseSearchHint;

  /// No description provided for @exerciseCategoryAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get exerciseCategoryAll;

  /// No description provided for @exerciseCategoryBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get exerciseCategoryBack;

  /// No description provided for @exerciseCategoryChest.
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get exerciseCategoryChest;

  /// No description provided for @exerciseCategoryLegs.
  ///
  /// In en, this message translates to:
  /// **'Legs'**
  String get exerciseCategoryLegs;

  /// No description provided for @exerciseCategoryShoulders.
  ///
  /// In en, this message translates to:
  /// **'Shoulders'**
  String get exerciseCategoryShoulders;

  /// No description provided for @exerciseCategoryCore.
  ///
  /// In en, this message translates to:
  /// **'Abs & core'**
  String get exerciseCategoryCore;

  /// No description provided for @noExercisesYet.
  ///
  /// In en, this message translates to:
  /// **'No exercises yet. Add your first exercise to begin.'**
  String get noExercisesYet;

  /// No description provided for @deleteExercise.
  ///
  /// In en, this message translates to:
  /// **'Remove exercise'**
  String get deleteExercise;

  /// No description provided for @exerciseSessionsLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} sets'**
  String exerciseSessionsLabel(int count);

  /// No description provided for @aiCoachTitle.
  ///
  /// In en, this message translates to:
  /// **'AI coach'**
  String get aiCoachTitle;

  /// No description provided for @aiCoachSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Microservice insights tuned to your recovery and goals.'**
  String get aiCoachSubtitle;

  /// No description provided for @aiMicroserviceHint.
  ///
  /// In en, this message translates to:
  /// **'Connected to training, nutrition, and wearable microservices for live adjustments.'**
  String get aiMicroserviceHint;

  /// No description provided for @aiCoachInputHint.
  ///
  /// In en, this message translates to:
  /// **'Tell your coach how you feel today...'**
  String get aiCoachInputHint;

  /// No description provided for @shopTitle.
  ///
  /// In en, this message translates to:
  /// **'Fuel & gear'**
  String get shopTitle;

  /// No description provided for @shopSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Curated essentials that match your training plan.'**
  String get shopSubtitle;

  /// No description provided for @shopSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search supplements, apparel, gear...'**
  String get shopSearchHint;

  /// No description provided for @addToCart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get addToCart;

  /// No description provided for @cartTitle.
  ///
  /// In en, this message translates to:
  /// **'Cart • {count} items'**
  String cartTitle(int count);

  /// No description provided for @cartEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your cart is empty'**
  String get cartEmpty;

  /// No description provided for @cartTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Total (incl. 15% VAT)'**
  String get cartTotalLabel;

  /// No description provided for @cartCheckoutButton.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get cartCheckoutButton;

  /// No description provided for @cartViewButton.
  ///
  /// In en, this message translates to:
  /// **'View cart'**
  String get cartViewButton;

  /// No description provided for @personalInfoSection.
  ///
  /// In en, this message translates to:
  /// **'Personal details'**
  String get personalInfoSection;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @weightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get weightLabel;

  /// No description provided for @heightLabel.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get heightLabel;

  /// No description provided for @profileSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save details'**
  String get profileSaveButton;

  /// No description provided for @profileSavedMessage.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully.'**
  String get profileSavedMessage;

  /// No description provided for @membershipSection.
  ///
  /// In en, this message translates to:
  /// **'Club membership'**
  String get membershipSection;

  /// No description provided for @membershipRemaining.
  ///
  /// In en, this message translates to:
  /// **'{days} days remaining'**
  String membershipRemaining(int days);

  /// No description provided for @membershipPlans.
  ///
  /// In en, this message translates to:
  /// **'Plans'**
  String get membershipPlans;

  /// No description provided for @membershipPlanMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get membershipPlanMonthly;

  /// No description provided for @membershipPlanQuarterly.
  ///
  /// In en, this message translates to:
  /// **'Quarterly'**
  String get membershipPlanQuarterly;

  /// No description provided for @membershipPlanSemiAnnual.
  ///
  /// In en, this message translates to:
  /// **'Semi-annual'**
  String get membershipPlanSemiAnnual;

  /// No description provided for @membershipPlanAnnual.
  ///
  /// In en, this message translates to:
  /// **'Annual'**
  String get membershipPlanAnnual;

  /// No description provided for @membershipComparisonTitle.
  ///
  /// In en, this message translates to:
  /// **'Compare plans'**
  String get membershipComparisonTitle;

  /// No description provided for @membershipRenewButton.
  ///
  /// In en, this message translates to:
  /// **'Renew membership'**
  String get membershipRenewButton;

  /// No description provided for @membershipRenewSuccess.
  ///
  /// In en, this message translates to:
  /// **'Membership renewed for {plan}.'**
  String membershipRenewSuccess(String plan);

  /// No description provided for @supportSection.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get supportSection;

  /// No description provided for @supportEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Need help? Contact us'**
  String get supportEmailLabel;

  /// No description provided for @supportEmail.
  ///
  /// In en, this message translates to:
  /// **'krom306@gmail.com'**
  String get supportEmail;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fine-tune experience, integrations, and account.'**
  String get settingsSubtitle;

  /// No description provided for @accountSection.
  ///
  /// In en, this message translates to:
  /// **'ACCOUNT'**
  String get accountSection;

  /// No description provided for @profileTile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTile;

  /// No description provided for @profileTileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Goals, contact info, and preferences'**
  String get profileTileSubtitle;

  /// No description provided for @notificationsTile.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTile;

  /// No description provided for @notificationsTileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Class reminders and streak alerts'**
  String get notificationsTileSubtitle;

  /// No description provided for @experienceSection.
  ///
  /// In en, this message translates to:
  /// **'EXPERIENCE'**
  String get experienceSection;

  /// No description provided for @themeTile.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeTile;

  /// No description provided for @themeTileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Currently {mode}'**
  String themeTileSubtitle(String mode);

  /// No description provided for @themeSystemLabel.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystemLabel;

  /// No description provided for @themeLightLabel.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLightLabel;

  /// No description provided for @themeDarkLabel.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDarkLabel;

  /// No description provided for @languageTile.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTile;

  /// No description provided for @languageSystemLabel.
  ///
  /// In en, this message translates to:
  /// **'Match system'**
  String get languageSystemLabel;

  /// No description provided for @integrationsSection.
  ///
  /// In en, this message translates to:
  /// **'INTEGRATIONS'**
  String get integrationsSection;

  /// No description provided for @healthSyncTile.
  ///
  /// In en, this message translates to:
  /// **'Health platforms'**
  String get healthSyncTile;

  /// No description provided for @healthSyncSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Apple Health, Google Fit, Garmin'**
  String get healthSyncSubtitle;

  /// No description provided for @supportTile.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get supportTile;

  /// No description provided for @supportSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Chat with the team'**
  String get supportSubtitle;

  /// No description provided for @logoutButton.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get logoutButton;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @profileGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Goal: {goal}'**
  String profileGoalLabel(String goal);

  /// No description provided for @membershipStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Membership: {tier}'**
  String membershipStatusLabel(String tier);

  /// No description provided for @metricsSection.
  ///
  /// In en, this message translates to:
  /// **'Metrics'**
  String get metricsSection;

  /// No description provided for @metricWorkouts.
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get metricWorkouts;

  /// No description provided for @metricMinutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get metricMinutes;

  /// No description provided for @metricCalories.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get metricCalories;

  /// No description provided for @preferencesSection.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferencesSection;

  /// No description provided for @goalTile.
  ///
  /// In en, this message translates to:
  /// **'Training goal'**
  String get goalTile;

  /// No description provided for @scheduleTile.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get scheduleTile;

  /// No description provided for @scheduleTileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Monday, Tuesday, Thursday, Saturday'**
  String get scheduleTileSubtitle;

  /// No description provided for @nutritionTile.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get nutritionTile;

  /// No description provided for @securitySection.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get securitySection;

  /// No description provided for @passwordTile.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordTile;

  /// No description provided for @passwordTileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Last updated 32 days ago'**
  String get passwordTileSubtitle;

  /// No description provided for @devicesTile.
  ///
  /// In en, this message translates to:
  /// **'Devices'**
  String get devicesTile;

  /// No description provided for @devicesTileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'2 devices connected'**
  String get devicesTileSubtitle;

  /// No description provided for @classesTitle.
  ///
  /// In en, this message translates to:
  /// **'Classes'**
  String get classesTitle;

  /// No description provided for @classNotFound.
  ///
  /// In en, this message translates to:
  /// **'Class not found'**
  String get classNotFound;

  /// No description provided for @classOverviewHeadline.
  ///
  /// In en, this message translates to:
  /// **'What to expect'**
  String get classOverviewHeadline;

  /// No description provided for @classOverviewBody.
  ///
  /// In en, this message translates to:
  /// **'Progressive pacing with tempo finishers, mobility cooldown, and heart rate coaching.'**
  String get classOverviewBody;

  /// No description provided for @capacityLabel.
  ///
  /// In en, this message translates to:
  /// **'Capacity'**
  String get capacityLabel;

  /// No description provided for @intensityLabel.
  ///
  /// In en, this message translates to:
  /// **'Intensity'**
  String get intensityLabel;

  /// No description provided for @spotsLabel.
  ///
  /// In en, this message translates to:
  /// **'spots'**
  String get spotsLabel;

  /// No description provided for @bookClassButton.
  ///
  /// In en, this message translates to:
  /// **'Book class'**
  String get bookClassButton;

  /// No description provided for @joinWaitlistButton.
  ///
  /// In en, this message translates to:
  /// **'Join waitlist'**
  String get joinWaitlistButton;

  /// No description provided for @skipButton.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skipButton;

  /// No description provided for @onboardingTitle1.
  ///
  /// In en, this message translates to:
  /// **'Design your perfect routine'**
  String get onboardingTitle1;

  /// No description provided for @onboardingSubtitle1.
  ///
  /// In en, this message translates to:
  /// **'Personalised programming built from your goals, equipment, and availability.'**
  String get onboardingSubtitle1;

  /// No description provided for @onboardingTitle2.
  ///
  /// In en, this message translates to:
  /// **'Track every rep and recovery'**
  String get onboardingTitle2;

  /// No description provided for @onboardingSubtitle2.
  ///
  /// In en, this message translates to:
  /// **'Integrate wearables, monitor fatigue, and adjust your load instantly.'**
  String get onboardingSubtitle2;

  /// No description provided for @onboardingTitle3.
  ///
  /// In en, this message translates to:
  /// **'AI microservices on standby'**
  String get onboardingTitle3;

  /// No description provided for @onboardingSubtitle3.
  ///
  /// In en, this message translates to:
  /// **'Smart assistants coordinate nutrition, training, and community challenges in real time.'**
  String get onboardingSubtitle3;

  /// No description provided for @calcTitle.
  ///
  /// In en, this message translates to:
  /// **'Calorie calculator'**
  String get calcTitle;

  /// No description provided for @calcAgeLabel.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get calcAgeLabel;

  /// No description provided for @calcAgeSuffix.
  ///
  /// In en, this message translates to:
  /// **'yrs'**
  String get calcAgeSuffix;

  /// No description provided for @calcHeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get calcHeightLabel;

  /// No description provided for @calcHeightSuffix.
  ///
  /// In en, this message translates to:
  /// **'cm'**
  String get calcHeightSuffix;

  /// No description provided for @calcWeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Current weight'**
  String get calcWeightLabel;

  /// No description provided for @calcWeightSuffix.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get calcWeightSuffix;

  /// No description provided for @calcTargetWeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Target weight'**
  String get calcTargetWeightLabel;

  /// No description provided for @calcGenderMale.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get calcGenderMale;

  /// No description provided for @calcGenderFemale.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get calcGenderFemale;

  /// No description provided for @calcActivityLabel.
  ///
  /// In en, this message translates to:
  /// **'Activity level'**
  String get calcActivityLabel;

  /// No description provided for @calcActivitySedentary.
  ///
  /// In en, this message translates to:
  /// **'Sedentary (office job)'**
  String get calcActivitySedentary;

  /// No description provided for @calcActivityLight.
  ///
  /// In en, this message translates to:
  /// **'Light (1-3 days/week)'**
  String get calcActivityLight;

  /// No description provided for @calcActivityModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate (3-5 days/week)'**
  String get calcActivityModerate;

  /// No description provided for @calcActivityActive.
  ///
  /// In en, this message translates to:
  /// **'Active (6-7 days/week)'**
  String get calcActivityActive;

  /// No description provided for @calcActivityVeryActive.
  ///
  /// In en, this message translates to:
  /// **'Very active (athlete)'**
  String get calcActivityVeryActive;

  /// No description provided for @calcGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Your goal'**
  String get calcGoalLabel;

  /// No description provided for @calcGoalLose.
  ///
  /// In en, this message translates to:
  /// **'Lose weight'**
  String get calcGoalLose;

  /// No description provided for @calcGoalMaintain.
  ///
  /// In en, this message translates to:
  /// **'Maintain weight'**
  String get calcGoalMaintain;

  /// No description provided for @calcGoalGain.
  ///
  /// In en, this message translates to:
  /// **'Gain weight'**
  String get calcGoalGain;

  /// No description provided for @calcResultTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily intake suggestion'**
  String get calcResultTitle;

  /// No description provided for @calcResultUnit.
  ///
  /// In en, this message translates to:
  /// **'kcal'**
  String get calcResultUnit;

  /// No description provided for @calcTimeEstimate.
  ///
  /// In en, this message translates to:
  /// **'Estimated time to goal: {weeks} weeks'**
  String calcTimeEstimate(int weeks);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
