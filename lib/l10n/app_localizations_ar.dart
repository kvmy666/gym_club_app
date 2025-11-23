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
  String get navTrack => 'سجل التمرين';

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
  String get trackTitle => 'سجل التمرين';

  @override
  String get trackSubtitle =>
      'سمّ اليوم التدريبي، واختر التمرين، وسجل كل جلسة.';

  @override
  String get logWorkout => 'سجل التمرين';

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
  String get logWeightButton => 'سجل التمرين';

  @override
  String get currentWeight => 'الحالي';

  @override
  String goalWeight(String value) {
    return 'الهدف $value كجم';
  }

  @override
  String get workoutNameLabel => 'اسم التمرين';

  @override
  String get workoutNameHint => 'أضف اسماً لهذه الجلسة';

  @override
  String get timeLabel => 'الوقت';

  @override
  String get timerLabel => 'المؤقت';

  @override
  String get restTimerLabel => 'مؤقت الراحة';

  @override
  String get volumeLabel => 'الحجم';

  @override
  String get setsLabel => 'الجلسات';

  @override
  String get setsHeader => 'الجلسات';

  @override
  String get addSet => 'أضف جلسة';

  @override
  String get noSetsYet =>
      'لا توجد جلسات بعد. أضف جلستك الأولى لبدء التتبع.';

  @override
  String get weightFieldLabel => 'الوزن (كجم)';

  @override
  String get invalidWeight => 'أدخل وزناً صحيحاً';

  @override
  String get repsFieldLabel => 'التكرارات';

  @override
  String get invalidReps => 'أدخل عدد تكرارات صالح';

  @override
  String get cancel => 'إلغاء';

  @override
  String get saveSet => 'احفظ الجلسة';

  @override
  String get deleteSet => 'حذف الجلسة';

  @override
  String get resumeButton => 'استمرار';

  @override
  String get finishButton => 'إنهاء';

  @override
  String get resetButton => 'إعادة ضبط';

  @override
  String get resetSessionButton => 'إعادة ضبط الجلسة';

  @override
  String get summaryHeader => 'ملخص الجلسات';

  @override
  String get addExerciseButton => 'اختر التمرين';

  @override
  String get exercisePickerTitle => 'اختر التمرين';

  @override
  String get exerciseSearchHint => 'ابحث عن تمرين';

  @override
  String get exerciseCategoryAll => 'الكل';

  @override
  String get exerciseCategoryBack => 'الظهر';

  @override
  String get exerciseCategoryChest => 'الصدر';

  @override
  String get exerciseCategoryLegs => 'الأرجل';

  @override
  String get exerciseCategoryShoulders => 'الأكتاف';

  @override
  String get exerciseCategoryCore => 'البطن والوسط';

  @override
  String get noExercisesYet => 'لا توجد تمارين بعد. أضف التمرين الأول للبدء.';

  @override
  String get deleteExercise => 'حذف التمرين';

  @override
  String exerciseSessionsLabel(int count) {
    return '$count جلسات';
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
  String cartTitle(int count) {
    return 'السلة • $count منتجات';
  }

  @override
  String get cartEmpty => 'سلتك فارغة';

  @override
  String get cartTotalLabel => 'الإجمالي (شامل 15٪ ضريبة)';

  @override
  String get cartCheckoutButton => 'أكمل الدفع';

  @override
  String get cartViewButton => 'عرض السلة';

  @override
  String get personalInfoSection => 'البيانات الشخصية';

  @override
  String get emailLabel => 'البريد الإلكتروني';

  @override
  String get weightLabel => 'الوزن';

  @override
  String get heightLabel => 'الطول';

  @override
  String get profileSaveButton => 'حفظ البيانات';

  @override
  String get profileSavedMessage => 'تم تحديث الملف الشخصي بنجاح.';

  @override
  String get membershipSection => 'عضوية النادي';

  @override
  String membershipRemaining(int days) {
    return 'متبقي $days يوم';
  }

  @override
  String get membershipPlans => 'الباقات';

  @override
  String get membershipPlanMonthly => 'شهري';

  @override
  String get membershipPlanQuarterly => 'ربع سنوي';

  @override
  String get membershipPlanSemiAnnual => 'نصف سنوي';

  @override
  String get membershipPlanAnnual => 'سنوي';

  @override
  String get membershipComparisonTitle => 'مقارنة الباقات';

  @override
  String get membershipRenewButton => 'تجديد العضوية';

  @override
  String membershipRenewSuccess(String plan) {
    return 'تم تجديد العضوية لمدة $plan.';
  }

  @override
  String get supportSection => 'الدعم الفني';

  @override
  String get supportEmailLabel => 'للمساعدة تواصل معنا عبر';

  @override
  String get supportEmail => 'krom306@gmail.com';

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

  @override
  String get calcTitle => 'حاسبة السعرات الحرارية';

  @override
  String get calcAgeLabel => 'العمر';

  @override
  String get calcAgeSuffix => 'سنة';

  @override
  String get calcHeightLabel => 'الطول';

  @override
  String get calcHeightSuffix => 'سم';

  @override
  String get calcWeightLabel => 'الوزن الحالي';

  @override
  String get calcWeightSuffix => 'كجم';

  @override
  String get calcTargetWeightLabel => 'الوزن المستهدف';

  @override
  String get calcGenderMale => 'ذكر';

  @override
  String get calcGenderFemale => 'أنثى';

  @override
  String get calcActivityLabel => 'مستوى النشاط';

  @override
  String get calcActivitySedentary => 'خامل (عمل مكتبي)';

  @override
  String get calcActivityLight => 'خفيف (١-٣ أيام/أسبوع)';

  @override
  String get calcActivityModerate => 'متوسط (٣-٥ أيام/أسبوع)';

  @override
  String get calcActivityActive => 'نشط (٦-٧ أيام/أسبوع)';

  @override
  String get calcActivityVeryActive => 'نشط جداً (رياضي)';

  @override
  String get calcGoalLabel => 'هدفك';

  @override
  String get calcGoalLose => 'خفض الوزن';

  @override
  String get calcGoalMaintain => 'حافظ على الوزن';

  @override
  String get calcGoalGain => 'زيادة الوزن';

  @override
  String get calcResultTitle => 'المدخول اليومي المقترح';

  @override
  String get calcResultUnit => 'سعرة';

  @override
  String calcTimeEstimate(int weeks) {
    return 'المدة التقريبية للهدف: $weeks أسابيع';
  }
}
