// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'إيليت فيتنس';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navTrack => 'متابعة';

  @override
  String get navAi => 'الذكاء';

  @override
  String get navShop => 'المتجر';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String homeGreeting(String name) {
    return 'مرحباً، $name!';
  }

  @override
  String get homeMessage => 'خطة التدريب المخصصة جاهزة، فلننجز أهداف اليوم.';

  @override
  String dailyStreak(String count) {
    return 'سلسلة من $count يوم';
  }

  @override
  String get minutesLabel => 'د';

  @override
  String get featuredClasses => 'حصص مميزة';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String focusWorkoutTitle(String category) {
    return 'جلسة تركيز $category';
  }

  @override
  String get focusWorkoutSubtitle =>
      'تمارين قوة موجهة مع إرشادات إيقاع وفترات استشفاء.';

  @override
  String get startButton => 'ابدأ';

  @override
  String get nextButton => 'التالي';

  @override
  String get hiitBadge => 'HIIT';

  @override
  String get weeklySummaryTitle => 'التقدم الأسبوعي';

  @override
  String get weeklySummarySubtitle => '3 من أصل 4 تمارين مكتملة';

  @override
  String get weekdayShortLabels => 'الإث,الث,الأر,الخ,الج,الس,الح';

  @override
  String classCoachLabel(String coach) {
    return 'المدرب $coach';
  }

  @override
  String classLevelTag(String level) {
    return '$level';
  }

  @override
  String get trackTitle => 'متابعة الوزن';

  @override
  String get trackSubtitle => 'راقب الاتجاهات وسجل الجلسات وحقق وزنك المستهدف.';

  @override
  String get weekTab => 'أسبوع';

  @override
  String get monthTab => 'شهر';

  @override
  String get yearTab => 'سنة';

  @override
  String get weightTrendTitle => 'الاتجاه';

  @override
  String get weightTrendSubtitle => 'آخر 7 قياسات';

  @override
  String get logWeightButton => 'تسجيل الوزن';

  @override
  String get currentWeight => 'الحالي';

  @override
  String goalWeight(String value) {
    return 'الهدف $value كجم';
  }

  @override
  String get aiCoachTitle => 'المدرب الذكي';

  @override
  String get aiCoachSubtitle => 'رؤى من الخدمات المصغرة وفق تعافيك وأهدافك.';

  @override
  String get aiMicroserviceHint =>
      'مرتبط بخدمات التدريب والتغذية والأجهزة القابلة للارتداء للتعديل الفوري.';

  @override
  String get aiCoachInputHint => 'أخبر المدرب الذكي كيف تشعر اليوم...';

  @override
  String get shopTitle => 'التغذية والمعدات';

  @override
  String get shopSubtitle => 'مختارات تناسب خطة تدريبك.';

  @override
  String get shopSearchHint => 'ابحث عن مكملات أو ملابس أو معدات...';

  @override
  String get addToCart => 'أضف إلى السلة';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsSubtitle => 'اضبط التجربة والتكاملات والحساب.';

  @override
  String get accountSection => 'الحساب';

  @override
  String get profileTile => 'الملف الشخصي';

  @override
  String get profileTileSubtitle => 'الأهداف ومعلومات الاتصال والتفضيلات';

  @override
  String get notificationsTile => 'الإشعارات';

  @override
  String get notificationsTileSubtitle => 'تنبيهات الحصص وسلسلة الالتزام';

  @override
  String get experienceSection => 'التجربة';

  @override
  String get themeTile => 'الوضع';

  @override
  String themeTileSubtitle(String mode) {
    return 'الوضع الحالي $mode';
  }

  @override
  String get themeSystemLabel => 'النظام';

  @override
  String get themeLightLabel => 'فاتح';

  @override
  String get themeDarkLabel => 'داكن';

  @override
  String get languageTile => 'اللغة';

  @override
  String get languageSystemLabel => 'مطابقة النظام';

  @override
  String get integrationsSection => 'التكاملات';

  @override
  String get healthSyncTile => 'منصات الصحة';

  @override
  String get healthSyncSubtitle => 'Apple Health، Google Fit، Garmin';

  @override
  String get supportTile => 'الدعم';

  @override
  String get supportSubtitle => 'تواصل مع الفريق';

  @override
  String get logoutButton => 'تسجيل الخروج';

  @override
  String get profileTitle => 'الملف الشخصي';

  @override
  String profileGoalLabel(String goal) {
    return 'الهدف: $goal';
  }

  @override
  String membershipStatusLabel(String tier) {
    return 'العضوية: $tier';
  }

  @override
  String get metricsSection => 'المؤشرات';

  @override
  String get metricWorkouts => 'التمارين';

  @override
  String get metricMinutes => 'الدقائق';

  @override
  String get metricCalories => 'السعرات';

  @override
  String get preferencesSection => 'التفضيلات';

  @override
  String get goalTile => 'هدف التدريب';

  @override
  String get scheduleTile => 'الجدول';

  @override
  String get scheduleTileSubtitle => 'الاثنين، الثلاثاء، الخميس، السبت';

  @override
  String get nutritionTile => 'التغذية';

  @override
  String get securitySection => 'الأمان';

  @override
  String get passwordTile => 'كلمة المرور';

  @override
  String get passwordTileSubtitle => 'آخر تحديث منذ ٣٢ يوماً';

  @override
  String get devicesTile => 'الأجهزة';

  @override
  String get devicesTileSubtitle => 'جهازان متصلان';

  @override
  String get classesTitle => 'الحصص';

  @override
  String get classNotFound => 'الحصة غير موجودة';

  @override
  String get classOverviewHeadline => 'لمحة عن الحصة';

  @override
  String get classOverviewBody =>
      'إيقاع تدريجي مع إنهاءات إيقاعية وتمارين مرونة وتوجيه لمعدل نبض القلب.';

  @override
  String get capacityLabel => 'السعة';

  @override
  String get intensityLabel => 'الشدة';

  @override
  String get spotsLabel => 'مقعد';

  @override
  String get bookClassButton => 'احجز الحصة';

  @override
  String get joinWaitlistButton => 'انضم لقائمة الانتظار';

  @override
  String get skipButton => 'تخطي';

  @override
  String get onboardingTitle1 => 'صمم روتينك المثالي';

  @override
  String get onboardingSubtitle1 => 'برمجة مخصصة حسب أهدافك ومعداتك ووقتك.';

  @override
  String get onboardingTitle2 => 'تابع كل تكرار وتعافٍ';

  @override
  String get onboardingSubtitle2 =>
      'تكامل مع الأجهزة، راقب الإجهاد، وعدل الحمل فوراً.';

  @override
  String get onboardingTitle3 => 'خدمات ذكية جاهزة';

  @override
  String get onboardingSubtitle3 =>
      'مساعدات ذكية تنسق التغذية والتدريب والتحديات في الوقت الحقيقي.';
}
