import '../data/model/response/language_model.dart';

class AppConstants {
  static const  appName = 'Daif - Owner';
  static const  appVersion = '1.0.0';
  static const  currency = '₪';
  static const  dayfFacebook ='https://www.facebook.com/profile.php?id=100094698267464/';
  static const  dayfInstagram ='https://www.instagram.com/dayf_app/';
  static const  dayfWebsite ='https://www.dayf-app.com/';
  static const  dayfWhatsapp ='https://api.whatsapp.com/send?phone=+972595663793';
  static const  dayfTelegram ='https://t.me/+w2iPz4txTu8yYjc6';
  static const  dayfEmail ='mailto:info@dayf-app.com';
  static const  dayfPhoneNumber ='tel:0595130400';
  // API end points
  // static const  baseUrl = "http://46.101.71.155/api";
  static const  baseUrl = "https://api.dayf-app.com/api"; // production
  // static const  baseUrl = "https://apitest.dayf-app.com/api"; // testing
  static const  loginUrl = '/owner/auth/login';
  static const  logout = '/owner/logout';
  static const  registerUrl = '/owner/auth/register';
  static const  createChalet = '/owner/chalets/create';
  static const  getAllChalets = '/owner/chalets';
  static const  sendOtp = '/owner/auth/send_verify_code';
  static const  verifyOtp = '/owner/auth/check_verify_code';
  static const  services = '/services';
  static const  appConfigurations = '/owner/app_configurations';

  // app constants
  static const token = "token";
  static const langKey = "lang_key";
  static const  currentLocaleKey = 'current_locale_key';
  static const  userInfo = 'user_info';
  static const  shownOnBoarding = 'shown_onBoarding';
  static const  rememberedUser = 'remembered_user';
  static const  otpLength = 6;
  static const  itemsPerPage = 2;

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: '',
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: '',
        languageName: 'Arabic',
        countryCode: 'SA',
        languageCode: 'ar'),
  ];

  static const dummyPlaceImg = "https://img.freepik.com/premium-photo/3d-rendering-large-modern-contemporary-house-wood-concrete_190619-1483.jpg?w=1060";


}

// other constants
final bookingHour = 7;

final String termsAndConditions =
"""Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.
Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et""";
