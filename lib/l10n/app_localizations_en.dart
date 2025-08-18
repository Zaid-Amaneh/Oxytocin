// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get oxytocin => 'Oxytocin';

  @override
  String get findPerfectDoctor => 'Find Your Perfect Doctor';

  @override
  String get findPerfectDoctorDes =>
      'Browse trusted doctors\' profiles and choose the one that suits your needs with confidence and ease.';

  @override
  String get medicalRecordInYourHand => 'Your Medical Record in Your Hand';

  @override
  String get medicalRecordInYourHandDes =>
      'Track your health history and medical records anytime, securely.';

  @override
  String get yourPrivacyProtected => 'Your Privacy is Always Protected';

  @override
  String get yourPrivacyProtectedDes =>
      'All your health information is encrypted and secure. Your privacy is our priority.';

  @override
  String get next => 'Next';

  @override
  String get skip => 'Skip';

  @override
  String get startNow => 'Start Now';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signIn => 'Sign In';

  @override
  String get password => 'Password';

  @override
  String get phoneNumber => 'Phone Number';

  @override
  String get pleaseEnterValidNumber => 'Please enter a valid number';

  @override
  String get passwordatleast8characterslong =>
      'Password must be at least 8 characters long';

  @override
  String get passwordisrequired => 'Password is required';

  @override
  String get passwordincludeleastonelowercaseletter =>
      'Password must include at least one lowercase letter';

  @override
  String get passwordincludeleastoneuppercaseletter =>
      'Password must include at least one uppercase letter';

  @override
  String get passwordmustincludeatleastonenumber =>
      'Password must include at least one number';

  @override
  String get passwordmustleastonespecialcharacter =>
      'Password must include at least one special character';

  @override
  String get passwordistoocommon =>
      'Password is too common. Please choose a more secure one';

  @override
  String get passwordshouldnotcontainyourusername =>
      'Password should not contain your username';

  @override
  String get passwordshouldnotcontainpartsofyouremail =>
      'Password should not contain parts of your email';

  @override
  String get forgotyourpassword => 'Forgot your password?';

  @override
  String get rememberme => 'Remember me';

  @override
  String get thisfieldisrequired => 'This field is required';

  @override
  String get confirmpassword => 'Confirm password';

  @override
  String get lastname => 'Last name';

  @override
  String get username => 'User name';

  @override
  String get atleastletters => 'At least 3 letters';

  @override
  String get passwordmustnotcontainyourorphonenumber =>
      'The password must not contain your name or phone number.';

  @override
  String get thepasswordsdonotmatch => 'The passwords do not match';

  @override
  String get changePasswordTitle => 'Change Password';

  @override
  String get changePasswordSubtitle =>
      'You can now set a new password for your account. Make sure to choose a strong and memorable one.';

  @override
  String get newPasswordSlogan => 'New password\nnew beginning';

  @override
  String get otpSentMessage =>
      'We\'ve sent a 5-digit verification code to your phone number. Please enter it to complete the registration.';

  @override
  String get otpSentMessageForgot =>
      'We\'ve sent you a 5-digit verification code via SMS. Please enter it to continue and reset your password.';

  @override
  String get otpSentSuccess => 'Code sent successfully';

  @override
  String get sendOtpButton => 'Send Verification Code';

  @override
  String get enterPhoneHint =>
      'Please enter the phone number associated with your account so we can send you a verification code via SMS.';

  @override
  String get forgotPasswordPrompt =>
      'Forgot your password?\nNo worries, we\'re here to help.';

  @override
  String get otpEmptyError => 'Please enter the verification code.';

  @override
  String get otpLengthError => 'The code must be 5 digits.';

  @override
  String get tapToChange => 'Tap here to change';

  @override
  String get enteredWrongNumber => 'Entered a wrong number?';

  @override
  String get resend => 'Resend';

  @override
  String get didNotReceiveCode => 'Didn\'t receive the code?';

  @override
  String resendCountdown(Object seconds) {
    return 'Resend in 00:$seconds';
  }

  @override
  String get invalidEmail => 'Please enter a valid email address';

  @override
  String get congratsTitle =>
      'Congratulations! You have successfully created your account';

  @override
  String get congratsSubtitle =>
      'Your first step towards comprehensive healthcare starts now';

  @override
  String get congratsLoadingText =>
      'We\'re setting everything up for you now...';

  @override
  String get medicalInfoTitle => 'Your health matters to us';

  @override
  String get medicalInfoSubtitle =>
      'Please provide us with your medical information.';

  @override
  String get chronicDiseasesHint => 'Chronic diseases';

  @override
  String get previousSurgeriesHint => 'Previous surgeries';

  @override
  String get allergiesHint => 'Allergies';

  @override
  String get regularMedicationsHint => 'Regular medications';

  @override
  String get bloodTypeTitle => 'Choose your blood type';

  @override
  String get profileInfoTitle => 'We want to know you better';

  @override
  String get profileInfoSubtitle =>
      'Please complete your personal information.';

  @override
  String get emailHint => 'Email';

  @override
  String get emailRequiredError => 'This field is required';

  @override
  String get emailInvalidError => 'Please enter a valid email';

  @override
  String get genderHint => 'Gender';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get genderRequiredError => 'Please select gender';

  @override
  String get birthDateLabel => 'Date of Birth';

  @override
  String get currentJobHint => 'Current Job';

  @override
  String get jobRequiredError => 'This field is required';

  @override
  String get nextButton => 'Next';

  @override
  String get locationTitle => 'Let\'s get closer to you';

  @override
  String get locationSubtitle => 'Enter your location and mark it on the map.';

  @override
  String get currentLocationHint => 'Your current location';

  @override
  String get locationDescription =>
      'Enter your location or use the map to pinpoint your location accurately';

  @override
  String get mapInstructions =>
      'Move the map or use current location to pinpoint your location accurately';

  @override
  String get startNowButton => 'Start Now';

  @override
  String get backButton => 'Back';

  @override
  String get uploadPhotoTitle => 'Please upload your photo.';

  @override
  String get uploadPhotoDescription =>
      'It\'s preferred that the photo be clear \n and recent, showing the face clearly.';

  @override
  String get resendOtpSuccessTitle => 'OTP sent successfully';

  @override
  String get resendOtpSuccess =>
      'We\'ve sent a 5-digit verification code to your phone number. Please enter it to complete the registration.';

  @override
  String get otpVerifiedSuccessfullyTitle => 'OTP verified successfully';

  @override
  String get otpVerifiedSuccessfully =>
      'Your phone number has been verified successfully.';

  @override
  String get invalidOtpCodeTitle => 'Invalid OTP code';

  @override
  String get invalidOtpCode =>
      'The verification code you entered is incorrect. Please try again.';

  @override
  String get errorUnknown =>
      'An unknown error occurred. Please try again later.';

  @override
  String get errorInvalidCredentials =>
      'Invalid credentials. Please try again.';

  @override
  String get errorPhoneNotFound => 'Phone number not found. Please try again.';

  @override
  String get errorPhoneExists =>
      'Phone number already exists. Please try again.';

  @override
  String get errorPhoneInvalid => 'Invalid phone number. Please try again.';

  @override
  String get errorNetwork =>
      'Network error. Please check your internet connection and try again.';

  @override
  String get errorServer => 'Server error. Please try again later.';

  @override
  String get errorValidation =>
      'Validation error. Please check your input and try again.';

  @override
  String get errorPhoneNotVerified =>
      'Phone number not verified. Please verify your phone number.';

  @override
  String get operationFailedTitle => 'Operation failed';

  @override
  String get operationFailed =>
      'An error occurred while performing the operation. Please try again.';

  @override
  String get operationSuccessfulTitle => 'Operation successful';

  @override
  String get login_success_message =>
      'You have successfully logged in! Welcome back';

  @override
  String get changePasswordSuccess =>
      'Your password has been changed successfully.';

  @override
  String get changePasswordFailure =>
      'Failed to change password. Please try again.';

  @override
  String get errorInvalidCredentialsTitle => 'Invalid credentials';

  @override
  String get signUpFailureTitle => 'Sign up failed';

  @override
  String get signUpFailure =>
      'An error occurred while signing up. Please try again.';

  @override
  String get accountCreatedSuccess => 'Account created successfully';

  @override
  String get accountCreatedSuccessSubtitle =>
      'You can now sign in to your account.';

  @override
  String get resendOtpFailedTitle => 'Failed to resend OTP';

  @override
  String get resendOtpFailed =>
      'An error occurred while resending the OTP. Please try again.';

  @override
  String get browse_specialties_and_book =>
      'Browse various specialties, rate doctors, and book appointments with ease.';

  @override
  String get explore_and_choose_doctor =>
      'Explore doctors and choose the one that suits you best.';

  @override
  String get findRightDoctor => 'Find the right doctor for you';

  @override
  String get searchHistory => 'Search history';

  @override
  String get clearSearchHistory => 'Clear search history';

  @override
  String get undefined => 'Undefined';

  @override
  String get experience => 'Experience';

  @override
  String get rate => 'Rating';

  @override
  String get distance => 'Distance';

  @override
  String get descending => 'Descending';

  @override
  String get ascending => 'Ascending';

  @override
  String get registeredLocation => 'Registered Location';

  @override
  String get sortBy => 'Sort By';

  @override
  String get sortType => 'Sort Type';

  @override
  String get apply => 'Apply';

  @override
  String get locate => 'Locate';

  @override
  String get distanceKm => 'Distance (km)';

  @override
  String get km => 'km';

  @override
  String get m => 'm';

  @override
  String get filterSpecialty => 'Filter by Specialty';

  @override
  String get filterGender => 'Filter by Gender';

  @override
  String get location_services_disabled =>
      'Location services are disabled. Please enable them to continue.';

  @override
  String get location_permission_denied => 'Location permission was denied.';

  @override
  String get location_permission_denied_forever =>
      'Location permission was permanently denied. Please enable it from the app settings.';

  @override
  String get permissions_error_title => 'Permissions Error';

  @override
  String get authentication_failed => 'Authentication failed';

  @override
  String get reviews => 'reviews';

  @override
  String get server_error =>
      'An unexpected error occurred. Please try again later';

  @override
  String get no_doctor_found =>
      'We couldnt find any doctor matching your search. Try different keywords or check your spelling';

  @override
  String get profile => 'profile';

  @override
  String get d => 'D';

  @override
  String get clinicLocation => 'Clinic location';

  @override
  String get easilyLocateClinic =>
      'Easily locate the clinic, and find your way there';

  @override
  String get oneClick => 'With one click.';

  @override
  String get clinicPhotos => 'Clinic photos';

  @override
  String get noClinicImage => 'Sorry, no photos are available for this clinic.';

  @override
  String get clinicEvaluation => 'Overall Clinic Evaluation';

  @override
  String get realPastPatients => 'Real reviews from past patients';

  @override
  String get viewMore => 'View more';

  @override
  String get about => 'About';

  @override
  String get placeStudy => 'Place of study';

  @override
  String get aboutDoctor => 'About the doctor';

  @override
  String get show_all_days => 'Show all days of the month';

  @override
  String get select_booking_time => 'Select booking time';

  @override
  String get book_now => 'Book now';

  @override
  String get available => 'Available';

  @override
  String remainingAppointmentsMessage(Object remainingCount) {
    return '$remainingCount appointments\nstill available for today';
  }

  @override
  String get noAppointmentsMessage => 'No appointments\navailable';

  @override
  String get noAppointments => 'No appointments';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get am => 'AM';

  @override
  String get pm => 'PM';

  @override
  String get error => 'Something went wrong';

  @override
  String get locationError => 'An error occurred while detecting the location';

  @override
  String get routeNotFound => 'Route not found';

  @override
  String get locationTimeout => 'Location request timed out';

  @override
  String get quotaExceeded => 'Quota exceeded';

  @override
  String get apiKeyError => 'API key error';

  @override
  String get routeError => 'An error occurred while fetching the route';

  @override
  String get noRouteFound => 'No route found';

  @override
  String get yourLocation => 'Your location';

  @override
  String get loadingRoute => 'Loading route...';

  @override
  String get errorOccurred => 'Sorry, an error occurred. Please try again';

  @override
  String get retry => 'Retry';
}
