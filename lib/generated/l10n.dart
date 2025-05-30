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

  /// `Browse trusted doctor profiles and choose the one that fits your needs with ease and confidence.`
  String get FindPerfectDoctorDes {
    return Intl.message(
      'Browse trusted doctor profiles and choose the one that fits your needs with ease and confidence.',
      name: 'FindPerfectDoctorDes',
      desc: '',
      args: [],
    );
  }

  /// `Your Medical Record in Your Hands`
  String get MedicalRecordInYourHand {
    return Intl.message(
      'Your Medical Record in Your Hands',
      name: 'MedicalRecordInYourHand',
      desc: '',
      args: [],
    );
  }

  /// `Track your health history and medical files anytime, securely.`
  String get MedicalRecordInYourHandDes {
    return Intl.message(
      'Track your health history and medical files anytime, securely.',
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

  /// `All your health information is encrypted and safe. Your privacy is our priority.`
  String get YourPrivacyProtectedDes {
    return Intl.message(
      'All your health information is encrypted and safe. Your privacy is our priority.',
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

  /// `Start now`
  String get startNow {
    return Intl.message(
      'Start now',
      name: 'startNow',
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
