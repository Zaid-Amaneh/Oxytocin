// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(seconds) => "Resend in 00:${seconds}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "Atleastletters":
            MessageLookupByLibrary.simpleMessage("At least 3 letters"),
        "Confirmpassword":
            MessageLookupByLibrary.simpleMessage("Confirm password"),
        "FindPerfectDoctor":
            MessageLookupByLibrary.simpleMessage("Find Your Perfect Doctor"),
        "FindPerfectDoctorDes": MessageLookupByLibrary.simpleMessage(
            "Browse trusted doctors\' profiles and choose the one that suits your needs with confidence and ease."),
        "Forgotyourpassword":
            MessageLookupByLibrary.simpleMessage("Forgot your password?"),
        "Lastname": MessageLookupByLibrary.simpleMessage("Last name"),
        "MedicalRecordInYourHand": MessageLookupByLibrary.simpleMessage(
            "Your Medical Record in Your Hand"),
        "MedicalRecordInYourHandDes": MessageLookupByLibrary.simpleMessage(
            "Track your health history and medical records anytime, securely."),
        "Next": MessageLookupByLibrary.simpleMessage("Next"),
        "Oxytocin": MessageLookupByLibrary.simpleMessage("Oxytocin"),
        "Password": MessageLookupByLibrary.simpleMessage("Password"),
        "Passwordatleast8characterslong": MessageLookupByLibrary.simpleMessage(
            "Password must be at least 8 characters long"),
        "Passwordincludeleastonelowercaseletter":
            MessageLookupByLibrary.simpleMessage(
                "Password must include at least one lowercase letter"),
        "Passwordincludeleastoneuppercaseletter":
            MessageLookupByLibrary.simpleMessage(
                "Password must include at least one uppercase letter"),
        "Passwordisrequired":
            MessageLookupByLibrary.simpleMessage("Password is required"),
        "Passwordistoocommon": MessageLookupByLibrary.simpleMessage(
            "Password is too common. Please choose a more secure one"),
        "Passwordmustincludeatleastonenumber":
            MessageLookupByLibrary.simpleMessage(
                "Password must include at least one number"),
        "Passwordmustleastonespecialcharacter":
            MessageLookupByLibrary.simpleMessage(
                "Password must include at least one special character"),
        "Passwordshouldnotcontainpartsofyouremail":
            MessageLookupByLibrary.simpleMessage(
                "Password should not contain parts of your email"),
        "Passwordshouldnotcontainyourusername":
            MessageLookupByLibrary.simpleMessage(
                "Password should not contain your username"),
        "PhoneNumber": MessageLookupByLibrary.simpleMessage("Phone Number"),
        "PleaseEnterValidNumber":
            MessageLookupByLibrary.simpleMessage("Please enter a valid number"),
        "Rememberme": MessageLookupByLibrary.simpleMessage("Remember me"),
        "SignIn": MessageLookupByLibrary.simpleMessage("Sign In"),
        "SignUp": MessageLookupByLibrary.simpleMessage("Sign Up"),
        "Skip": MessageLookupByLibrary.simpleMessage("Skip"),
        "StartNow": MessageLookupByLibrary.simpleMessage("Start Now"),
        "Thepasswordsdonotmatch":
            MessageLookupByLibrary.simpleMessage("The passwords do not match"),
        "Thisfieldisrequired":
            MessageLookupByLibrary.simpleMessage("This field is required"),
        "Username": MessageLookupByLibrary.simpleMessage("User name"),
        "YourPrivacyProtected": MessageLookupByLibrary.simpleMessage(
            "Your Privacy is Always Protected"),
        "YourPrivacyProtectedDes": MessageLookupByLibrary.simpleMessage(
            "All your health information is encrypted and secure. Your privacy is our priority."),
        "account_created_success": MessageLookupByLibrary.simpleMessage(
            "Congratulations! Your account has been created successfully."),
        "changePasswordSubtitle": MessageLookupByLibrary.simpleMessage(
            "You can now set a new password for your account. Make sure to choose a strong and memorable one."),
        "changePasswordTitle":
            MessageLookupByLibrary.simpleMessage("Change Password"),
        "didNotReceiveCode":
            MessageLookupByLibrary.simpleMessage("Didn\'t receive the code?"),
        "enterPhoneHint": MessageLookupByLibrary.simpleMessage(
            "Please enter the phone number associated with your account so we can send you a verification code via SMS."),
        "enteredWrongNumber":
            MessageLookupByLibrary.simpleMessage("Entered a wrong number?"),
        "error_invalid_credentials": MessageLookupByLibrary.simpleMessage(
            "Invalid phone number or password"),
        "error_invalid_credentials_title":
            MessageLookupByLibrary.simpleMessage("Sign-In Failed"),
        "error_network": MessageLookupByLibrary.simpleMessage(
            "Please check your internet connection."),
        "error_phone_exists": MessageLookupByLibrary.simpleMessage(
            "This phone number is already registered"),
        "error_phone_invalid":
            MessageLookupByLibrary.simpleMessage("Invalid phone number"),
        "error_server": MessageLookupByLibrary.simpleMessage(
            "A server error occurred. Please try again later."),
        "error_unknown": MessageLookupByLibrary.simpleMessage(
            "An unexpected error occurred."),
        "error_validation":
            MessageLookupByLibrary.simpleMessage("The input data is invalid."),
        "forgotPasswordPrompt": MessageLookupByLibrary.simpleMessage(
            "Forgot your password?\nNo worries, we\'re here to help."),
        "invalid_otp_code": MessageLookupByLibrary.simpleMessage(
            "Invalid or expired verification code. Please try again."),
        "invalid_otp_code_title":
            MessageLookupByLibrary.simpleMessage("Invalid Code"),
        "newPasswordSlogan":
            MessageLookupByLibrary.simpleMessage("New password\nnew beginning"),
        "operation_failed_title":
            MessageLookupByLibrary.simpleMessage("Operation Failed"),
        "operation_successful_title":
            MessageLookupByLibrary.simpleMessage("Operation Successful!"),
        "otpEmptyError": MessageLookupByLibrary.simpleMessage(
            "Please enter the verification code."),
        "otpLengthError":
            MessageLookupByLibrary.simpleMessage("The code must be 5 digits."),
        "otpSentMessage": MessageLookupByLibrary.simpleMessage(
            "We\'ve sent a 5-digit verification code to your phone number. Please enter it to complete the registration."),
        "otpSentMessageForgot": MessageLookupByLibrary.simpleMessage(
            "We’ve sent you a 5-digit verification code via SMS. Please enter it to continue and reset your password."),
        "otpSentSuccess":
            MessageLookupByLibrary.simpleMessage("Code sent successfully"),
        "otp_verified_successfully": MessageLookupByLibrary.simpleMessage(
            "The code has been verified successfully!"),
        "otp_verified_successfully_title":
            MessageLookupByLibrary.simpleMessage("Verified"),
        "passwordmustnotcontainyourorphonenumber":
            MessageLookupByLibrary.simpleMessage(
                "The password must not contain your name or phone number."),
        "resend": MessageLookupByLibrary.simpleMessage("Resend"),
        "resendCountdown": m0,
        "resend_otp_failed": MessageLookupByLibrary.simpleMessage(
            "Failed to resend the verification code. Please try again later."),
        "resend_otp_failed_title":
            MessageLookupByLibrary.simpleMessage("Resend Failed"),
        "resend_otp_success": MessageLookupByLibrary.simpleMessage(
            "Verification code was sent successfully. Please check your phone."),
        "resend_otp_success_title":
            MessageLookupByLibrary.simpleMessage("Code Sent"),
        "sendOtpButton":
            MessageLookupByLibrary.simpleMessage("Send Verification Code"),
        "sign_in_success_message":
            MessageLookupByLibrary.simpleMessage("Signed in successfully"),
        "sign_up_failure_title":
            MessageLookupByLibrary.simpleMessage("Sign-up Failed"),
        "tapToChange":
            MessageLookupByLibrary.simpleMessage("Tap here to change"),
        "unverified_phone": MessageLookupByLibrary.simpleMessage(
            "Phone number has not been verified yet. Please check the verification code sent to you."),
        "unverified_phone_title":
            MessageLookupByLibrary.simpleMessage("Verification Required")
      };
}
