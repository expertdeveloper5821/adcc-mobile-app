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
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @currentLocation.
  ///
  /// In en, this message translates to:
  /// **'Current location'**
  String get currentLocation;

  /// No description provided for @findRide.
  ///
  /// In en, this message translates to:
  /// **'Find a ride'**
  String get findRide;

  /// No description provided for @home_profileName.
  ///
  /// In en, this message translates to:
  /// **'Ahmed Al Mansouri'**
  String get home_profileName;

  /// No description provided for @home_profileLocation.
  ///
  /// In en, this message translates to:
  /// **'Abu Dhabi City'**
  String get home_profileLocation;

  /// No description provided for @home_currentLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Current location'**
  String get home_currentLocationLabel;

  /// No description provided for @home_weatherHighLow.
  ///
  /// In en, this message translates to:
  /// **'H:{high}°C   L:{low}°C'**
  String home_weatherHighLow(Object high, Object low);

  /// No description provided for @home_contentPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Home Content'**
  String get home_contentPlaceholder;

  /// No description provided for @cityAbuDhabi.
  ///
  /// In en, this message translates to:
  /// **'Abu Dhabi'**
  String get cityAbuDhabi;

  /// No description provided for @highTemp.
  ///
  /// In en, this message translates to:
  /// **'H'**
  String get highTemp;

  /// No description provided for @lowTemp.
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get lowTemp;

  /// No description provided for @temperatureUnit.
  ///
  /// In en, this message translates to:
  /// **'°C'**
  String get temperatureUnit;

  /// No description provided for @choose.
  ///
  /// In en, this message translates to:
  /// **'Choose your'**
  String get choose;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'language'**
  String get language;

  /// No description provided for @community_heading1.
  ///
  /// In en, this message translates to:
  /// **'Join the official'**
  String get community_heading1;

  /// No description provided for @community_heading2.
  ///
  /// In en, this message translates to:
  /// **'Abu Dhabi Cycling Community'**
  String get community_heading2;

  /// No description provided for @phone_action_card.
  ///
  /// In en, this message translates to:
  /// **'Continue with phone'**
  String get phone_action_card;

  /// No description provided for @email_action_card.
  ///
  /// In en, this message translates to:
  /// **'Enter your Email'**
  String get email_action_card;

  /// No description provided for @create_button.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get create_button;

  /// No description provided for @sign_in_option.
  ///
  /// In en, this message translates to:
  /// **'Or sign in with'**
  String get sign_in_option;

  /// No description provided for @policy.
  ///
  /// In en, this message translates to:
  /// **'By continuing, you agree to our Terms of Service and Privacy Policy'**
  String get policy;

  /// No description provided for @create_account_heading.
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get create_account_heading;

  /// No description provided for @create_account_title.
  ///
  /// In en, this message translates to:
  /// **'Join the cycling community today'**
  String get create_account_title;

  /// No description provided for @phone_number_placeholder.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Mobile Number'**
  String get phone_number_placeholder;

  /// No description provided for @continue_button.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_button;

  /// No description provided for @login_link.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Login'**
  String get login_link;

  /// No description provided for @error_required_number.
  ///
  /// In en, this message translates to:
  /// **'Phone number is required'**
  String get error_required_number;

  /// No description provided for @error_valid_number.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid phone number'**
  String get error_valid_number;

  /// Create Profile screen
  String get createProfile;
  String get continueAsGuest;
  String get continueWithPhone;
  String get continueWithEmail;
  String get orContinueWith;
  String get continueWithApple;
  String get continueWithGoogle;
  String get termsAndPolicy;

  String get quickActions;
  String get store;
  String get tracks;
  String get challenges;
  String get events;
  String get community;
  String get bikeExperience;
  String get featuredEvents;
  String get upcomingEvents;
  String get featured;
  String get popularCommunities;
  String get exploreCommunity;
  String get viewDetails;
  String get viewAll;
  String get fetchingLocation;
  String get joinCommunityPrompt;
  String get joinADCC;
  String get communityUpdates;
  String get nearbyTracks;
  String get rideInAbuDhabi;
  String get officialCyclingRoutes;
  String get exploreSafeRoutes;
  String get trackSafetyGuidelines;
  String get staySafeOnRide;
  String get promoNewToClub;
  String get promoJoinYour;
  String get promoFirstCommunityRide;
  String get promoRideTogether;
  String get promoExploreRoutes;

  String get eventCategoryAll;
  String get eventCategoryRaces;
  String get eventCategoryCommunityRides;
  String get eventCategoryTrainingClinics;
  String get eventCategoryAwarenessRides;
  String get eventCategoryFamilyKids;
  String get eventCategoryCorporate;
  String get eventsAndCommunityRides;
  String get eventsSubtitle;
  String get searchEventsPlaceholder;
  String get noEventsAvailable;
  String get noEventsFound;
  String get eventsFoundSuffix;
  String get failedToLoadEvents;
  String get retry;
  String get riders;
  String get tbd;
  String get upcomingEventsSubtitle;
  String get youAreRegistered;
  String get getReadyForRide;
  String get addToCalendar;
  String get shareWithFriends;
  String get viewMyEvents;
  String get returnToHome;
  String get when;
  String get location;
  String get type;
  String get backToEvent;
  String get personalInformation;
  String get fullNameRequired;
  String get emailAddressRequired;
  String get phoneNumberRequired;
  String get cyclingInformation;
  String get doYouHaveOwnBike;
  String get selectOption;
  String get yes;
  String get no;
  String get bikeTypeRequired;
  String get selectBikeType;
  String get roadBike;
  String get mountainBike;
  String get hybridBike;
  String get completeRegistration;
  String get joinEventTermsAccept;
  String get emergencyContact;
  String get emergencyContactName;
  String get contactPersonName;
  String get emergencyContactPhone;
  String get myEvents;
  String get completed;
  String get upcoming;
  String get cancelled;
  String get noCompletedEvents;
  String get noUpcomingEvents;
  String get noCancelledEvents;
  String get cancelRegistration;
  String get whyCancelling;
  String get scheduleConflict;
  String get healthReasons;
  String get notPrepared;
  String get weatherConcerns;
  String get pleaseSelectReason;
  String get confirmCancellation;
  String get pleaseWait;
  String get cancelFailed;
  String get completedEventResult;
  String get yourResult;
  String get distance;
  String get time;
  String get rank;
  String get pointsEarned;
  String get badge;
  String get leaderboardTop10;
  String get you;
  String get open;
  String get race;
  String get eventsByCategory;
  String get eventsByCategorySubtitle;
  String get appPreferences;
  String get languageLabel;
  String get english;
  String get units;
  String get metricUnits;
  String get mapStyle;
  String get standard;
  String get darkMode;
  String get comingSoon;
  String get helpCenter;
  String get termsAndConditions;
  String get privacyPolicy;
  String get appVersion;
  String get myEventsAndCalendar;
  String get badgesAndAchievements;
  String get myChallenges;
  String get myCyclingDetails;
  String get rewardsAndPoints;
  String get settingsAndPreferences;
  String get km;
  String get rides;
  String get connect;
  String get communities;
  String get communitiesInYourCity;
  String get browseByCommunityType;
  String get communityTypes;
  String get purposeBasedCommunities;
  String get city;
  String get category;
  String get primaryTrack;
  String get founded;
  String get members;
  String get activeMembers;
  String get totalDistanceThisMonth;
  String get averageRideRating;
  String get communityJoinedSuccess;
  String get communityLeftSuccess;
  String get startExploring;
  String get notificationsEnabled;
  String get notificationsComingSoon;
  String get joinCommunityChats;
  String get chatComingSoon;
  String get eventsFeatureComingSoon;
  String get tellUsMore;
  String get shareYourChallenge;
  String get tooEasy;
  String get justRight;
  String get tooHard;
  String get shareDetailsExperience;
  String get failedToLoadChallenge;
  String get goBack;
  String get findATrack;
  String get trackNearYou;
  String get tracksNearYou;
  String get failedToLoadTracks;
  String get officialCyclingTracks;
  String get startRide;
  String get eventsOnThisTrack;
  String get routeDetailsPdf;
  String get safetyGuidelinesPdf;
  String get openInLinkMyRide;
  String get openInMaps;
  String get date;
  String get minAge;
  String get segment;
  String get registration;
  String get viewListing;
  String get postAnotherItem;
  String get sell;
  String get activeListings;
  String get soldItems;
  String get searchMarketplace;
  String get whatsAppSeller;
  String get call;
  String get negotiable;
  String get listItemForSale;
  String get errorPickingImages;
  String get productListedSuccess;
  String get failedToLoadProduct;
  String get bikeExperienceSubtitle;
  String get basicTuneUp;
  String get fullService;
  String get bookAppointment;
  String get calling;
  String get bookAppointmentComingSoon;
  String get backendVerificationError;
  String get authenticationError;
  String get ok;
  String get enterYourEmail;
  String get enterYourPassword;
  String get signIn;
  String get signUp;
  String get dontHaveAccountSignUp;
  String get confirmPassword;
  String get onboardingTitle1;
  String get onboardingTitle2;
  String get rewardsAndPointsTitle;
  String get eventHistory;
  String get position;
  String get averageCompletionRate;
  String get averageEventDistance;
  String get bestCategory;
  String get badgesAndAchievementsTitle;
  String get lighting;
  String get waterStation;
  String get restroom;
  String get locationServicesDisabled;
  String get locationPermissionsDenied;
  String get purposeBasedEvents;
  String get communitiesBasedOnPurpose;
  String get explore;
  String get beginner;
  String get intermediate;
  String get advanced;
  String get ambassador;
  String get next;
  String get getStarted;
  String get onboardingDesc1;
  String get onboardingDesc2;
  String get quickInfo;
  String get myBadges;
  String get myCommunities;
  String get searchTracksPlaceholder;
  String get joinChallenge;
  String get markAsComplete;
  String get logout;
  String get loggingOut;
  String get otpTitle;
  String get otpSubtitle;
  String get otpDidntReceive;
  String get otpResendIn;
  String get otpVerify;
  String get setupProfileTitle;
  String get setupProfileStep;
  String get enterFullNamePlaceholder;
  String get chooseBirthDate;
  String get chooseGender;
  String get countryLabel;
  String get userAgreementAndPrivacy;
  String get genderMale;
  String get genderFemale;
  String get genderOther;
  String get jerseySize;
  String get governmentIdFront;
  String get governmentIdBack;
  String get jerseySizeXS;
  String get jerseySizeS;
  String get jerseySizeM;
  String get jerseySizeL;
  String get jerseySizeXL;
  String get jerseySizeXXL;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
