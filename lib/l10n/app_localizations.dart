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
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @oxytocin.
  ///
  /// In en, this message translates to:
  /// **'Oxytocin'**
  String get oxytocin;

  /// No description provided for @findPerfectDoctor.
  ///
  /// In en, this message translates to:
  /// **'Find Your Perfect Doctor'**
  String get findPerfectDoctor;

  /// No description provided for @findPerfectDoctorDes.
  ///
  /// In en, this message translates to:
  /// **'Browse trusted doctors\' profiles and choose the one that suits your needs with confidence and ease.'**
  String get findPerfectDoctorDes;

  /// No description provided for @medicalRecordInYourHand.
  ///
  /// In en, this message translates to:
  /// **'Your Medical Record in Your Hand'**
  String get medicalRecordInYourHand;

  /// No description provided for @medicalRecordInYourHandDes.
  ///
  /// In en, this message translates to:
  /// **'Track your health history and medical records anytime, securely.'**
  String get medicalRecordInYourHandDes;

  /// No description provided for @yourPrivacyProtected.
  ///
  /// In en, this message translates to:
  /// **'Your Privacy is Always Protected'**
  String get yourPrivacyProtected;

  /// No description provided for @yourPrivacyProtectedDes.
  ///
  /// In en, this message translates to:
  /// **'All your health information is encrypted and secure. Your privacy is our priority.'**
  String get yourPrivacyProtectedDes;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @startNow.
  ///
  /// In en, this message translates to:
  /// **'Start Now'**
  String get startNow;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @pleaseEnterValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get pleaseEnterValidNumber;

  /// No description provided for @passwordatleast8characterslong.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long'**
  String get passwordatleast8characterslong;

  /// No description provided for @passwordisrequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordisrequired;

  /// No description provided for @passwordincludeleastonelowercaseletter.
  ///
  /// In en, this message translates to:
  /// **'Password must include at least one lowercase letter'**
  String get passwordincludeleastonelowercaseletter;

  /// No description provided for @passwordincludeleastoneuppercaseletter.
  ///
  /// In en, this message translates to:
  /// **'Password must include at least one uppercase letter'**
  String get passwordincludeleastoneuppercaseletter;

  /// No description provided for @passwordmustincludeatleastonenumber.
  ///
  /// In en, this message translates to:
  /// **'Password must include at least one number'**
  String get passwordmustincludeatleastonenumber;

  /// No description provided for @passwordmustleastonespecialcharacter.
  ///
  /// In en, this message translates to:
  /// **'Password must include at least one special character'**
  String get passwordmustleastonespecialcharacter;

  /// No description provided for @passwordistoocommon.
  ///
  /// In en, this message translates to:
  /// **'Password is too common. Please choose a more secure one'**
  String get passwordistoocommon;

  /// No description provided for @passwordshouldnotcontainyourusername.
  ///
  /// In en, this message translates to:
  /// **'Password should not contain your username'**
  String get passwordshouldnotcontainyourusername;

  /// No description provided for @passwordshouldnotcontainpartsofyouremail.
  ///
  /// In en, this message translates to:
  /// **'Password should not contain parts of your email'**
  String get passwordshouldnotcontainpartsofyouremail;

  /// No description provided for @forgotyourpassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get forgotyourpassword;

  /// No description provided for @rememberme.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberme;

  /// No description provided for @thisfieldisrequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get thisfieldisrequired;

  /// No description provided for @confirmpassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get confirmpassword;

  /// No description provided for @lastname.
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get lastname;

  /// No description provided for @username.
  ///
  /// In en, this message translates to:
  /// **'User name'**
  String get username;

  /// No description provided for @atleastletters.
  ///
  /// In en, this message translates to:
  /// **'At least 3 letters'**
  String get atleastletters;

  /// No description provided for @passwordmustnotcontainyourorphonenumber.
  ///
  /// In en, this message translates to:
  /// **'The password must not contain your name or phone number.'**
  String get passwordmustnotcontainyourorphonenumber;

  /// No description provided for @thepasswordsdonotmatch.
  ///
  /// In en, this message translates to:
  /// **'The passwords do not match'**
  String get thepasswordsdonotmatch;

  /// No description provided for @changePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePasswordTitle;

  /// No description provided for @changePasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can now set a new password for your account. Make sure to choose a strong and memorable one.'**
  String get changePasswordSubtitle;

  /// No description provided for @newPasswordSlogan.
  ///
  /// In en, this message translates to:
  /// **'New password\nnew beginning'**
  String get newPasswordSlogan;

  /// No description provided for @otpSentMessage.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a 5-digit verification code to your phone number. Please enter it to complete the registration.'**
  String get otpSentMessage;

  /// No description provided for @otpSentMessageForgot.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent you a 5-digit verification code via SMS. Please enter it to continue and reset your password.'**
  String get otpSentMessageForgot;

  /// No description provided for @otpSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'Code sent successfully'**
  String get otpSentSuccess;

  /// No description provided for @sendOtpButton.
  ///
  /// In en, this message translates to:
  /// **'Send Verification Code'**
  String get sendOtpButton;

  /// No description provided for @enterPhoneHint.
  ///
  /// In en, this message translates to:
  /// **'Please enter the phone number associated with your account so we can send you a verification code via SMS.'**
  String get enterPhoneHint;

  /// No description provided for @forgotPasswordPrompt.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?\nNo worries, we\'re here to help.'**
  String get forgotPasswordPrompt;

  /// No description provided for @otpEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Please enter the verification code.'**
  String get otpEmptyError;

  /// No description provided for @otpLengthError.
  ///
  /// In en, this message translates to:
  /// **'The code must be 5 digits.'**
  String get otpLengthError;

  /// No description provided for @tapToChange.
  ///
  /// In en, this message translates to:
  /// **'Tap here to change'**
  String get tapToChange;

  /// No description provided for @enteredWrongNumber.
  ///
  /// In en, this message translates to:
  /// **'Entered a wrong number?'**
  String get enteredWrongNumber;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @didNotReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get didNotReceiveCode;

  /// No description provided for @resendCountdown.
  ///
  /// In en, this message translates to:
  /// **'Resend in 00:{seconds}'**
  String resendCountdown(Object seconds);

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmail;

  /// No description provided for @congratsTitle.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You have successfully created your account'**
  String get congratsTitle;

  /// No description provided for @congratsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Your first step towards comprehensive healthcare starts now'**
  String get congratsSubtitle;

  /// No description provided for @congratsLoadingText.
  ///
  /// In en, this message translates to:
  /// **'We\'re setting everything up for you now...'**
  String get congratsLoadingText;

  /// No description provided for @medicalInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Your health matters to us'**
  String get medicalInfoTitle;

  /// No description provided for @medicalInfoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please provide us with your medical information.'**
  String get medicalInfoSubtitle;

  /// No description provided for @chronicDiseasesHint.
  ///
  /// In en, this message translates to:
  /// **'Chronic diseases'**
  String get chronicDiseasesHint;

  /// No description provided for @previousSurgeriesHint.
  ///
  /// In en, this message translates to:
  /// **'Previous surgeries'**
  String get previousSurgeriesHint;

  /// No description provided for @allergiesHint.
  ///
  /// In en, this message translates to:
  /// **'Allergies'**
  String get allergiesHint;

  /// No description provided for @regularMedicationsHint.
  ///
  /// In en, this message translates to:
  /// **'Regular medications'**
  String get regularMedicationsHint;

  /// No description provided for @bloodTypeTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your blood type'**
  String get bloodTypeTitle;

  /// No description provided for @profileInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'We want to know you better'**
  String get profileInfoTitle;

  /// No description provided for @profileInfoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Please complete your personal information.'**
  String get profileInfoSubtitle;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailHint;

  /// No description provided for @emailRequiredError.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get emailRequiredError;

  /// No description provided for @emailInvalidError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get emailInvalidError;

  /// No description provided for @genderHint.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get genderHint;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @genderRequiredError.
  ///
  /// In en, this message translates to:
  /// **'Please select gender'**
  String get genderRequiredError;

  /// No description provided for @birthDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get birthDateLabel;

  /// No description provided for @currentJobHint.
  ///
  /// In en, this message translates to:
  /// **'Current Job'**
  String get currentJobHint;

  /// No description provided for @jobRequiredError.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get jobRequiredError;

  /// No description provided for @nextButton.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get nextButton;

  /// No description provided for @locationTitle.
  ///
  /// In en, this message translates to:
  /// **'Let\'s get closer to you'**
  String get locationTitle;

  /// No description provided for @locationSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your location and mark it on the map.'**
  String get locationSubtitle;

  /// No description provided for @currentLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Your current location'**
  String get currentLocationHint;

  /// No description provided for @locationDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your location or use the map to pinpoint your location accurately'**
  String get locationDescription;

  /// No description provided for @mapInstructions.
  ///
  /// In en, this message translates to:
  /// **'Move the map or use current location to pinpoint your location accurately'**
  String get mapInstructions;

  /// No description provided for @startNowButton.
  ///
  /// In en, this message translates to:
  /// **'Start Now'**
  String get startNowButton;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backButton;

  /// No description provided for @uploadPhotoTitle.
  ///
  /// In en, this message translates to:
  /// **'Please upload your photo.'**
  String get uploadPhotoTitle;

  /// No description provided for @uploadPhotoDescription.
  ///
  /// In en, this message translates to:
  /// **'It\'s preferred that the photo be clear \n and recent, showing the face clearly.'**
  String get uploadPhotoDescription;

  /// No description provided for @resendOtpSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'OTP sent successfully'**
  String get resendOtpSuccessTitle;

  /// No description provided for @resendOtpSuccess.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a 5-digit verification code to your phone number. Please enter it to complete the registration.'**
  String get resendOtpSuccess;

  /// No description provided for @otpVerifiedSuccessfullyTitle.
  ///
  /// In en, this message translates to:
  /// **'OTP verified successfully'**
  String get otpVerifiedSuccessfullyTitle;

  /// No description provided for @otpVerifiedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Your phone number has been verified successfully.'**
  String get otpVerifiedSuccessfully;

  /// No description provided for @invalidOtpCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid OTP code'**
  String get invalidOtpCodeTitle;

  /// No description provided for @invalidOtpCode.
  ///
  /// In en, this message translates to:
  /// **'The verification code you entered is incorrect. Please try again.'**
  String get invalidOtpCode;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred. Please try again later.'**
  String get errorUnknown;

  /// No description provided for @errorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials. Please try again.'**
  String get errorInvalidCredentials;

  /// No description provided for @errorPhoneNotFound.
  ///
  /// In en, this message translates to:
  /// **'Phone number not found. Please try again.'**
  String get errorPhoneNotFound;

  /// No description provided for @errorPhoneExists.
  ///
  /// In en, this message translates to:
  /// **'Phone number already exists. Please try again.'**
  String get errorPhoneExists;

  /// No description provided for @errorPhoneInvalid.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number. Please try again.'**
  String get errorPhoneInvalid;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your internet connection and try again.'**
  String get errorNetwork;

  /// No description provided for @errorServer.
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later.'**
  String get errorServer;

  /// No description provided for @errorValidation.
  ///
  /// In en, this message translates to:
  /// **'Validation error. Please check your input and try again.'**
  String get errorValidation;

  /// No description provided for @errorPhoneNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Phone number not verified. Please verify your phone number.'**
  String get errorPhoneNotVerified;

  /// No description provided for @operationFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Operation failed'**
  String get operationFailedTitle;

  /// No description provided for @operationFailed.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while performing the operation. Please try again.'**
  String get operationFailed;

  /// No description provided for @operationSuccessfulTitle.
  ///
  /// In en, this message translates to:
  /// **'Operation successful'**
  String get operationSuccessfulTitle;

  /// No description provided for @login_success_message.
  ///
  /// In en, this message translates to:
  /// **'You have successfully logged in! Welcome back'**
  String get login_success_message;

  /// No description provided for @changePasswordSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your password has been changed successfully.'**
  String get changePasswordSuccess;

  /// No description provided for @changePasswordFailure.
  ///
  /// In en, this message translates to:
  /// **'Failed to change password. Please try again.'**
  String get changePasswordFailure;

  /// No description provided for @errorInvalidCredentialsTitle.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get errorInvalidCredentialsTitle;

  /// No description provided for @signUpFailureTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign up failed'**
  String get signUpFailureTitle;

  /// No description provided for @signUpFailure.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while signing up. Please try again.'**
  String get signUpFailure;

  /// No description provided for @accountCreatedSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully'**
  String get accountCreatedSuccess;

  /// No description provided for @accountCreatedSuccessSubtitle.
  ///
  /// In en, this message translates to:
  /// **'You can now sign in to your account.'**
  String get accountCreatedSuccessSubtitle;

  /// No description provided for @resendOtpFailedTitle.
  ///
  /// In en, this message translates to:
  /// **'Failed to resend OTP'**
  String get resendOtpFailedTitle;

  /// No description provided for @resendOtpFailed.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while resending the OTP. Please try again.'**
  String get resendOtpFailed;

  /// No description provided for @browse_specialties_and_book.
  ///
  /// In en, this message translates to:
  /// **'Browse various specialties, rate doctors, and book appointments with ease.'**
  String get browse_specialties_and_book;

  /// No description provided for @explore_and_choose_doctor.
  ///
  /// In en, this message translates to:
  /// **'Explore doctors and choose the one that suits you best.'**
  String get explore_and_choose_doctor;

  /// No description provided for @findRightDoctor.
  ///
  /// In en, this message translates to:
  /// **'Find the right doctor for you'**
  String get findRightDoctor;

  /// No description provided for @searchHistory.
  ///
  /// In en, this message translates to:
  /// **'Search history'**
  String get searchHistory;

  /// No description provided for @clearSearchHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear search history'**
  String get clearSearchHistory;

  /// No description provided for @undefined.
  ///
  /// In en, this message translates to:
  /// **'Undefined'**
  String get undefined;

  /// No description provided for @experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rate;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @descending.
  ///
  /// In en, this message translates to:
  /// **'Descending'**
  String get descending;

  /// No description provided for @ascending.
  ///
  /// In en, this message translates to:
  /// **'Ascending'**
  String get ascending;

  /// No description provided for @registeredLocation.
  ///
  /// In en, this message translates to:
  /// **'Registered Location'**
  String get registeredLocation;

  /// No description provided for @sortBy.
  ///
  /// In en, this message translates to:
  /// **'Sort By'**
  String get sortBy;

  /// No description provided for @sortType.
  ///
  /// In en, this message translates to:
  /// **'Sort Type'**
  String get sortType;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @locate.
  ///
  /// In en, this message translates to:
  /// **'Locate'**
  String get locate;

  /// No description provided for @distanceKm.
  ///
  /// In en, this message translates to:
  /// **'Distance (km)'**
  String get distanceKm;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get km;

  /// No description provided for @m.
  ///
  /// In en, this message translates to:
  /// **'m'**
  String get m;

  /// No description provided for @filterSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Filter by Specialty'**
  String get filterSpecialty;

  /// No description provided for @filterGender.
  ///
  /// In en, this message translates to:
  /// **'Filter by Gender'**
  String get filterGender;

  /// No description provided for @location_services_disabled.
  ///
  /// In en, this message translates to:
  /// **'Location services are disabled. Please enable them to continue.'**
  String get location_services_disabled;

  /// No description provided for @location_permission_denied.
  ///
  /// In en, this message translates to:
  /// **'Location permission was denied.'**
  String get location_permission_denied;

  /// No description provided for @location_permission_denied_forever.
  ///
  /// In en, this message translates to:
  /// **'Location permission was permanently denied. Please enable it from the app settings.'**
  String get location_permission_denied_forever;

  /// No description provided for @permissions_error_title.
  ///
  /// In en, this message translates to:
  /// **'Permissions Error'**
  String get permissions_error_title;

  /// No description provided for @authentication_failed.
  ///
  /// In en, this message translates to:
  /// **'Authentication failed'**
  String get authentication_failed;

  /// No description provided for @reviews.
  ///
  /// In en, this message translates to:
  /// **'reviews'**
  String get reviews;

  /// No description provided for @server_error.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again later'**
  String get server_error;

  /// No description provided for @no_doctor_found.
  ///
  /// In en, this message translates to:
  /// **'We couldnt find any doctor matching your search. Try different keywords or check your spelling'**
  String get no_doctor_found;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
