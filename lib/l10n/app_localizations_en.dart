// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get currentLocation => 'Current location';

  @override
  String get findRide => 'Find a ride';

  @override
  String get home_profileName => 'Ahmed Al Mansouri';

  @override
  String get home_profileLocation => 'Abu Dhabi City';

  @override
  String get home_currentLocationLabel => 'Current location';

  @override
  String home_weatherHighLow(Object high, Object low) {
    return 'H:$high°C   L:$low°C';
  }

  @override
  String get home_contentPlaceholder => 'Home Content';

  @override
  String get cityAbuDhabi => 'Abu Dhabi';

  @override
  String get highTemp => 'H';

  @override
  String get lowTemp => 'L';

  @override
  String get temperatureUnit => '°C';

  @override
  String get choose => 'Choose your';

  @override
  String get language => 'language';

  @override
  String get community_heading1 => 'Join the official';

  @override
  String get community_heading2 => 'Abu Dhabi Cycling Community';

  @override
  String get phone_action_card => 'Continue with phone';

  @override
  String get email_action_card => 'Enter your Email';

  @override
  String get create_button => 'Create Account';

  @override
  String get sign_in_option => 'Or sign in with';

  @override
  String get policy => 'By continuing, you agree to our Terms of Service and Privacy Policy';

  @override
  String get create_account_heading => 'Create your account';

  @override
  String get create_account_title => 'Join the cycling community today';

  @override
  String get phone_number_placeholder => 'Enter Your Mobile Number';

  @override
  String get continue_button => 'Continue';

  @override
  String get login_link => 'Already have an account? Login';

  @override
  String get error_required_number => 'Phone number is required';

  @override
  String get error_valid_number => 'Enter a valid phone number';

  @override
  String get createProfile => 'Create Profile';

  @override
  String get continueAsGuest => 'Continue as Guest';

  @override
  String get continueWithPhone => 'Continue with phone';

  @override
  String get continueWithEmail => 'Continue with email';

  @override
  String get orContinueWith => 'Or continue with';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get termsAndPolicy => "By continuing, you agree to ADCycling's Terms of Service and Privacy Policy";

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get store => 'Store';

  @override
  String get tracks => 'Tracks';

  @override
  String get challenges => 'Challenges';

  @override
  String get events => 'Events';

  @override
  String get community => 'Community';

  @override
  String get bikeExperience => 'Bike Experience';

  @override
  String get featuredEvents => 'Featured Events';

  @override
  String get upcomingEvents => 'Upcoming Events';

  @override
  String get featured => 'Featured';

  @override
  String get popularCommunities => 'Popular Communities';

  @override
  String get exploreCommunity => 'Explore Community';

  @override
  String get viewDetails => 'View Details';

  @override
  String get viewAll => 'View All';

  @override
  String get fetchingLocation => 'Fetching location...';

  @override
  String get joinCommunityPrompt => 'Want to join rides or be\npart of the community?';

  @override
  String get joinADCC => 'Join ADCC';

  @override
  String get communityUpdates => 'Community updates';

  @override
  String get nearbyTracks => 'Nearby Tracks';

  @override
  String get rideInAbuDhabi => 'Ride in Abu Dhabi';

  @override
  String get officialCyclingRoutes => 'Official Cycling Routes';

  @override
  String get exploreSafeRoutes => 'Explore safe routes across Abu Dhabi';

  @override
  String get trackSafetyGuidelines => 'Track Safety & Guidelines';

  @override
  String get staySafeOnRide => 'Stay safe on every ride';

  @override
  String get promoNewToClub => 'New to Abu Dhabi\nCycling Club?';

  @override
  String get promoJoinYour => 'Join Your';

  @override
  String get promoFirstCommunityRide => 'First Community Ride';

  @override
  String get promoRideTogether => 'Ride Together\nRide Stronger';

  @override
  String get promoExploreRoutes => 'Explore Abu Dhabi\nCycling Routes';

  @override
  String get eventCategoryAll => 'All';
  @override
  String get eventCategoryRaces => 'Races';
  @override
  String get eventCategoryCommunityRides => 'Community Rides';
  @override
  String get eventCategoryTrainingClinics => 'Training & Clinics';
  @override
  String get eventCategoryAwarenessRides => 'Awareness Rides';
  @override
  String get eventCategoryFamilyKids => 'Family & Kids';
  @override
  String get eventCategoryCorporate => 'Corporate';
  @override
  String get eventsAndCommunityRides => 'Events & Community Rides';
  @override
  String get eventsSubtitle => 'Official cycling events organized by ADCC communities across the UAE';
  @override
  String get searchEventsPlaceholder => 'Search events, communities, cities, or tracks...';
  @override
  String get noEventsAvailable => 'No events available';
  @override
  String get noEventsFound => 'No events found';
  @override
  String get eventsFoundSuffix => 'events found';
  @override
  String get failedToLoadEvents => 'Failed to load events';
  @override
  String get retry => 'Retry';
  @override
  String get riders => 'riders';
  @override
  String get tbd => 'TBD';
  @override
  String get upcomingEventsSubtitle => 'Competitive cycling events organized by ADCC communities';
  @override
  String get youAreRegistered => "You're registered!";
  @override
  String get getReadyForRide => "Get ready for an amazing ride with\nthe community!";
  @override
  String get addToCalendar => 'Add to Calendar';
  @override
  String get shareWithFriends => 'Share with Friends';
  @override
  String get viewMyEvents => 'View My Events';
  @override
  String get returnToHome => 'Return to Home';
  @override
  String get when => 'When';
  @override
  String get location => 'Location';
  @override
  String get type => 'Type';
  @override
  String get backToEvent => 'Back to Event';
  @override
  String get personalInformation => 'Personal Information';
  @override
  String get fullNameRequired => 'Full Name *';
  @override
  String get emailAddressRequired => 'Email Address *';
  @override
  String get phoneNumberRequired => 'Phone Number *';
  @override
  String get cyclingInformation => 'Cycling Information';
  @override
  String get doYouHaveOwnBike => "Do you have your own bike?";
  @override
  String get selectOption => 'Select option';
  @override
  String get yes => 'Yes';
  @override
  String get no => 'No';
  @override
  String get bikeTypeRequired => 'Bike Type *';
  @override
  String get selectBikeType => 'Select bike type';
  @override
  String get roadBike => 'Road Bike';
  @override
  String get mountainBike => 'Mountain Bike';
  @override
  String get hybridBike => 'Hybrid Bike';
  @override
  String get completeRegistration => 'Complete Registration';
  @override
  String get joinEventTermsAccept => "I accept the terms and confirm that all information\nprovided is accurate. I understand the safety\nrequirements and will comply with all event guidelines.";
  @override
  String get emergencyContact => 'Emergency Contact';
  @override
  String get emergencyContactName => 'Emergency Contact Name *';
  @override
  String get contactPersonName => 'Contact person name';
  @override
  String get emergencyContactPhone => 'Emergency Contact Phone *';
  @override
  String get myEvents => 'My Events';
  @override
  String get completed => 'Completed';
  @override
  String get upcoming => 'Upcoming';
  @override
  String get cancelled => 'Cancelled';
  @override
  String get noCompletedEvents => 'No completed events';
  @override
  String get noUpcomingEvents => 'No upcoming events';
  @override
  String get noCancelledEvents => 'No cancelled events';
  @override
  String get cancelRegistration => 'Cancel Registration';
  @override
  String get whyCancelling => "Please let us know why you're\ncancelling";
  @override
  String get scheduleConflict => 'Schedule conflict';
  @override
  String get healthReasons => 'Health reasons';
  @override
  String get notPrepared => 'Not prepared';
  @override
  String get weatherConcerns => 'Weather concerns';
  @override
  String get pleaseSelectReason => 'Please select a reason';
  @override
  String get confirmCancellation => 'Confirm Cancellation';
  @override
  String get pleaseWait => 'Please wait...';
  @override
  String get cancelFailed => 'Cancel failed';
  @override
  String get completedEventResult => 'Completed Event Result';
  @override
  String get yourResult => 'Your Result';
  @override
  String get distance => 'Distance';
  @override
  String get time => 'Time';
  @override
  String get rank => 'Rank';
  @override
  String get pointsEarned => 'Points Earned';
  @override
  String get badge => 'Badge';
  @override
  String get leaderboardTop10 => 'Leaderboard (Top 10)';
  @override
  String get you => 'You';
  @override
  String get open => 'Open';
  @override
  String get race => 'Race';
  @override
  String get eventsByCategory => 'Events by Category';
  @override
  String get eventsByCategorySubtitle => 'Competitive cycling events organized by ADCC communities';
  @override
  String get appPreferences => 'App Preferences';
  @override
  String get languageLabel => 'Language';
  @override
  String get english => 'English';
  @override
  String get units => 'Units';
  @override
  String get metricUnits => 'Metric (km, kg)';
  @override
  String get mapStyle => 'Map Style';
  @override
  String get standard => 'Standard';
  @override
  String get darkMode => 'Dark Mode';
  @override
  String get comingSoon => 'Coming soon';
  @override
  String get helpCenter => 'Help Center';
  @override
  String get termsAndConditions => 'Terms & Conditions';
  @override
  String get privacyPolicy => 'Privacy Policy';
  @override
  String get appVersion => 'App Version';
  @override
  String get myEventsAndCalendar => 'My Events & Calendar';
  @override
  String get badgesAndAchievements => 'Badges & achievements';
  @override
  String get myChallenges => 'My Challenges';
  @override
  String get myCyclingDetails => 'My Cycling Details';
  @override
  String get rewardsAndPoints => 'Rewards and points';
  @override
  String get settingsAndPreferences => 'Settings & preferences';
  @override
  String get km => 'KM';
  @override
  String get rides => 'Rides';
  @override
  String get connect => 'Connect';
  @override
  String get communities => 'Communities';
  @override
  String get communitiesInYourCity => 'Communities in Your City';
  @override
  String get browseByCommunityType => 'Browse by Community Type';
  @override
  String get communityTypes => 'Community Types';
  @override
  String get purposeBasedCommunities => 'Purpose-Based Communities';
  @override
  String get city => 'City';
  @override
  String get category => 'Category';
  @override
  String get primaryTrack => 'Primary Track';
  @override
  String get founded => 'Founded';
  @override
  String get members => 'Members';
  @override
  String get activeMembers => 'Active Members';
  @override
  String get totalDistanceThisMonth => 'Total Distance This Month';
  @override
  String get averageRideRating => 'Average Ride Rating';
  @override
  String get communityJoinedSuccess => 'Community joined successfully!';
  @override
  String get communityLeftSuccess => 'Community left successfully';
  @override
  String get startExploring => 'Start Exploring';
  @override
  String get notificationsEnabled => 'Notifications Enabled';
  @override
  String get notificationsComingSoon => 'Notifications feature coming soon';
  @override
  String get joinCommunityChats => 'Join Community Chats';
  @override
  String get chatComingSoon => 'Chat feature coming soon';
  @override
  String get eventsFeatureComingSoon => 'Events feature coming soon';
  @override
  String get tellUsMore => 'Tell us more...';
  @override
  String get shareYourChallenge => 'Share Your Challenge';
  @override
  String get tooEasy => 'Too Easy';
  @override
  String get justRight => 'Just Right';
  @override
  String get tooHard => 'Too Hard';
  @override
  String get shareDetailsExperience => 'Share details about your experience.';
  @override
  String get failedToLoadChallenge => 'Failed to load challenge details';
  @override
  String get goBack => 'Go Back';
  @override
  String get findATrack => 'Find a Track';
  @override
  String get trackNearYou => 'Track Near You';
  @override
  String get tracksNearYou => 'Tracks Near You';
  @override
  String get failedToLoadTracks => 'Failed to load tracks';
  @override
  String get officialCyclingTracks => 'Official Cycling Tracks';
  @override
  String get startRide => 'Start Ride';
  @override
  String get eventsOnThisTrack => 'Events on this track';
  @override
  String get routeDetailsPdf => 'Route Details (PDF)';
  @override
  String get safetyGuidelinesPdf => 'Safety Guidelines (PDF)';
  @override
  String get openInLinkMyRide => 'Open in Link My Ride';
  @override
  String get openInMaps => 'Open in Maps';
  @override
  String get date => 'Date';
  @override
  String get minAge => 'Min Age';
  @override
  String get segment => 'Segment';
  @override
  String get registration => 'Registration';
  @override
  String get viewListing => 'View Listing';
  @override
  String get postAnotherItem => 'Post Another Item';
  @override
  String get sell => '+ Sell';
  @override
  String get activeListings => 'Active listings';
  @override
  String get soldItems => 'Sold items';
  @override
  String get searchMarketplace => 'Search marketplace...';
  @override
  String get whatsAppSeller => 'WhatsApp Seller';
  @override
  String get call => 'Call';
  @override
  String get negotiable => 'Negotiable';
  @override
  String get listItemForSale => 'List Item for Sale';
  @override
  String get errorPickingImages => 'Error picking images';
  @override
  String get productListedSuccess => 'Product listed successfully!';
  @override
  String get failedToLoadProduct => 'Failed to load product details';
  @override
  String get bikeExperienceSubtitle => 'Expert technicians ready to help';
  @override
  String get basicTuneUp => 'Basic Tune-Up';
  @override
  String get fullService => 'Full Service';
  @override
  String get bookAppointment => 'Book Appointment';
  @override
  String get calling => 'Calling';
  @override
  String get bookAppointmentComingSoon => 'Book Appointment — coming soon';
  @override
  String get backendVerificationError => 'Backend Verification Error';
  @override
  String get authenticationError => 'Authentication Error';
  @override
  String get ok => 'OK';
  @override
  String get enterYourEmail => 'Enter your Email';
  @override
  String get enterYourPassword => 'Enter your Password';
  @override
  String get signIn => 'Sign In';
  @override
  String get signUp => 'Sign Up';
  @override
  String get dontHaveAccountSignUp => 'Don\'t have an account? Sign up';
  @override
  String get confirmPassword => 'Confirm password';
  @override
  String get onboardingTitle1 => 'YOUR CYCLING\n JOURNEY STARTS HERE';
  @override
  String get onboardingTitle2 => 'JOIN THE RIDE.LIVE\n THE PASSION.';
  @override
  String get rewardsAndPointsTitle => 'Rewards & Points';
  @override
  String get eventHistory => 'Event History';
  @override
  String get position => 'Position';
  @override
  String get averageCompletionRate => 'Average\nCompletion Rate';
  @override
  String get averageEventDistance => 'Average Event\nDistance';
  @override
  String get bestCategory => 'Best Category';
  @override
  String get badgesAndAchievementsTitle => 'Badges & Achivements';
  @override
  String get lighting => 'Lighting';
  @override
  String get waterStation => 'Water station';
  @override
  String get restroom => 'Restroom';
  @override
  String get locationServicesDisabled => 'Location services are disabled. Please enable them.';
  @override
  String get locationPermissionsDenied => 'Location permissions are denied.';
  @override
  String get purposeBasedEvents => 'Purpose Based Events';
  @override
  String get communitiesBasedOnPurpose => 'Communities based on purpose and goals';
  @override
  String get explore => 'Explore';
  @override
  String get beginner => 'Beginner';
  @override
  String get intermediate => 'Intermediate';
  @override
  String get advanced => 'Advanced';
  @override
  String get ambassador => 'Ambassador';
  @override
  String get next => 'Next';
  @override
  String get getStarted => 'Get Started';
  @override
  String get onboardingDesc1 => 'Track your rides, explore scenic routes, join events and connect with the UAE cycling community';
  @override
  String get onboardingDesc2 => 'Unlock a world of cycling experiences from scenic loops to community challenges all in one place';
  @override
  String get quickInfo => 'Quick Info';
  String get myBadges => 'My Badges';
  String get myCommunities => 'My Communities';
  String get searchTracksPlaceholder => 'Search tracks, city, distance or terrain...';
  String get joinChallenge => 'Join Challenge';
  String get markAsComplete => 'Mark as complete';
  String get logout => 'Logout';
  String get loggingOut => 'Logging out...';
  String get otpTitle => 'Verify Your Number';
  String get otpSubtitle => 'Enter the 4-digit code sent to your phone';
  String get otpDidntReceive => 'Didn\'t receive it?';
  String get otpResendIn => 'Resend in';
  String get otpVerify => 'Verify';
  @override
  String get setupProfileTitle => 'Set up your Profile';
  @override
  String get setupProfileStep => '1/2';
  @override
  String get enterFullNamePlaceholder => 'Enter your full name';
  @override
  String get chooseBirthDate => 'Choose your birth date';
  @override
  String get chooseGender => 'Choose your Gender';
  @override
  String get countryLabel => 'Country';
  @override
  String get userAgreementAndPrivacy => 'I\'ve read and agreed to User Agreement and Privacy Policy';
  @override
  String get genderMale => 'Male';
  @override
  String get genderFemale => 'Female';
  @override
  String get genderOther => 'Other';
  @override
  String get jerseySize => 'Jersey Size';
  @override
  String get governmentIdFront => 'Government Id (Front)';
  @override
  String get governmentIdBack => 'Government Id (Back)';
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
