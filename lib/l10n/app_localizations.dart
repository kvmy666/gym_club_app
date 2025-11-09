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
  /// **'Weight tracker'**
  String get trackTitle;

  /// No description provided for @trackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Monitor trends, log sessions, and hit your target weight.'**
  String get trackSubtitle;

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
  /// **'Log weight'**
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
