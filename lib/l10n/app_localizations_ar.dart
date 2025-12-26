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
}
