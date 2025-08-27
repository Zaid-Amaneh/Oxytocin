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

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'profile'**
  String get profile;

  /// No description provided for @d.
  ///
  /// In en, this message translates to:
  /// **'D'**
  String get d;

  /// No description provided for @clinicLocation.
  ///
  /// In en, this message translates to:
  /// **'Clinic location'**
  String get clinicLocation;

  /// No description provided for @easilyLocateClinic.
  ///
  /// In en, this message translates to:
  /// **'Easily locate the clinic, and find your way there'**
  String get easilyLocateClinic;

  /// No description provided for @oneClick.
  ///
  /// In en, this message translates to:
  /// **'With one click.'**
  String get oneClick;

  /// No description provided for @clinicPhotos.
  ///
  /// In en, this message translates to:
  /// **'Clinic photos'**
  String get clinicPhotos;

  /// No description provided for @noClinicImage.
  ///
  /// In en, this message translates to:
  /// **'Sorry, no photos are available for this clinic.'**
  String get noClinicImage;

  /// No description provided for @clinicEvaluation.
  ///
  /// In en, this message translates to:
  /// **'Overall Clinic Evaluation'**
  String get clinicEvaluation;

  /// No description provided for @realPastPatients.
  ///
  /// In en, this message translates to:
  /// **'Real reviews from past patients'**
  String get realPastPatients;

  /// No description provided for @viewMore.
  ///
  /// In en, this message translates to:
  /// **'View more'**
  String get viewMore;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @placeStudy.
  ///
  /// In en, this message translates to:
  /// **'Place of study'**
  String get placeStudy;

  /// No description provided for @aboutDoctor.
  ///
  /// In en, this message translates to:
  /// **'About the doctor'**
  String get aboutDoctor;

  /// No description provided for @show_all_days.
  ///
  /// In en, this message translates to:
  /// **'Show all days of the month'**
  String get show_all_days;

  /// No description provided for @select_booking_time.
  ///
  /// In en, this message translates to:
  /// **'Select booking time'**
  String get select_booking_time;

  /// No description provided for @book_now.
  ///
  /// In en, this message translates to:
  /// **'Book now'**
  String get book_now;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @remainingAppointmentsMessage.
  ///
  /// In en, this message translates to:
  /// **'{remainingCount} appointments\nstill available for today'**
  String remainingAppointmentsMessage(Object remainingCount);

  /// No description provided for @noAppointmentsMessage.
  ///
  /// In en, this message translates to:
  /// **'No appointments\navailable'**
  String get noAppointmentsMessage;

  /// No description provided for @noAppointments.
  ///
  /// In en, this message translates to:
  /// **'No appointments'**
  String get noAppointments;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @am.
  ///
  /// In en, this message translates to:
  /// **'AM'**
  String get am;

  /// No description provided for @pm.
  ///
  /// In en, this message translates to:
  /// **'PM'**
  String get pm;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get error;

  /// No description provided for @locationError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while detecting the location'**
  String get locationError;

  /// No description provided for @routeNotFound.
  ///
  /// In en, this message translates to:
  /// **'Route not found'**
  String get routeNotFound;

  /// No description provided for @locationTimeout.
  ///
  /// In en, this message translates to:
  /// **'Location request timed out'**
  String get locationTimeout;

  /// No description provided for @quotaExceeded.
  ///
  /// In en, this message translates to:
  /// **'Quota exceeded'**
  String get quotaExceeded;

  /// No description provided for @apiKeyError.
  ///
  /// In en, this message translates to:
  /// **'API key error'**
  String get apiKeyError;

  /// No description provided for @routeError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while fetching the route'**
  String get routeError;

  /// No description provided for @noRouteFound.
  ///
  /// In en, this message translates to:
  /// **'No route found'**
  String get noRouteFound;

  /// No description provided for @yourLocation.
  ///
  /// In en, this message translates to:
  /// **'Your location'**
  String get yourLocation;

  /// No description provided for @loadingRoute.
  ///
  /// In en, this message translates to:
  /// **'Loading route...'**
  String get loadingRoute;

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Sorry, an error occurred. Please try again'**
  String get errorOccurred;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @subspecialties.
  ///
  /// In en, this message translates to:
  /// **'Subspecialties'**
  String get subspecialties;

  /// No description provided for @noCommentDoctor.
  ///
  /// In en, this message translates to:
  /// **'No one has left a comment yet. Book now and be the first to review this doctor!'**
  String get noCommentDoctor;

  /// No description provided for @doctor_added_success.
  ///
  /// In en, this message translates to:
  /// **'Doctor added to favorites successfully'**
  String get doctor_added_success;

  /// No description provided for @doctor_added_failure_network.
  ///
  /// In en, this message translates to:
  /// **'Failed to add doctor to favorites due to connection issues'**
  String get doctor_added_failure_network;

  /// No description provided for @doctor_added_failure_auth.
  ///
  /// In en, this message translates to:
  /// **'You cannot add the doctor to favorites because you are not logged in'**
  String get doctor_added_failure_auth;

  /// No description provided for @failure_title.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get failure_title;

  /// No description provided for @success_title.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success_title;

  /// No description provided for @doctor_removed_success.
  ///
  /// In en, this message translates to:
  /// **'Doctor removed from favorites successfully'**
  String get doctor_removed_success;

  /// No description provided for @view_all_reservations.
  ///
  /// In en, this message translates to:
  /// **'View All Reservations'**
  String get view_all_reservations;

  /// No description provided for @near_appointments.
  ///
  /// In en, this message translates to:
  /// **'Nearby Appointments'**
  String get near_appointments;

  /// No description provided for @appointments_expired.
  ///
  /// In en, this message translates to:
  /// **'Nearby appointments have ended. You can press \"View all reservations\" to choose the date and month that suits you.'**
  String get appointments_expired;

  /// No description provided for @appointments_calendar.
  ///
  /// In en, this message translates to:
  /// **'Appointments Calendar'**
  String get appointments_calendar;

  /// No description provided for @choose_month.
  ///
  /// In en, this message translates to:
  /// **'Choose Month'**
  String get choose_month;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @january.
  ///
  /// In en, this message translates to:
  /// **'January'**
  String get january;

  /// No description provided for @february.
  ///
  /// In en, this message translates to:
  /// **'February'**
  String get february;

  /// No description provided for @march.
  ///
  /// In en, this message translates to:
  /// **'March'**
  String get march;

  /// No description provided for @april.
  ///
  /// In en, this message translates to:
  /// **'April'**
  String get april;

  /// No description provided for @may.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get may;

  /// No description provided for @june.
  ///
  /// In en, this message translates to:
  /// **'June'**
  String get june;

  /// No description provided for @july.
  ///
  /// In en, this message translates to:
  /// **'July'**
  String get july;

  /// No description provided for @august.
  ///
  /// In en, this message translates to:
  /// **'August'**
  String get august;

  /// No description provided for @september.
  ///
  /// In en, this message translates to:
  /// **'September'**
  String get september;

  /// No description provided for @october.
  ///
  /// In en, this message translates to:
  /// **'October'**
  String get october;

  /// No description provided for @november.
  ///
  /// In en, this message translates to:
  /// **'November'**
  String get november;

  /// No description provided for @december.
  ///
  /// In en, this message translates to:
  /// **'December'**
  String get december;

  /// No description provided for @no_appointments_available.
  ///
  /// In en, this message translates to:
  /// **'No appointments available'**
  String get no_appointments_available;

  /// No description provided for @no_appointments_description.
  ///
  /// In en, this message translates to:
  /// **'No appointments found for this month'**
  String get no_appointments_description;

  /// No description provided for @error_loading_appointments.
  ///
  /// In en, this message translates to:
  /// **'Error loading appointments'**
  String get error_loading_appointments;

  /// No description provided for @please_try_again.
  ///
  /// In en, this message translates to:
  /// **'Please try again'**
  String get please_try_again;

  /// No description provided for @available_appointments.
  ///
  /// In en, this message translates to:
  /// **'Available Appointments'**
  String get available_appointments;

  /// No description provided for @appointment.
  ///
  /// In en, this message translates to:
  /// **'appointment'**
  String get appointment;

  /// No description provided for @loadingAppointments.
  ///
  /// In en, this message translates to:
  /// **'Loading appointments...'**
  String get loadingAppointments;

  /// No description provided for @availableDays.
  ///
  /// In en, this message translates to:
  /// **'Available Days'**
  String get availableDays;

  /// No description provided for @day.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get day;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @appointmentInstructions.
  ///
  /// In en, this message translates to:
  /// **'You can write anything you want the doctor to know before the appointment, such as symptoms you feel, when your condition started, or any details you think are important.'**
  String get appointmentInstructions;

  /// No description provided for @tellDoctorHowYouFeel.
  ///
  /// In en, this message translates to:
  /// **'Tell the doctor how you feel'**
  String get tellDoctorHowYouFeel;

  /// No description provided for @confirmBooking.
  ///
  /// In en, this message translates to:
  /// **'Confirm Booking'**
  String get confirmBooking;

  /// No description provided for @bookingSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your appointment has been successfully booked!'**
  String get bookingSuccess;

  /// No description provided for @thankYouMessage.
  ///
  /// In en, this message translates to:
  /// **'Thank you for using our platform. We wish you continued health and wellness!'**
  String get thankYouMessage;

  /// No description provided for @attachFiles.
  ///
  /// In en, this message translates to:
  /// **'You can attach any files you want the doctor to review before the appointment'**
  String get attachFiles;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @availableAppointments.
  ///
  /// In en, this message translates to:
  /// **'These are the available appointments for {dayDate}. Please select a time that suits you.'**
  String availableAppointments(Object dayDate);

  /// No description provided for @chooseTime.
  ///
  /// In en, this message translates to:
  /// **'Choose a suitable time'**
  String get chooseTime;

  /// No description provided for @appointment_success.
  ///
  /// In en, this message translates to:
  /// **'Your appointment has been successfully booked!'**
  String get appointment_success;

  /// No description provided for @thank_you_message.
  ///
  /// In en, this message translates to:
  /// **'Thank you for using our platform. We wish you good health and wellness!'**
  String get thank_you_message;

  /// No description provided for @attach_files_hint.
  ///
  /// In en, this message translates to:
  /// **'You can attach any files you would like the doctor to review before the appointment'**
  String get attach_files_hint;

  /// No description provided for @doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor:'**
  String get doctor;

  /// No description provided for @specialization.
  ///
  /// In en, this message translates to:
  /// **'Specialization:'**
  String get specialization;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date:'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time:'**
  String get time;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location:'**
  String get location;

  /// No description provided for @add_file.
  ///
  /// In en, this message translates to:
  /// **'Add File'**
  String get add_file;

  /// No description provided for @back_to_home.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get back_to_home;

  /// No description provided for @appointment_confirmed.
  ///
  /// In en, this message translates to:
  /// **'Appointment confirmed'**
  String get appointment_confirmed;

  /// No description provided for @max_files_error.
  ///
  /// In en, this message translates to:
  /// **'You cannot upload more than {maxFiles} files'**
  String max_files_error(Object maxFiles);

  /// No description provided for @file_size_error.
  ///
  /// In en, this message translates to:
  /// **'The file {fileName} is larger than {maxFileSizeInMB} MB'**
  String file_size_error(Object fileName, Object maxFileSizeInMB);

  /// No description provided for @allowed_files_limit.
  ///
  /// In en, this message translates to:
  /// **'{allowedCount} files were added only. Maximum allowed is {maxFiles} files'**
  String allowed_files_limit(Object allowedCount, Object maxFiles);

  /// No description provided for @file_pick_error.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while picking files'**
  String get file_pick_error;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @tap_to_select_files.
  ///
  /// In en, this message translates to:
  /// **'Tap to select files'**
  String get tap_to_select_files;

  /// No description provided for @upload_hint.
  ///
  /// In en, this message translates to:
  /// **'You can upload up to {maxFiles} files, each up to {maxFileSizeInMB} MB'**
  String upload_hint(Object maxFileSizeInMB, Object maxFiles);

  /// No description provided for @supported_formats.
  ///
  /// In en, this message translates to:
  /// **'Supported formats: PDF, DOC, DOCX, TXT, JPG, PNG'**
  String get supported_formats;

  /// No description provided for @files_progress.
  ///
  /// In en, this message translates to:
  /// **'{selectedCount} of {maxFiles} files'**
  String files_progress(Object maxFiles, Object selectedCount);

  /// No description provided for @appointment_not_available.
  ///
  /// In en, this message translates to:
  /// **'Unfortunately, the appointment you tried to book is no longer available as it has been taken by another patient.'**
  String get appointment_not_available;

  /// No description provided for @files_uploaded_success.
  ///
  /// In en, this message translates to:
  /// **'Files uploaded successfully! Your doctor can now review them.'**
  String get files_uploaded_success;

  /// No description provided for @files_upload_error.
  ///
  /// In en, this message translates to:
  /// **'There was a problem uploading the files. Please try again.'**
  String get files_upload_error;

  /// No description provided for @invalid_uploaded_file.
  ///
  /// In en, this message translates to:
  /// **'One of the uploaded files is invalid or contains an issue. Please check your files and try again.'**
  String get invalid_uploaded_file;

  /// No description provided for @next_appointment_message.
  ///
  /// In en, this message translates to:
  /// **'Your next appointment is waiting for you. We wish you continued health and wellness.'**
  String get next_appointment_message;

  /// No description provided for @reservationCanceledSuccess.
  ///
  /// In en, this message translates to:
  /// **'You have successfully canceled this reservation.'**
  String get reservationCanceledSuccess;

  /// No description provided for @allReservations.
  ///
  /// In en, this message translates to:
  /// **'All Reservations'**
  String get allReservations;

  /// No description provided for @currentReservations.
  ///
  /// In en, this message translates to:
  /// **'Current Reservations'**
  String get currentReservations;

  /// No description provided for @pastReservations.
  ///
  /// In en, this message translates to:
  /// **'Past Reservations'**
  String get pastReservations;

  /// No description provided for @canceledReservations.
  ///
  /// In en, this message translates to:
  /// **'Canceled Reservations'**
  String get canceledReservations;

  /// No description provided for @rebook.
  ///
  /// In en, this message translates to:
  /// **'Rebook'**
  String get rebook;

  /// No description provided for @loginRequiredForCurrentReservations.
  ///
  /// In en, this message translates to:
  /// **'You cannot view current reservations because you are not logged in yet. Please log in to enjoy all the app features.'**
  String get loginRequiredForCurrentReservations;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @reschedule.
  ///
  /// In en, this message translates to:
  /// **'Reschedule'**
  String get reschedule;

  /// No description provided for @cancelReservation.
  ///
  /// In en, this message translates to:
  /// **'Cancel Reservation'**
  String get cancelReservation;

  /// No description provided for @sessionFeedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'How was your session? Rate your experience with us!'**
  String get sessionFeedbackTitle;

  /// No description provided for @sessionFeedbackSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share your feedback to help others.. What did you like or dislike?'**
  String get sessionFeedbackSubtitle;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @map.
  ///
  /// In en, this message translates to:
  /// **'Map'**
  String get map;

  /// No description provided for @rateDoctor.
  ///
  /// In en, this message translates to:
  /// **'Rate Doctor'**
  String get rateDoctor;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get details;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @callErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Sorry, we couldn\'t make the call'**
  String get callErrorTitle;

  /// No description provided for @callErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to open the call app. Please try again later or dial manually.'**
  String get callErrorMessage;

  /// No description provided for @missed_reservation.
  ///
  /// In en, this message translates to:
  /// **'You missed this reservation. We hope you can attend next time.'**
  String get missed_reservation;

  /// No description provided for @ratingFailed.
  ///
  /// In en, this message translates to:
  /// **'Your rating could not be submitted due to an error. Please try again later.'**
  String get ratingFailed;

  /// No description provided for @ratingSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your rating has been submitted successfully. Thank you!'**
  String get ratingSuccess;

  /// No description provided for @alreadyRatedOrCommented.
  ///
  /// In en, this message translates to:
  /// **'Rated'**
  String get alreadyRatedOrCommented;

  /// No description provided for @visitCompleted.
  ///
  /// In en, this message translates to:
  /// **'Your visit has been completed successfully. Wishing you good health and wellness!'**
  String get visitCompleted;

  /// No description provided for @noNotes.
  ///
  /// In en, this message translates to:
  /// **'No notes recorded'**
  String get noNotes;

  /// No description provided for @patientNotes.
  ///
  /// In en, this message translates to:
  /// **'Patient Notes'**
  String get patientNotes;

  /// No description provided for @appointmentInfo.
  ///
  /// In en, this message translates to:
  /// **'Appointment Information'**
  String get appointmentInfo;

  /// No description provided for @doctorName.
  ///
  /// In en, this message translates to:
  /// **'Doctor Name:'**
  String get doctorName;

  /// No description provided for @doctorInfo.
  ///
  /// In en, this message translates to:
  /// **'Doctor Information'**
  String get doctorInfo;

  /// No description provided for @appointmentDetails.
  ///
  /// In en, this message translates to:
  /// **'Appointment Details'**
  String get appointmentDetails;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address:'**
  String get address;

  /// No description provided for @clinicNumber.
  ///
  /// In en, this message translates to:
  /// **'Clinic Number:'**
  String get clinicNumber;

  /// No description provided for @queue.
  ///
  /// In en, this message translates to:
  /// **'Queue'**
  String get queue;

  /// No description provided for @cancellationSuccess.
  ///
  /// In en, this message translates to:
  /// **'The appointment has been cancelled successfully.'**
  String get cancellationSuccess;

  /// No description provided for @cancellationFailed.
  ///
  /// In en, this message translates to:
  /// **'The appointment could not be cancelled. Please try again later.'**
  String get cancellationFailed;

  /// No description provided for @updateBookingSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your booking has been updated successfully.'**
  String get updateBookingSuccess;

  /// No description provided for @updateBookingFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update your booking. Please try again later.'**
  String get updateBookingFailed;

  /// No description provided for @editUploadedFiles.
  ///
  /// In en, this message translates to:
  /// **'Edit Files'**
  String get editUploadedFiles;

  /// No description provided for @rebookingSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your booking has been successfully rescheduled after cancellation.'**
  String get rebookingSuccess;

  /// No description provided for @rebookingFailed.
  ///
  /// In en, this message translates to:
  /// **'Rebooking failed, the requested time slot is already taken.'**
  String get rebookingFailed;

  /// No description provided for @fileOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to load or open the file'**
  String get fileOpenFailed;

  /// No description provided for @fileLoadedNoViewer.
  ///
  /// In en, this message translates to:
  /// **'The file is loaded but no viewer is available to open it.'**
  String get fileLoadedNoViewer;

  /// No description provided for @manageAttachments.
  ///
  /// In en, this message translates to:
  /// **'Manage Attachments'**
  String get manageAttachments;

  /// No description provided for @attachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments;

  /// No description provided for @attachmentsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} of 5 files'**
  String attachmentsCount(Object count);

  /// No description provided for @uploading.
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get uploading;

  /// No description provided for @addFile.
  ///
  /// In en, this message translates to:
  /// **'Add File'**
  String get addFile;

  /// No description provided for @loadingFiles.
  ///
  /// In en, this message translates to:
  /// **'Loading files...'**
  String get loadingFiles;

  /// No description provided for @noAttachments.
  ///
  /// In en, this message translates to:
  /// **'No attachments available'**
  String get noAttachments;

  /// No description provided for @addFileHint.
  ///
  /// In en, this message translates to:
  /// **'Press the \'Add File\' button to upload your files'**
  String get addFileHint;

  /// No description provided for @deleteFile.
  ///
  /// In en, this message translates to:
  /// **'Delete File'**
  String get deleteFile;

  /// No description provided for @maxFilesError.
  ///
  /// In en, this message translates to:
  /// **'You cannot upload more than 5 files'**
  String get maxFilesError;

  /// No description provided for @uploadAlerts.
  ///
  /// In en, this message translates to:
  /// **'Upload Alerts'**
  String get uploadAlerts;

  /// No description provided for @fileSelectionError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while selecting files'**
  String get fileSelectionError;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @deleteConfirmationQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this file?'**
  String get deleteConfirmationQuestion;

  /// No description provided for @deleteConfirmation.
  ///
  /// In en, this message translates to:
  /// **'Delete Confirmation'**
  String get deleteConfirmation;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;
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
