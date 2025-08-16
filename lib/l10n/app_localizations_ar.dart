// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get oxytocin => 'أوكسيتوسين';

  @override
  String get findPerfectDoctor => 'اعثر على طبيبك المثالي';

  @override
  String get findPerfectDoctorDes =>
      'تصفّح ملفات الأطباء الموثوقين واختر من يناسب احتياجاتك بثقة وسهولة.';

  @override
  String get medicalRecordInYourHand => 'سجلك الطبي في متناولك';

  @override
  String get medicalRecordInYourHandDes =>
      'تابع تاريخك الصحي وملفاتك الطبية في أي وقت وبكل أمان.';

  @override
  String get yourPrivacyProtected => 'خصوصيتك محمية دائمًا';

  @override
  String get yourPrivacyProtectedDes =>
      'كل معلوماتك الصحية مشفّرة وآمنة,خصوصيتك أولويتنا.';

  @override
  String get next => 'التالي';

  @override
  String get skip => 'تخطي';

  @override
  String get startNow => 'ابدأ الآن';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get password => 'كلمة المرور';

  @override
  String get phoneNumber => 'رقم الهاتف';

  @override
  String get pleaseEnterValidNumber => 'الرجاء إدخال رقم صالح';

  @override
  String get passwordatleast8characterslong =>
      'يجب أن تكون كلمة المرور 8 أحرف على الأقل';

  @override
  String get passwordisrequired => 'كلمة المرور مطلوبة';

  @override
  String get passwordincludeleastonelowercaseletter =>
      'يجب أن تحتوي كلمة المرور على حرف صغير واحد على الأقل';

  @override
  String get passwordincludeleastoneuppercaseletter =>
      'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل';

  @override
  String get passwordmustincludeatleastonenumber =>
      'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل';

  @override
  String get passwordmustleastonespecialcharacter =>
      'يجب أن تحتوي كلمة المرور على رمز خاص واحد على الأقل';

  @override
  String get passwordistoocommon =>
      'كلمة المرور شائعة جدًا. الرجاء اختيار كلمة مرور أكثر أمانًا';

  @override
  String get passwordshouldnotcontainyourusername =>
      'يجب ألا تحتوي كلمة المرور على اسم المستخدم الخاص بك';

  @override
  String get passwordshouldnotcontainpartsofyouremail =>
      'يجب ألا تحتوي كلمة المرور على جزء من بريدك الإلكتروني';

  @override
  String get forgotyourpassword => 'هل نسيت كلمة المرور؟';

  @override
  String get rememberme => 'احفظ بيانات الدخول';

  @override
  String get thisfieldisrequired => 'هذه الخانة مطلوبه';

  @override
  String get confirmpassword => 'تأكيد كلمة المرور';

  @override
  String get lastname => 'إسم العائلة';

  @override
  String get username => 'إسم المستخدم';

  @override
  String get atleastletters => 'الاسم يجب أن لا يقل عن حرفين';

  @override
  String get passwordmustnotcontainyourorphonenumber =>
      'لا يجب أن تحتوي كلمة المرور على اسمك أو رقم الهاتف.';

  @override
  String get thepasswordsdonotmatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get changePasswordTitle => 'تغيير كلمة المرور';

  @override
  String get changePasswordSubtitle =>
      'الآن يمكنك تعيين كلمة مرور جديدة لحسابك. احرص على اختيار كلمة مرور قوية وسهلة التذكر.';

  @override
  String get newPasswordSlogan => 'كلمة مرور جديدة\nبداية جديدة';

  @override
  String get otpSentMessage =>
      'قد أرسلنا رمز تحقق مكونًا من 5 أرقام إلى رقم هاتفك الرجاء إدخاله لإكمال التسجيل';

  @override
  String get otpSentMessageForgot =>
      'أرسلنا إليك رمز تحقق مكوّنًا من 5 أرقام عبر رسالة نصية. الرجاء إدخاله للمتابعة وإعادة تعيين كلمة المرور';

  @override
  String get otpSentSuccess => 'تم إرسال الرمز بنجاح';

  @override
  String get sendOtpButton => 'إرسال رمز التحقق';

  @override
  String get enterPhoneHint =>
      'من فضلك أدخل رقم هاتفك المرتبط بحسابك لنتمكن من إرسال رمز التحقق إليك عبر رسالة نصية.';

  @override
  String get forgotPasswordPrompt =>
      'هل نسيت كلمة المرور؟\nلا بأس، نحن هنا لمساعدتك.';

  @override
  String get otpEmptyError => 'الرجاء إدخال رمز التحقق.';

  @override
  String get otpLengthError => 'يجب أن يتكون الرمز من 5 أرقام.';

  @override
  String get tapToChange => 'اضغط هنا لتغييره';

  @override
  String get enteredWrongNumber => 'أدخلت رقمًا خاطئًا؟';

  @override
  String get resend => 'أعد الإرسال';

  @override
  String get didNotReceiveCode => 'لم يصلك الرمز؟';

  @override
  String resendCountdown(Object seconds) {
    return 'إعادة الإرسال خلال 00:$seconds';
  }

  @override
  String get invalidEmail => 'الرجاء إدخال عنوان بريد إلكتروني صالح';

  @override
  String get congratsTitle => 'تهانينا! لقد أتممت إنشاء حسابك بنجاح';

  @override
  String get congratsSubtitle =>
      'خطوتك الأولى نحو عناية صحية متكاملة تبدأ الآن';

  @override
  String get congratsLoadingText => 'نقوم بإعداد كل شيء لك الآن...';

  @override
  String get medicalInfoTitle => 'صحتك تهمنا';

  @override
  String get medicalInfoSubtitle => 'نرجى تزويدنا بمعلوماتك الطبية.';

  @override
  String get chronicDiseasesHint => 'الأمراض المزمنة';

  @override
  String get previousSurgeriesHint => 'العمليات الجراحية السابقة';

  @override
  String get allergiesHint => 'الحساسية';

  @override
  String get regularMedicationsHint => 'الأدوية المستخدمة بانتظام';

  @override
  String get bloodTypeTitle => 'اختر نوع زمرة دمك';

  @override
  String get profileInfoTitle => 'نرغب بالتعرف عليك أكثر';

  @override
  String get profileInfoSubtitle => 'فضلًا أكمل بياناتك الشخصية.';

  @override
  String get emailHint => 'البريد الإلكتروني';

  @override
  String get emailRequiredError => 'هذا الحقل مطلوب';

  @override
  String get emailInvalidError => 'يرجى إدخال بريد إلكتروني صحيح';

  @override
  String get genderHint => 'الجنس';

  @override
  String get male => 'ذكر';

  @override
  String get female => 'أنثى';

  @override
  String get genderRequiredError => 'يرجى اختيار الجنس';

  @override
  String get birthDateLabel => 'تاريخ الميلاد';

  @override
  String get currentJobHint => 'الوظيفة الحالية';

  @override
  String get jobRequiredError => 'هذا الحقل مطلوب';

  @override
  String get nextButton => 'التالي';

  @override
  String get locationTitle => 'لنكن أقرب إليك';

  @override
  String get locationSubtitle => 'أدخل موقعك وحدده على الخريطة.';

  @override
  String get currentLocationHint => 'موقعك الحالي';

  @override
  String get locationDescription =>
      'أدخل موقعك أو استخدم الخريطة لتحديد موقعك بدقة';

  @override
  String get mapInstructions =>
      'حرّك الخريطة أو استخدم الموقع الحالي لتحديد موقعك بدقة';

  @override
  String get startNowButton => 'ابدأ الآن';

  @override
  String get backButton => 'عودة';

  @override
  String get uploadPhotoTitle => 'يرجى رفع صورتك.';

  @override
  String get uploadPhotoDescription =>
      'يفضل أن تكون الصورة واضحة  \n وحديثة، وتظهر الوجه بوضوح.';

  @override
  String get resendOtpSuccessTitle => 'تم إرسال رمز التحقق بنجاح';

  @override
  String get resendOtpSuccess =>
      'لقد أرسلنا رمز تحقق مكوّنًا من 5 أرقام إلى رقم هاتفك الرجاء إدخاله لإكمال التسجيل';

  @override
  String get otpVerifiedSuccessfullyTitle => 'تم التحقق من رمز التحقق بنجاح';

  @override
  String get otpVerifiedSuccessfully => 'تم التحقق من رقم هاتفك بنجاح.';

  @override
  String get invalidOtpCodeTitle => 'رمز التحقق غير صالح';

  @override
  String get invalidOtpCode =>
      'رمز التحقق الذي أدخلته غير صالح. الرجاء إعادة المحاولة.';

  @override
  String get errorUnknown => 'حدث خطأ غير معروف. الرجاء إعادة المحاولة.';

  @override
  String get errorInvalidCredentials =>
      'البيانات غير صالحة. الرجاء إعادة المحاولة.';

  @override
  String get errorPhoneNotFound =>
      'رقم الهاتف غير موجود. الرجاء إعادة المحاولة.';

  @override
  String get errorPhoneExists =>
      'رقم الهاتف موجود بالفعل. الرجاء إعادة المحاولة.';

  @override
  String get errorPhoneInvalid => 'رقم الهاتف غير صالح. الرجاء إعادة المحاولة.';

  @override
  String get errorNetwork =>
      'خطأ في الشبكة. الرجاء التحقق من اتصالك بالإنترنت وإعادة المحاولة.';

  @override
  String get errorServer => 'خطأ في الخادم. الرجاء إعادة المحاولة.';

  @override
  String get errorValidation =>
      'خطأ في التحقق. الرجاء التحقق من المدخلات وإعادة المحاولة.';

  @override
  String get errorPhoneNotVerified =>
      'رقم الهاتف غير موثوق. الرجاء التحقق من رقم الهاتف.';

  @override
  String get operationFailedTitle => 'فشل العملية';

  @override
  String get operationFailed => 'حدث خطأ أثناء العملية. الرجاء إعادة المحاولة.';

  @override
  String get operationSuccessfulTitle => 'تم العملية بنجاح';

  @override
  String get login_success_message => 'تم تسجيل دخولك بنجاح! أهلاً بعودتك';

  @override
  String get changePasswordSuccess => 'تم تغيير كلمة المرور بنجاح.';

  @override
  String get changePasswordFailure =>
      'فشل تغيير كلمة المرور. الرجاء إعادة المحاولة.';

  @override
  String get errorInvalidCredentialsTitle => 'البيانات غير صالحة';

  @override
  String get signUpFailureTitle => 'فشل إنشاء الحساب';

  @override
  String get signUpFailure =>
      'حدث خطأ أثناء إنشاء الحساب. الرجاء إعادة المحاولة.';

  @override
  String get accountCreatedSuccess => 'تم إنشاء الحساب بنجاح';

  @override
  String get accountCreatedSuccessSubtitle =>
      'يمكنك الآن تسجيل الدخول إلى حسابك.';

  @override
  String get resendOtpFailedTitle => 'فشل إعادة إرسال رمز التحقق';

  @override
  String get resendOtpFailed =>
      'حدث خطأ أثناء إعادة إرسال رمز التحقق. الرجاء إعادة المحاولة.';

  @override
  String get browse_specialties_and_book =>
      'اطّلع على التخصصات المختلفة، وقيّم الأطباء، واحجز بكل سهولة.';

  @override
  String get explore_and_choose_doctor => 'استكشف الأطباء واختر الأنسب لك';

  @override
  String get findRightDoctor => 'ابحث عن الطبيب المناسب لك';

  @override
  String get searchHistory => 'سجل البحث';

  @override
  String get clearSearchHistory => 'مسح سجل البحث';

  @override
  String get undefined => 'غير محدد';

  @override
  String get experience => 'الخبرة';

  @override
  String get rate => 'التقييم';

  @override
  String get distance => 'البعد';

  @override
  String get descending => 'تنازلي';

  @override
  String get ascending => 'تصاعدي';

  @override
  String get registeredLocation => 'موقعي المسجل';

  @override
  String get sortBy => 'الترتيب حسب';

  @override
  String get sortType => 'نوع الترتيب';

  @override
  String get apply => 'تطبيق';

  @override
  String get locate => 'تحديد الموقع';

  @override
  String get distanceKm => 'البعد (كم)';

  @override
  String get km => 'كيلومتر';

  @override
  String get m => 'متر';

  @override
  String get filterSpecialty => 'فلترة حسب التخصص';

  @override
  String get filterGender => 'فلترة حسب الجنس';

  @override
  String get location_services_disabled =>
      'خدمات الموقع معطلة. الرجاء تفعيلها للمتابعة.';

  @override
  String get location_permission_denied => 'تم رفض إذن الوصول للموقع.';

  @override
  String get location_permission_denied_forever =>
      'تم رفض إذن الموقع بشكل دائم. يرجى تفعيله من إعدادات التطبيق.';

  @override
  String get permissions_error_title => 'خطأ في الأذونات';

  @override
  String get authentication_failed => 'فشلت عملية المصادقة';

  @override
  String get reviews => 'تقييم';

  @override
  String get server_error => 'حدث خطأ غير متوقع. يرجى المحاولة لاحقًا';

  @override
  String get no_doctor_found =>
      'لم نجد أي طبيب يطابق بحثك. جرّب كلمات أخرى أو تحقق من الإملاء';

  @override
  String get profile => 'ملف';

  @override
  String get d => 'د';

  @override
  String get clinicLocation => 'موقع العيادة';

  @override
  String get easilyLocateClinic =>
      'اعرف مكان العيادة بسهولة، وحدّد طريقك إليها';

  @override
  String get oneClick => 'بنقرة واحدة.';

  @override
  String get clinicPhotos => 'صور العيادة';

  @override
  String get noClinicImage => 'عذرًا، لا توجد صور متاحة لهذه العيادة.';

  @override
  String get clinicEvaluation => 'التقييم العام للعيادة';

  @override
  String get realPastPatients => 'آراء حقيقية من مرضى سابقين';

  @override
  String get viewMore => 'عرض المزيد';

  @override
  String get about => 'نبذة';

  @override
  String get placeStudy => 'مكان الدراسة';

  @override
  String get aboutDoctor => 'عن الطبيب';

  @override
  String get show_all_days => 'عرض جميع أيام الشهر';

  @override
  String get select_booking_time => 'اختر ميعاد الحجز';

  @override
  String get book_now => 'احجز الآن';

  @override
  String get available => 'متاح';

  @override
  String remainingAppointmentsMessage(Object remainingCount) {
    return 'ما زال هناك $remainingCount مواعيد\nمتاحة لهذا اليوم';
  }

  @override
  String get noAppointmentsMessage => 'لا يوجد مواعيد\nمتاحة';

  @override
  String get noAppointments => 'لا توجد مواعيد';

  @override
  String get monday => 'الإثنين';

  @override
  String get tuesday => 'الثلاثاء';

  @override
  String get wednesday => 'الأربعاء';

  @override
  String get thursday => 'الخميس';

  @override
  String get friday => 'الجمعة';

  @override
  String get saturday => 'السبت';

  @override
  String get sunday => 'الأحد';

  @override
  String get am => 'صباحاً';

  @override
  String get pm => 'مساءً';
}
