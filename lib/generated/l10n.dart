// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Oxytocin`
  String get Oxytocin {
    return Intl.message(
      'Oxytocin',
      name: 'Oxytocin',
      desc: '',
      args: [],
    );
  }

  /// `Find Your Perfect Doctor`
  String get FindPerfectDoctor {
    return Intl.message(
      'Find Your Perfect Doctor',
      name: 'FindPerfectDoctor',
      desc: '',
      args: [],
    );
  }

  /// `Browse trusted doctors' profiles and choose the one that suits your needs with confidence and ease.`
  String get FindPerfectDoctorDes {
    return Intl.message(
      'Browse trusted doctors\' profiles and choose the one that suits your needs with confidence and ease.',
      name: 'FindPerfectDoctorDes',
      desc: '',
      args: [],
    );
  }

  /// `Your Medical Record in Your Hand`
  String get MedicalRecordInYourHand {
    return Intl.message(
      'Your Medical Record in Your Hand',
      name: 'MedicalRecordInYourHand',
      desc: '',
      args: [],
    );
  }

  /// `Track your health history and medical records anytime, securely.`
  String get MedicalRecordInYourHandDes {
    return Intl.message(
      'Track your health history and medical records anytime, securely.',
      name: 'MedicalRecordInYourHandDes',
      desc: '',
      args: [],
    );
  }

  /// `Your Privacy is Always Protected`
  String get YourPrivacyProtected {
    return Intl.message(
      'Your Privacy is Always Protected',
      name: 'YourPrivacyProtected',
      desc: '',
      args: [],
    );
  }

  /// `All your health information is encrypted and secure. Your privacy is our priority.`
  String get YourPrivacyProtectedDes {
    return Intl.message(
      'All your health information is encrypted and secure. Your privacy is our priority.',
      name: 'YourPrivacyProtectedDes',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message(
      'Next',
      name: 'Next',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get Skip {
    return Intl.message(
      'Skip',
      name: 'Skip',
      desc: '',
      args: [],
    );
  }

  /// `Start Now`
  String get StartNow {
    return Intl.message(
      'Start Now',
      name: 'StartNow',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get SignUp {
    return Intl.message(
      'Sign Up',
      name: 'SignUp',
      desc: '',
      args: [],
    );
  }

  /// `Sign In`
  String get SignIn {
    return Intl.message(
      'Sign In',
      name: 'SignIn',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get Password {
    return Intl.message(
      'Password',
      name: 'Password',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get PhoneNumber {
    return Intl.message(
      'Phone Number',
      name: 'PhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number`
  String get PleaseEnterValidNumber {
    return Intl.message(
      'Please enter a valid number',
      name: 'PleaseEnterValidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 8 characters long`
  String get Passwordatleast8characterslong {
    return Intl.message(
      'Password must be at least 8 characters long',
      name: 'Passwordatleast8characterslong',
      desc: '',
      args: [],
    );
  }

  /// `Password is required`
  String get Passwordisrequired {
    return Intl.message(
      'Password is required',
      name: 'Passwordisrequired',
      desc: '',
      args: [],
    );
  }

  /// `Password must include at least one lowercase letter`
  String get Passwordincludeleastonelowercaseletter {
    return Intl.message(
      'Password must include at least one lowercase letter',
      name: 'Passwordincludeleastonelowercaseletter',
      desc: '',
      args: [],
    );
  }

  /// `Password must include at least one uppercase letter`
  String get Passwordincludeleastoneuppercaseletter {
    return Intl.message(
      'Password must include at least one uppercase letter',
      name: 'Passwordincludeleastoneuppercaseletter',
      desc: '',
      args: [],
    );
  }

  /// `Password must include at least one number`
  String get Passwordmustincludeatleastonenumber {
    return Intl.message(
      'Password must include at least one number',
      name: 'Passwordmustincludeatleastonenumber',
      desc: '',
      args: [],
    );
  }

  /// `Password must include at least one special character`
  String get Passwordmustleastonespecialcharacter {
    return Intl.message(
      'Password must include at least one special character',
      name: 'Passwordmustleastonespecialcharacter',
      desc: '',
      args: [],
    );
  }

  /// `Password is too common. Please choose a more secure one`
  String get Passwordistoocommon {
    return Intl.message(
      'Password is too common. Please choose a more secure one',
      name: 'Passwordistoocommon',
      desc: '',
      args: [],
    );
  }

  /// `Password should not contain your username`
  String get Passwordshouldnotcontainyourusername {
    return Intl.message(
      'Password should not contain your username',
      name: 'Passwordshouldnotcontainyourusername',
      desc: '',
      args: [],
    );
  }

  /// `Password should not contain parts of your email`
  String get Passwordshouldnotcontainpartsofyouremail {
    return Intl.message(
      'Password should not contain parts of your email',
      name: 'Passwordshouldnotcontainpartsofyouremail',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?`
  String get Forgotyourpassword {
    return Intl.message(
      'Forgot your password?',
      name: 'Forgotyourpassword',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get Rememberme {
    return Intl.message(
      'Remember me',
      name: 'Rememberme',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get Thisfieldisrequired {
    return Intl.message(
      'This field is required',
      name: 'Thisfieldisrequired',
      desc: '',
      args: [],
    );
  }

  /// `Confirm password`
  String get Confirmpassword {
    return Intl.message(
      'Confirm password',
      name: 'Confirmpassword',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get Lastname {
    return Intl.message(
      'Last name',
      name: 'Lastname',
      desc: '',
      args: [],
    );
  }

  /// `User name`
  String get Username {
    return Intl.message(
      'User name',
      name: 'Username',
      desc: '',
      args: [],
    );
  }

  /// `At least 3 letters`
  String get Atleastletters {
    return Intl.message(
      'At least 3 letters',
      name: 'Atleastletters',
      desc: '',
      args: [],
    );
  }

  /// `The password must not contain your name or phone number.`
  String get passwordmustnotcontainyourorphonenumber {
    return Intl.message(
      'The password must not contain your name or phone number.',
      name: 'passwordmustnotcontainyourorphonenumber',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
