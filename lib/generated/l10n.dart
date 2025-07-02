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

  /// `The passwords do not match`
  String get Thepasswordsdonotmatch {
    return Intl.message(
      'The passwords do not match',
      name: 'Thepasswordsdonotmatch',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePasswordTitle {
    return Intl.message(
      'Change Password',
      name: 'changePasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `You can now set a new password for your account. Make sure to choose a strong and memorable one.`
  String get changePasswordSubtitle {
    return Intl.message(
      'You can now set a new password for your account. Make sure to choose a strong and memorable one.',
      name: 'changePasswordSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `New password\nnew beginning`
  String get newPasswordSlogan {
    return Intl.message(
      'New password\nnew beginning',
      name: 'newPasswordSlogan',
      desc: '',
      args: [],
    );
  }

  /// `We've sent a 5-digit verification code to your phone number. Please enter it to complete the registration.`
  String get otpSentMessage {
    return Intl.message(
      'We\'ve sent a 5-digit verification code to your phone number. Please enter it to complete the registration.',
      name: 'otpSentMessage',
      desc: '',
      args: [],
    );
  }

  /// `We’ve sent you a 5-digit verification code via SMS. Please enter it to continue and reset your password.`
  String get otpSentMessageForgot {
    return Intl.message(
      'We’ve sent you a 5-digit verification code via SMS. Please enter it to continue and reset your password.',
      name: 'otpSentMessageForgot',
      desc: '',
      args: [],
    );
  }

  /// `Code sent successfully`
  String get otpSentSuccess {
    return Intl.message(
      'Code sent successfully',
      name: 'otpSentSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Send Verification Code`
  String get sendOtpButton {
    return Intl.message(
      'Send Verification Code',
      name: 'sendOtpButton',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the phone number associated with your account so we can send you a verification code via SMS.`
  String get enterPhoneHint {
    return Intl.message(
      'Please enter the phone number associated with your account so we can send you a verification code via SMS.',
      name: 'enterPhoneHint',
      desc: '',
      args: [],
    );
  }

  /// `Forgot your password?\nNo worries, we're here to help.`
  String get forgotPasswordPrompt {
    return Intl.message(
      'Forgot your password?\nNo worries, we\'re here to help.',
      name: 'forgotPasswordPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the verification code.`
  String get otpEmptyError {
    return Intl.message(
      'Please enter the verification code.',
      name: 'otpEmptyError',
      desc: '',
      args: [],
    );
  }

  /// `The code must be 5 digits.`
  String get otpLengthError {
    return Intl.message(
      'The code must be 5 digits.',
      name: 'otpLengthError',
      desc: '',
      args: [],
    );
  }

  /// `Tap here to change`
  String get tapToChange {
    return Intl.message(
      'Tap here to change',
      name: 'tapToChange',
      desc: '',
      args: [],
    );
  }

  /// `Entered a wrong number?`
  String get enteredWrongNumber {
    return Intl.message(
      'Entered a wrong number?',
      name: 'enteredWrongNumber',
      desc: '',
      args: [],
    );
  }

  /// `Resend`
  String get resend {
    return Intl.message(
      'Resend',
      name: 'resend',
      desc: '',
      args: [],
    );
  }

  /// `Didn't receive the code?`
  String get didNotReceiveCode {
    return Intl.message(
      'Didn\'t receive the code?',
      name: 'didNotReceiveCode',
      desc: '',
      args: [],
    );
  }

  /// `Resend in 00:{seconds}`
  String resendCountdown(Object seconds) {
    return Intl.message(
      'Resend in 00:$seconds',
      name: 'resendCountdown',
      desc: '',
      args: [seconds],
    );
  }

  /// `A server error occurred. Please try again later.`
  String get error_server {
    return Intl.message(
      'A server error occurred. Please try again later.',
      name: 'error_server',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection.`
  String get error_network {
    return Intl.message(
      'Please check your internet connection.',
      name: 'error_network',
      desc: '',
      args: [],
    );
  }

  /// `The input data is invalid.`
  String get error_validation {
    return Intl.message(
      'The input data is invalid.',
      name: 'error_validation',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred.`
  String get error_unknown {
    return Intl.message(
      'An unexpected error occurred.',
      name: 'error_unknown',
      desc: '',
      args: [],
    );
  }

  /// `Operation Successful!`
  String get operation_successful_title {
    return Intl.message(
      'Operation Successful!',
      name: 'operation_successful_title',
      desc: '',
      args: [],
    );
  }

  /// `Congratulations! Your account has been created successfully.`
  String get account_created_success {
    return Intl.message(
      'Congratulations! Your account has been created successfully.',
      name: 'account_created_success',
      desc: '',
      args: [],
    );
  }

  /// `This phone number is already registered`
  String get error_phone_exists {
    return Intl.message(
      'This phone number is already registered',
      name: 'error_phone_exists',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number`
  String get error_phone_invalid {
    return Intl.message(
      'Invalid phone number',
      name: 'error_phone_invalid',
      desc: '',
      args: [],
    );
  }

  /// `Operation Failed`
  String get operation_failed_title {
    return Intl.message(
      'Operation Failed',
      name: 'operation_failed_title',
      desc: '',
      args: [],
    );
  }

  /// `Invalid phone number or password`
  String get error_invalid_credentials {
    return Intl.message(
      'Invalid phone number or password',
      name: 'error_invalid_credentials',
      desc: '',
      args: [],
    );
  }

  /// `Sign-In Failed`
  String get error_invalid_credentials_title {
    return Intl.message(
      'Sign-In Failed',
      name: 'error_invalid_credentials_title',
      desc: '',
      args: [],
    );
  }

  /// `Signed in successfully`
  String get sign_in_success_message {
    return Intl.message(
      'Signed in successfully',
      name: 'sign_in_success_message',
      desc: '',
      args: [],
    );
  }

  /// `Sign-up Failed`
  String get sign_up_failure_title {
    return Intl.message(
      'Sign-up Failed',
      name: 'sign_up_failure_title',
      desc: '',
      args: [],
    );
  }

  /// `Failed to resend the verification code. Please try again later.`
  String get resend_otp_failed {
    return Intl.message(
      'Failed to resend the verification code. Please try again later.',
      name: 'resend_otp_failed',
      desc: '',
      args: [],
    );
  }

  /// `Resend Failed`
  String get resend_otp_failed_title {
    return Intl.message(
      'Resend Failed',
      name: 'resend_otp_failed_title',
      desc: '',
      args: [],
    );
  }

  /// `Verification code was sent successfully. Please check your phone.`
  String get resend_otp_success {
    return Intl.message(
      'Verification code was sent successfully. Please check your phone.',
      name: 'resend_otp_success',
      desc: '',
      args: [],
    );
  }

  /// `Code Sent`
  String get resend_otp_success_title {
    return Intl.message(
      'Code Sent',
      name: 'resend_otp_success_title',
      desc: '',
      args: [],
    );
  }

  /// `The code has been verified successfully!`
  String get otp_verified_successfully {
    return Intl.message(
      'The code has been verified successfully!',
      name: 'otp_verified_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Verified`
  String get otp_verified_successfully_title {
    return Intl.message(
      'Verified',
      name: 'otp_verified_successfully_title',
      desc: '',
      args: [],
    );
  }

  /// `Invalid or expired verification code. Please try again.`
  String get invalid_otp_code {
    return Intl.message(
      'Invalid or expired verification code. Please try again.',
      name: 'invalid_otp_code',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Code`
  String get invalid_otp_code_title {
    return Intl.message(
      'Invalid Code',
      name: 'invalid_otp_code_title',
      desc: '',
      args: [],
    );
  }

  /// `Phone number has not been verified yet. Please check the verification code sent to you.`
  String get unverified_phone {
    return Intl.message(
      'Phone number has not been verified yet. Please check the verification code sent to you.',
      name: 'unverified_phone',
      desc: '',
      args: [],
    );
  }

  /// `Verification Required`
  String get unverified_phone_title {
    return Intl.message(
      'Verification Required',
      name: 'unverified_phone_title',
      desc: '',
      args: [],
    );
  }

  /// `Phone number not found`
  String get error_phone_not_found {
    return Intl.message(
      'Phone number not found',
      name: 'error_phone_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get changePasswordSuccess {
    return Intl.message(
      'Password changed successfully',
      name: 'changePasswordSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to change password`
  String get changePasswordFailure {
    return Intl.message(
      'Failed to change password',
      name: 'changePasswordFailure',
      desc: '',
      args: [],
    );
  }

  /// `Invalid token. Please log in again`
  String get tokenNotValid {
    return Intl.message(
      'Invalid token. Please log in again',
      name: 'tokenNotValid',
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
