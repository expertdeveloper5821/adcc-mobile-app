// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get currentLocation => 'الموقع الحالي';

  @override
  String get findRide => 'اعثر على رحلة';

  @override
  String get home_profileName => 'أحمد المنصوري';

  @override
  String get home_profileLocation => 'مدينة أبوظبي';

  @override
  String get home_currentLocationLabel => 'الموقع الحالي';

  @override
  String home_weatherHighLow(Object high, Object low) {
    return 'العظمى $high°C   الصغرى $low°C';
  }

  @override
  String get home_contentPlaceholder => 'محتوى الصفحة الرئيسية';

  @override
  String get cityAbuDhabi => 'أبوظبي';

  @override
  String get highTemp => 'ع';

  @override
  String get lowTemp => 'ص';

  @override
  String get temperatureUnit => '°م';

  @override
  String get choose => 'اختر الخاص بك';

  @override
  String get language => 'لغة';

  @override
  String get community_heading1 => 'انضم إلى المسؤول';

  @override
  String get community_heading2 => 'مجتمع أبو ظبي للدراجات';

  @override
  String get phone_action_card => 'تواصل مع الهاتف';

  @override
  String get email_action_card => 'أدخل بريدك الإلكتروني';

  @override
  String get create_button => 'إنشاء حساب';

  @override
  String get sign_in_option => 'أو قم بتسجيل الدخول باستخدام';

  @override
  String get policy => 'بمتابعتك، فإنك توافق على شروط الخدمة وسياسة الخصوصية الخاصة بنا.';

  @override
  String get create_account_heading => 'أنشئ حسابك';

  @override
  String get create_account_title => 'انضم إلى مجتمع راكبي الدراجات اليوم';

  @override
  String get phone_number_placeholder => 'أدخل رقم هاتفك المحمول';

  @override
  String get continue_button => 'يكمل';

  @override
  String get login_link => 'هل لديك حساب بالفعل؟ تسجيل الدخول';

  @override
  String get error_required_number => 'رقم الهاتف مطلوب';

  @override
  String get error_valid_number => 'أدخل رقم هاتف صحيح';

  @override
  String get createProfile => 'إنشاء الملف الشخصي';

  @override
  String get continueAsGuest => 'متابعة كضيف';

  @override
  String get continueWithPhone => 'متابعة بالهاتف';

  @override
  String get continueWithEmail => 'متابعة بالبريد الإلكتروني';

  @override
  String get orContinueWith => 'أو متابعة باستخدام';

  @override
  String get continueWithApple => 'متابعة مع Apple';

  @override
  String get continueWithGoogle => 'متابعة مع Google';

  @override
  String get termsAndPolicy => 'بمتابعتك، فإنك توافق على شروط الخدمة وسياسة الخصوصية الخاصة بـ ADCycling';

  @override
  String get quickActions => 'إجراءات سريعة';

  @override
  String get store => 'المتجر';

  @override
  String get tracks => 'المسارات';

  @override
  String get challenges => 'التحديات';

  @override
  String get events => 'الفعاليات';

  @override
  String get community => 'المجتمع';

  @override
  String get bikeExperience => 'تجربة الدراجة';

  @override
  String get featuredEvents => 'فعاليات مميزة';

  @override
  String get upcomingEvents => 'الفعاليات القادمة';

  @override
  String get featured => 'مميز';

  @override
  String get popularCommunities => 'المجتمعات الشائعة';

  @override
  String get exploreCommunity => 'استكشف المجتمع';

  @override
  String get viewDetails => 'عرض التفاصيل';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get fetchingLocation => 'جاري جلب الموقع...';

  @override
  String get joinCommunityPrompt => 'هل تريد الانضمام للجولات أو أن\nتكون جزءاً من المجتمع؟';

  @override
  String get joinADCC => 'انضم لـ ADCC';

  @override
  String get communityUpdates => 'تحديثات المجتمع';

  @override
  String get nearbyTracks => 'المسارات القريبة';

  @override
  String get rideInAbuDhabi => 'اركب في أبوظبي';

  @override
  String get officialCyclingRoutes => 'مسارات الدراجات الرسمية';

  @override
  String get exploreSafeRoutes => 'استكشف المسارات الآمنة في أبوظبي';

  @override
  String get trackSafetyGuidelines => 'سلامة المسار والإرشادات';

  @override
  String get staySafeOnRide => 'ابقَ آمناً في كل جولة';

  @override
  String get promoNewToClub => 'جديد في نادي أبوظبي\nلراكبي الدراجات؟';

  @override
  String get promoJoinYour => 'انضم إلى';

  @override
  String get promoFirstCommunityRide => 'أول جولة مجتمعية';

  @override
  String get promoRideTogether => 'اركبوا معاً\nأقوى معاً';

  @override
  String get promoExploreRoutes => 'استكشف مسارات\nالدراجات في أبوظبي';

  @override
  String get eventCategoryAll => 'الكل';
  @override
  String get eventCategoryRaces => 'سباقات';
  @override
  String get eventCategoryCommunityRides => 'جولات مجتمعية';
  @override
  String get eventCategoryTrainingClinics => 'تدريب وعيادات';
  @override
  String get eventCategoryAwarenessRides => 'جولات توعوية';
  @override
  String get eventCategoryFamilyKids => 'عائلة وأطفال';
  @override
  String get eventCategoryCorporate => 'شركات';
  @override
  String get eventsAndCommunityRides => 'فعاليات وجولات مجتمعية';
  @override
  String get eventsSubtitle => 'فعاليات دراجات رسمية تنظمها مجتمعات ADCC في الإمارات';
  @override
  String get searchEventsPlaceholder => 'ابحث عن فعاليات، مجتمعات، مدن أو مسارات...';
  @override
  String get noEventsAvailable => 'لا توجد فعاليات متاحة';
  @override
  String get noEventsFound => 'لم يتم العثور على فعاليات';
  @override
  String get eventsFoundSuffix => 'فعاليات موجودة';
  @override
  String get failedToLoadEvents => 'فشل تحميل الفعاليات';
  @override
  String get retry => 'إعادة المحاولة';
  @override
  String get riders => 'مشاركين';
  @override
  String get tbd => 'يُحدد لاحقاً';
  @override
  String get upcomingEventsSubtitle => 'فعاليات دراجات تنافسية تنظمها المجتمعات';
  @override
  String get youAreRegistered => 'تم تسجيلك!';
  @override
  String get getReadyForRide => 'استعد لجولة رائعة مع\nالمجتمع!';
  @override
  String get addToCalendar => 'إضافة إلى التقويم';
  @override
  String get shareWithFriends => 'مشاركة مع الأصدقاء';
  @override
  String get viewMyEvents => 'عرض فعالياتي';
  @override
  String get returnToHome => 'العودة للرئيسية';
  @override
  String get when => 'متى';
  @override
  String get location => 'الموقع';
  @override
  String get type => 'النوع';
  @override
  String get backToEvent => 'العودة للفعالية';
  @override
  String get personalInformation => 'المعلومات الشخصية';
  @override
  String get fullNameRequired => 'الاسم الكامل *';
  @override
  String get emailAddressRequired => 'البريد الإلكتروني *';
  @override
  String get phoneNumberRequired => 'رقم الهاتف *';
  @override
  String get cyclingInformation => 'معلومات ركوب الدراجات';
  @override
  String get doYouHaveOwnBike => 'هل تمتلك دراجتك؟';
  @override
  String get selectOption => 'اختر خياراً';
  @override
  String get yes => 'نعم';
  @override
  String get no => 'لا';
  @override
  String get bikeTypeRequired => 'نوع الدراجة *';
  @override
  String get selectBikeType => 'اختر نوع الدراجة';
  @override
  String get roadBike => 'دراجة طريق';
  @override
  String get mountainBike => 'دراجة جبلية';
  @override
  String get hybridBike => 'دراجة هجينة';
  @override
  String get completeRegistration => 'إتمام التسجيل';
  @override
  String get joinEventTermsAccept => 'أوافق على الشروط وأؤكد صحة المعلومات.\nأفهم متطلبات السلامة وسألتزم بإرشادات الفعالية.';
  @override
  String get emergencyContact => 'جهة اتصال الطوارئ';
  @override
  String get emergencyContactName => 'اسم جهة اتصال الطوارئ *';
  @override
  String get contactPersonName => 'اسم جهة الاتصال';
  @override
  String get emergencyContactPhone => 'هاتف الطوارئ *';
  @override
  String get myEvents => 'فعالياتي';
  @override
  String get completed => 'منتهية';
  @override
  String get upcoming => 'قادمة';
  @override
  String get cancelled => 'ملغاة';
  @override
  String get noCompletedEvents => 'لا توجد فعاليات منتهية';
  @override
  String get noUpcomingEvents => 'لا توجد فعاليات قادمة';
  @override
  String get noCancelledEvents => 'لا توجد فعاليات ملغاة';
  @override
  String get cancelRegistration => 'إلغاء التسجيل';
  @override
  String get whyCancelling => 'أخبرنا سبب الإلغاء';
  @override
  String get scheduleConflict => 'تعارض في المواعيد';
  @override
  String get healthReasons => 'أسباب صحية';
  @override
  String get notPrepared => 'غير مستعد';
  @override
  String get weatherConcerns => 'مخاوف الطقس';
  @override
  String get pleaseSelectReason => 'الرجاء اختيار سبب';
  @override
  String get confirmCancellation => 'تأكيد الإلغاء';
  @override
  String get pleaseWait => 'يرجى الانتظار...';
  @override
  String get cancelFailed => 'فشل الإلغاء';
  @override
  String get completedEventResult => 'نتيجة الفعالية المنتهية';
  @override
  String get yourResult => 'نتيجتك';
  @override
  String get distance => 'المسافة';
  @override
  String get time => 'الوقت';
  @override
  String get rank => 'الترتيب';
  @override
  String get pointsEarned => 'النقاط المكتسبة';
  @override
  String get badge => 'الشارة';
  @override
  String get leaderboardTop10 => 'لوحة المتصدرين (أفضل 10)';
  @override
  String get you => 'أنت';
  @override
  String get open => 'مفتوح';
  @override
  String get race => 'سباق';
  @override
  String get eventsByCategory => 'فعاليات حسب الفئة';
  @override
  String get eventsByCategorySubtitle => 'فعاليات دراجات تنافسية تنظمها مجتمعات ADCC';
  @override
  String get appPreferences => 'تفضيلات التطبيق';
  @override
  String get languageLabel => 'اللغة';
  @override
  String get english => 'English';
  @override
  String get units => 'الوحدات';
  @override
  String get metricUnits => 'متري (كم، كجم)';
  @override
  String get mapStyle => 'نمط الخريطة';
  @override
  String get standard => 'قياسي';
  @override
  String get darkMode => 'الوضع الداكن';
  @override
  String get comingSoon => 'قريباً';
  @override
  String get helpCenter => 'مركز المساعدة';
  @override
  String get termsAndConditions => 'الشروط والأحكام';
  @override
  String get privacyPolicy => 'سياسة الخصوصية';
  @override
  String get appVersion => 'إصدار التطبيق';
  @override
  String get myEventsAndCalendar => 'فعالياتي والتقويم';
  @override
  String get badgesAndAchievements => 'الشارات والإنجازات';
  @override
  String get myChallenges => 'تحدياتي';
  @override
  String get myCyclingDetails => 'تفاصيل ركوب الدراجات';
  @override
  String get rewardsAndPoints => 'المكافآت والنقاط';
  @override
  String get settingsAndPreferences => 'الإعدادات والتفضيلات';
  @override
  String get km => 'كم';
  @override
  String get rides => 'جولات';
  @override
  String get connect => 'ربط';
  @override
  String get communities => 'المجتمعات';
  @override
  String get communitiesInYourCity => 'المجتمعات في مدينتك';
  @override
  String get browseByCommunityType => 'تصفح حسب نوع المجتمع';
  @override
  String get communityTypes => 'أنواع المجتمعات';
  @override
  String get purposeBasedCommunities => 'مجتمعات حسب الهدف';
  @override
  String get city => 'المدينة';
  @override
  String get category => 'الفئة';
  @override
  String get primaryTrack => 'المسار الرئيسي';
  @override
  String get founded => 'تأسس';
  @override
  String get members => 'الأعضاء';
  @override
  String get activeMembers => 'الأعضاء النشطون';
  @override
  String get totalDistanceThisMonth => 'إجمالي المسافة هذا الشهر';
  @override
  String get averageRideRating => 'متوسط تقييم الجولة';
  @override
  String get communityJoinedSuccess => 'تم الانضمام للمجتمع بنجاح!';
  @override
  String get communityLeftSuccess => 'تم مغادرة المجتمع بنجاح';
  @override
  String get startExploring => 'ابدأ الاستكشاف';
  @override
  String get notificationsEnabled => 'الإشعارات مفعلة';
  @override
  String get notificationsComingSoon => 'ميزة الإشعارات قريباً';
  @override
  String get joinCommunityChats => 'انضم لمحادثات المجتمع';
  @override
  String get chatComingSoon => 'ميزة المحادثة قريباً';
  @override
  String get eventsFeatureComingSoon => 'ميزة الفعاليات قريباً';
  @override
  String get tellUsMore => 'أخبرنا المزيد...';
  @override
  String get shareYourChallenge => 'شارك تحديك';
  @override
  String get tooEasy => 'سهل جداً';
  @override
  String get justRight => 'مناسب';
  @override
  String get tooHard => 'صعب جداً';
  @override
  String get shareDetailsExperience => 'شارك تفاصيل تجربتك.';
  @override
  String get failedToLoadChallenge => 'فشل تحميل تفاصيل التحدي';
  @override
  String get goBack => 'رجوع';
  @override
  String get findATrack => 'اعثر على مسار';
  @override
  String get trackNearYou => 'مسار قريب منك';
  @override
  String get tracksNearYou => 'المسارات القريبة';
  @override
  String get failedToLoadTracks => 'فشل تحميل المسارات';
  @override
  String get officialCyclingTracks => 'مسارات الدراجات الرسمية';
  @override
  String get startRide => 'ابدأ الجولة';
  @override
  String get eventsOnThisTrack => 'فعاليات على هذا المسار';
  @override
  String get routeDetailsPdf => 'تفاصيل المسار (PDF)';
  @override
  String get safetyGuidelinesPdf => 'إرشادات السلامة (PDF)';
  @override
  String get openInLinkMyRide => 'فتح في Link My Ride';
  @override
  String get openInMaps => 'فتح في الخرائط';
  @override
  String get date => 'التاريخ';
  @override
  String get minAge => 'الحد الأدنى للعمر';
  @override
  String get segment => 'المرحلة';
  @override
  String get registration => 'التسجيل';
  @override
  String get viewListing => 'عرض الإعلان';
  @override
  String get postAnotherItem => 'نشر عنصر آخر';
  @override
  String get sell => '+ بيع';
  @override
  String get activeListings => 'إعلانات نشطة';
  @override
  String get soldItems => 'عناصر مباعة';
  @override
  String get searchMarketplace => 'بحث في السوق...';
  @override
  String get whatsAppSeller => 'واتساب البائع';
  @override
  String get call => 'اتصال';
  @override
  String get negotiable => 'قابل للتفاوض';
  @override
  String get listItemForSale => 'إدراج عنصر للبيع';
  @override
  String get errorPickingImages => 'خطأ في اختيار الصور';
  @override
  String get productListedSuccess => 'تم نشر المنتج بنجاح!';
  @override
  String get failedToLoadProduct => 'فشل تحميل تفاصيل المنتج';
  @override
  String get bikeExperienceSubtitle => 'فنيون خبراء جاهزون للمساعدة';
  @override
  String get basicTuneUp => 'ضبط أساسي';
  @override
  String get fullService => 'خدمة كاملة';
  @override
  String get bookAppointment => 'حجز موعد';
  @override
  String get calling => 'جاري الاتصال';
  @override
  String get bookAppointmentComingSoon => 'حجز موعد — قريباً';
  @override
  String get backendVerificationError => 'خطأ في التحقق من الخادم';
  @override
  String get authenticationError => 'خطأ في المصادقة';
  @override
  String get ok => 'موافق';
  @override
  String get enterYourEmail => 'أدخل بريدك الإلكتروني';
  @override
  String get enterYourPassword => 'أدخل كلمة المرور';
  @override
  String get signIn => 'تسجيل الدخول';
  @override
  String get signUp => 'إنشاء حساب';
  @override
  String get dontHaveAccountSignUp => 'ليس لديك حساب؟ سجّل الآن';
  @override
  String get confirmPassword => 'تأكيد كلمة المرور';
  @override
  String get onboardingTitle1 => 'رحلتك في ركوب الدراجات\nتبدأ من هنا';
  @override
  String get onboardingTitle2 => 'انضم للجولة. عش\nالشغف.';
  @override
  String get rewardsAndPointsTitle => 'المكافآت والنقاط';
  @override
  String get eventHistory => 'سجل الفعاليات';
  @override
  String get position => 'المركز';
  @override
  String get averageCompletionRate => 'متوسط\nمعدل الإكمال';
  @override
  String get averageEventDistance => 'متوسط مسافة\nالفعالية';
  @override
  String get bestCategory => 'أفضل فئة';
  @override
  String get badgesAndAchievementsTitle => 'الشارات والإنجازات';
  @override
  String get lighting => 'إضاءة';
  @override
  String get waterStation => 'محطة مياه';
  @override
  String get restroom => 'مرافق';
  @override
  String get locationServicesDisabled => 'خدمات الموقع معطلة. يرجى تفعيلها.';
  @override
  String get locationPermissionsDenied => 'تم رفض أذونات الموقع.';
  @override
  String get purposeBasedEvents => 'فعاليات حسب الهدف';
  @override
  String get communitiesBasedOnPurpose => 'مجتمعات حسب الهدف والأهداف';
  @override
  String get explore => 'استكشف';
  @override
  String get beginner => 'مبتدئ';
  @override
  String get intermediate => 'متوسط';
  @override
  String get advanced => 'متقدم';
  @override
  String get ambassador => 'سفير';
  @override
  String get next => 'التالي';
  @override
  String get getStarted => 'ابدأ';
  @override
  String get onboardingDesc1 => 'تتبع جولاتك، استكشف المسارات، انضم للفعاليات وتواصل مع مجتمع الدراجات في الإمارات';
  @override
  String get onboardingDesc2 => 'اكتشف عالم تجارب ركوب الدراجات من الحلقات إلى التحديات المجتمعية في مكان واحد';
  @override
  String get quickInfo => 'معلومات سريعة';
  String get myBadges => 'شاراتي';
  String get myCommunities => 'مجتمعاتي';
  String get searchTracksPlaceholder => 'ابحث عن مسارات، مدينة، مسافة أو تضاريس...';
  String get joinChallenge => 'انضم للتحدي';
  String get markAsComplete => 'تحديد كمكتمل';
  String get logout => 'تسجيل الخروج';
  String get loggingOut => 'جاري تسجيل الخروج...';
  String get otpTitle => 'تأكيد رقمك';
  String get otpSubtitle => 'أدخل رمز التحقق المكوّن من 4 أرقام المرسل إلى هاتفك';
  String get otpDidntReceive => 'لم يصلك الرمز؟';
  String get otpResendIn => 'إعادة الإرسال خلال';
  String get otpVerify => 'تأكيد';
  @override
  String get setupProfileTitle => 'إعداد ملفك الشخصي';
  @override
  String get setupProfileStep => '1/2';
  @override
  String get enterFullNamePlaceholder => 'أدخل اسمك الكامل';
  @override
  String get chooseBirthDate => 'اختر تاريخ ميلادك';
  @override
  String get chooseGender => 'اختر جنسك';
  @override
  String get countryLabel => 'الدولة';
  @override
  String get userAgreementAndPrivacy => 'لقد قرأت ووافقت على اتفاقية المستخدم وسياسة الخصوصية';
  @override
  String get genderMale => 'ذكر';
  @override
  String get genderFemale => 'أنثى';
  @override
  String get genderOther => 'آخر';
  @override
  String get jerseySize => 'مقاس القميص';
  @override
  String get governmentIdFront => 'الهوية (الوجه الأمامي)';
  @override
  String get governmentIdBack => 'الهوية (الوجه الخلفي)';
  @override
  String get jerseySizeXS => 'XS';
  @override
  String get jerseySizeS => 'S';
  @override
  String get jerseySizeM => 'M';
  @override
  String get jerseySizeL => 'L';
  @override
  String get jerseySizeXL => 'XL';
  @override
  String get jerseySizeXXL => 'XXL';
}
