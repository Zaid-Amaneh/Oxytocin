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
  String get medicalInfoSubtitle =>
      ' صحتك تهمنا\nنرجى تزويدنا بمعلوماتك الطبية.';

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

  @override
  String get error => 'حدث خطأ';

  @override
  String get locationError => 'حدث خطأ أثناء تحديد الموقع';

  @override
  String get routeNotFound => 'المسار غير موجود';

  @override
  String get locationTimeout => 'انتهى وقت محاولة تحديد الموقع';

  @override
  String get quotaExceeded => 'تم تجاوز الحد المسموح';

  @override
  String get apiKeyError => 'خطأ في مفتاح API';

  @override
  String get routeError => 'حدث خطأ أثناء جلب المسار';

  @override
  String get noRouteFound => 'لم يتم العثور على أي مسار';

  @override
  String get yourLocation => 'موقعك الحالي';

  @override
  String get loadingRoute => 'جارٍ تحميل المسار...';

  @override
  String get errorOccurred => 'نعتذر، حدث خطأ ما. الرجاء إعادة المحاولة';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get age => 'العمر';

  @override
  String get subspecialties => 'الاختصاصات الفرعية';

  @override
  String get noCommentDoctor =>
      'لم يترك أحد تعليقاً بعد. احجز الآن وكن أول من يقيّم هذا الطبيب!';

  @override
  String get doctor_added_success => 'تمت إضافة الطبيب إلى المفضلة بنجاح';

  @override
  String get doctor_added_failure_network =>
      'تعذر إضافة الطبيب إلى المفضلة بسبب مشاكل في الاتصال';

  @override
  String get doctor_added_failure_auth =>
      'لا يمكنك إضافة الطبيب إلى المفضلة لأنك لم تسجل الدخول';

  @override
  String get failure_title => 'حدث خطأ';

  @override
  String get success_title => 'تم بنجاح';

  @override
  String get doctor_removed_success => 'تم حذف الطبيب من المفضلة بنجاح';

  @override
  String get view_all_reservations => 'عرض جميع الحجوزات';

  @override
  String get near_appointments => 'المواعيد القريبة';

  @override
  String get appointments_expired =>
      'انتهت المواعيد القريبة. يمكنك الضغط على \"عرض جميع الحجوزات\" لاختيار التاريخ والشهر المناسب لك.';

  @override
  String get appointments_calendar => 'تقويم المواعيد';

  @override
  String get choose_month => 'اختر الشهر';

  @override
  String get select => 'اختيار';

  @override
  String get cancel => 'إلغاء';

  @override
  String get january => 'يناير';

  @override
  String get february => 'فبراير';

  @override
  String get march => 'مارس';

  @override
  String get april => 'أبريل';

  @override
  String get may => 'مايو';

  @override
  String get june => 'يونيو';

  @override
  String get july => 'يوليو';

  @override
  String get august => 'أغسطس';

  @override
  String get september => 'سبتمبر';

  @override
  String get october => 'أكتوبر';

  @override
  String get november => 'نوفمبر';

  @override
  String get december => 'ديسمبر';

  @override
  String get no_appointments_available => 'لا توجد مواعيد متاحة';

  @override
  String get no_appointments_description =>
      'لم يتم العثور على أي مواعيد في هذا الشهر';

  @override
  String get error_loading_appointments => 'خطأ في تحميل المواعيد';

  @override
  String get please_try_again => 'يرجى المحاولة مرة أخرى';

  @override
  String get available_appointments => 'المواعيد المتاحة';

  @override
  String get appointment => 'موعد';

  @override
  String get loadingAppointments => 'جاري تحميل المواعيد...';

  @override
  String get availableDays => 'الأيام المتاحة';

  @override
  String get day => 'يوم';

  @override
  String get days => 'أيام';

  @override
  String get appointmentInstructions =>
      'يمكنك هنا كتابة أي شيء ترغب في أن يعرفه الطبيب قبل الموعد، مثل الأعراض التي تشعر بها، متى بدأت حالتك، أو أي تفاصيل تعتقد أنها مهمة.';

  @override
  String get tellDoctorHowYouFeel => 'أخبر الطبيب بما تشعر به';

  @override
  String get confirmBooking => 'تأكيد الحجز';

  @override
  String get bookingSuccess => 'تم حجز موعدك بنجاح!';

  @override
  String get thankYouMessage =>
      'شكرًا لاستخدامك منصتنا. نتمنى لك دوام الصحة والعافية!';

  @override
  String get attachFiles =>
      'يمكنك إرفاق أي ملفات ترغب أن يطّلع عليها الطبيب قبل الموعد';

  @override
  String get backToHome => 'العودة إلى الصفحة الرئيسية';

  @override
  String availableAppointments(Object dayDate) {
    return 'هذه هي المواعيد المتاحة ليوم $dayDate، يرجى اختيار الوقت المناسب لك.';
  }

  @override
  String get chooseTime => 'اختر الوقت المناسب';

  @override
  String get appointment_success => 'تم حجز موعدك بنجاح!';

  @override
  String get thank_you_message =>
      'شكرًا لاستخدامك منصتنا. نتمنى لك دوام الصحة والعافية!';

  @override
  String get attach_files_hint =>
      'يمكنك إرفاق أي ملفات ترغب أن يطّلع عليها الطبيب قبل الموعد';

  @override
  String get doctor => 'الطبيب:';

  @override
  String get specialization => 'التخصص:';

  @override
  String get date => 'التاريخ:';

  @override
  String get time => 'الوقت:';

  @override
  String get location => 'المكان:';

  @override
  String get add_file => 'أضف ملف';

  @override
  String get back_to_home => 'العودة إلى الصفحة الرئيسية';

  @override
  String get appointment_confirmed => 'تم تأكيد الموعد';

  @override
  String max_files_error(Object maxFiles) {
    return 'لا يمكن رفع أكثر من $maxFiles ملفات';
  }

  @override
  String file_size_error(Object fileName, Object maxFileSizeInMB) {
    return 'حجم الملف $fileName أكبر من $maxFileSizeInMB ميجابايت';
  }

  @override
  String allowed_files_limit(Object allowedCount, Object maxFiles) {
    return 'تم إضافة $allowedCount ملفات فقط. الحد الأقصى $maxFiles ملفات';
  }

  @override
  String get file_pick_error => 'حدث خطأ في اختيار الملفات';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get tap_to_select_files => 'اضغط لاختيار الملفات';

  @override
  String upload_hint(Object maxFileSizeInMB, Object maxFiles) {
    return 'يمكنك رفع حتى $maxFiles ملفات، كل ملف حتى $maxFileSizeInMB ميجابايت';
  }

  @override
  String get supported_formats =>
      'الصيغ المدعومة: PDF, DOC, DOCX, TXT, JPG, PNG';

  @override
  String files_progress(Object maxFiles, Object selectedCount) {
    return '$selectedCount من $maxFiles ملفات';
  }

  @override
  String get appointment_not_available =>
      'للأسف، الموعد الذي حاولت حجزه لم يعد متاحاً لأنه تم حجزه من مريض آخر.';

  @override
  String get files_uploaded_success =>
      'تم رفع الملفات بنجاح! سيتمكن طبيبك من الاطلاع عليها.';

  @override
  String get files_upload_error =>
      'حدثت مشكلة أثناء رفع الملفات. يرجى المحاولة مرة أخرى.';

  @override
  String get invalid_uploaded_file =>
      'أحد الملفات التي قمت برفعها غير صالح أو يحتوي على مشكلة. يرجى التحقق من الملفات والمحاولة مرة أخرى.';

  @override
  String get next_appointment_message =>
      'موعدك القادم في انتظارك. نتمنى لك دوام الصحة والعافية.';

  @override
  String get reservationCanceledSuccess => 'لقد قمت بإلغاء هذا الحجز بنجاح.';

  @override
  String get allReservations => 'جميع الحجوزات';

  @override
  String get currentReservations => 'الحجوزات الحالية';

  @override
  String get pastReservations => 'الحجوزات السابقة';

  @override
  String get canceledReservations => 'الحجوزات الملغاة';

  @override
  String get rebook => 'إعادة الحجز';

  @override
  String get loginRequiredForCurrentReservations =>
      'لا يمكنك عرض الحجوزات الحالية لأنك لم تقم بتسجيل الدخول بعد. سجّل الدخول واستفد من جميع ميزات التطبيق.';

  @override
  String get edit => 'تعديل';

  @override
  String get reschedule => 'تغيير الموعد';

  @override
  String get cancelReservation => 'إلغاء الحجز';

  @override
  String get sessionFeedbackTitle => 'كيف كانت جلستك؟ قيّم تجربتك معنا!';

  @override
  String get sessionFeedbackSubtitle =>
      'شاركنا رأيك ليساعد غيرك.. ما الذي أعجبك أو لم يعجبك؟';

  @override
  String get send => 'إرسال';

  @override
  String get map => 'الخريطة';

  @override
  String get rateDoctor => 'قيّم الطبيب';

  @override
  String get details => 'تفاصيل';

  @override
  String get call => 'اتصال';

  @override
  String get callErrorTitle => 'عذرًا، لم نتمكن من إجراء المكالمة';

  @override
  String get callErrorMessage =>
      'تعذّر فتح تطبيق الاتصال. جرّب لاحقًا أو اتصل يدويًا.';

  @override
  String get missed_reservation =>
      'لم تحضر هذا الحجز. نتمنى أن تتمكن من الحضور في المرات القادمة.';

  @override
  String get ratingFailed =>
      'لم يتم رفع تقييمك بسبب حدوث خطأ، يرجى المحاولة لاحقًا.';

  @override
  String get ratingSuccess => 'تم رفع تقييمك بنجاح، شكرًا لك!';

  @override
  String get alreadyRatedOrCommented => 'تم التقييم';

  @override
  String get visitCompleted =>
      'تمت زيارتك بنجاح. نتمنى لك دوام الصحة والعافية!';

  @override
  String get noNotes => 'لا توجد ملاحظات مسجلة';

  @override
  String get patientNotes => 'ملاحظات المريض';

  @override
  String get appointmentInfo => 'معلومات الموعد';

  @override
  String get doctorName => 'اسم الطبيب:';

  @override
  String get doctorInfo => 'معلومات الطبيب';

  @override
  String get appointmentDetails => 'تفاصيل الموعد';

  @override
  String get address => 'العنوان:';

  @override
  String get clinicNumber => 'رقم العيادة:';

  @override
  String get queue => 'الطابور';

  @override
  String get cancellationSuccess => 'تم إلغاء الموعد بنجاح.';

  @override
  String get cancellationFailed => 'لم يتم إلغاء الموعد. يرجى المحاولة لاحقًا.';

  @override
  String get updateBookingSuccess => 'تم تعديل حجزك بنجاح.';

  @override
  String get updateBookingFailed => 'فشل تعديل حجزك. يرجى المحاولة لاحقًا.';

  @override
  String get editUploadedFiles => 'تعديل الملفات';

  @override
  String get rebookingSuccess => 'تمت إعادة حجزك بنجاح بعد الإلغاء.';

  @override
  String get rebookingFailed =>
      'تعذّرت إعادة حجزك، الموعد المطلوب أصبح مشغولاً.';

  @override
  String get fileOpenFailed => 'فشل تحميل أو فتح الملف';

  @override
  String get fileLoadedNoViewer => 'تم التحميل ولا يوجد عارض مناسب لفتح الملف.';

  @override
  String get manageAttachments => 'إدارة الملفات المرفقة';

  @override
  String get attachments => 'الملفات المرفقة';

  @override
  String attachmentsCount(Object count) {
    return '$count من 5 ملفات';
  }

  @override
  String get uploading => 'جاري الرفع...';

  @override
  String get addFile => 'إضافة ملف';

  @override
  String get loadingFiles => 'جاري تحميل الملفات...';

  @override
  String get noAttachments => 'لا توجد ملفات مرفقة';

  @override
  String get addFileHint => 'اضغط على زر \"إضافة ملف\" لرفع ملفاتك';

  @override
  String get deleteFile => 'حذف الملف';

  @override
  String get maxFilesError => 'لا يمكن رفع أكثر من 5 ملفات';

  @override
  String get uploadAlerts => 'تنبيهات الرفع';

  @override
  String get fileSelectionError => 'حدث خطأ أثناء اختيار الملفات';

  @override
  String get ok => 'موافق';

  @override
  String get deleteConfirmationQuestion => 'هل أنت متأكد من حذف هذا الملف؟';

  @override
  String get deleteConfirmation => 'تأكيد الحذف';

  @override
  String get delete => 'حذف';

  @override
  String get canceled => 'ألغى';

  @override
  String get absent => 'غائب';

  @override
  String get waiting => 'ينتظر';

  @override
  String get inExamination => 'يُفحص الآن';

  @override
  String get finished => 'انتهى';

  @override
  String enteredAt(Object time) {
    return 'دخل: $time';
  }

  @override
  String exitedAt(Object time) {
    return 'خرج: $time';
  }

  @override
  String appointmentAt(Object time) {
    return 'الموعد: $time';
  }

  @override
  String get you => 'أنت';

  @override
  String patientNumber(Object number) {
    return 'مريض رقم $number';
  }

  @override
  String get inQueue => 'في الانتظار';

  @override
  String get yourPosition => 'موقعك';

  @override
  String get completed => 'مكتمل';

  @override
  String queueProgress(Object progress, Object total) {
    return '$progress من $total';
  }

  @override
  String get queueProgressText => 'تقدم الطابور';

  @override
  String get close => 'إغلاق';

  @override
  String averageDelay(Object minutes) {
    return 'متوسط التأخير: $minutesد';
  }

  @override
  String averageExamination(Object minutes) {
    return 'متوسط الفحص: $minutesد';
  }

  @override
  String yourNumber(Object number) {
    return 'رقمك: $number';
  }

  @override
  String estimatedWait(Object minutes) {
    return '$minutes دقيقة تقريباً';
  }

  @override
  String get expectedWaitTime => 'الوقت المتوقع للانتظار';

  @override
  String get waitingQueue => 'طابور الانتظار';

  @override
  String get queueLoading => 'جاري تحميل بيانات الطابور...';

  @override
  String get pleaseWait => 'يرجى الانتظار قليلاً';

  @override
  String get queueLoadFailed => 'فشل في تحميل الطابور';

  @override
  String get serverError =>
      'تعذر الاتصال بالخادم. يرجى التحقق من الاتصال بالإنترنت.';

  @override
  String get noQueue => 'لا يوجد طابور حالياً';

  @override
  String doctorUnavailable(Object doctorName) {
    return 'د. $doctorName غير متاح حالياً أو لا توجد مواعيد مجدولة';
  }

  @override
  String get checkLater => 'يمكنك العودة لاحقاً للتحقق من حالة الطابور';

  @override
  String get unknownState => 'حالة غير معروفة';

  @override
  String get unexpectedError => 'حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى';

  @override
  String get cancelAppointment => 'نعم، إلغاء الموعد';

  @override
  String get back => 'تراجع';

  @override
  String get confirmCancel => 'تأكيد الإلغاء';

  @override
  String get cancelConfirmationMsg =>
      'هل أنت متأكد من إلغاء هذا الموعد؟ لن تتمكن من التراجع عن هذا الإجراء.';

  @override
  String get cancelAppointmentPermanently => 'إلغاء الموعد نهائياً';

  @override
  String get addRemovemanageAttachments => 'إضافة أو حذف الملفات المرفقة';

  @override
  String get changeAppointmentDateTime => 'تغيير تاريخ أو وقت الموعد';

  @override
  String get noCurrentAppointments => 'لا يوجد أي مواعيد حالية';

  @override
  String get noPastAppointments => 'لا يوجد أي مواعيد سابقة';

  @override
  String get noCancelledAppointments => 'لا يوجد أي مواعيد ملغاة';

  @override
  String get patientBannedTitle => 'تم حظر المريض';

  @override
  String get patientBannedDescription =>
      'لقد قامت العيادة بحظر هذا الحساب. يمكنك التواصل مع العيادة لإزالة الحظر أو في حال كنت تظن أنه قد تم حظرك عن طريق الخطأ.';

  @override
  String get myMedicalRecordsTitle => 'سجلاتي الطبية';

  @override
  String get myMedicalRecordsDescription =>
      'هنا يمكنك الاطلاع على أرشيفك الطبي بناءً على التخصصات التي زرت أطباء فيها من قبل. اختر أحد التخصصات لتتصفح السجلات الطبية المرتبطة به.';

  @override
  String get selectSpecialtyToViewRecords =>
      'اختر اختصاصًا طبيًا للاطلاع على سجلاتك';

  @override
  String get visits => 'زيارة';

  @override
  String get selectDoctorToViewRecords => 'اختر الطبيب لعرض سجلاتك الطبية معه';

  @override
  String get visitedDoctorsDescription =>
      'فيما يلي قائمة الأطباء الذين زرتهم. اختر طبيبًا للاطلاع على السجلات التي كتبها لك.';

  @override
  String get remainingAmount => 'المبلغ المتبقي';

  @override
  String get paidAmount => 'المبلغ المدفوع';

  @override
  String get sessionCost => 'تكلفة الجلسة';

  @override
  String get financialInfo => 'المعلومات المالية';

  @override
  String get vitalSigns => 'العلامات الحيوية';

  @override
  String get doctorRecommendations => 'توصيات الطبيب';

  @override
  String get medicalSummary => 'ملخص الحالة الطبية';

  @override
  String get mainComplaint => 'الشكوى الأساسية';

  @override
  String get manageMedicalRecords => 'إدارة السجلات الطبية';

  @override
  String get medicalRecordsPermissions => 'تحديد صلاحيات السجلات الطبية';

  @override
  String get medicalRecordsPermissionsDesc =>
      'اختر ما إذا كان السجل الطبي عامًا يمكن لجميع الأطباء الاطلاع عليه، أو خاصًا بحيث يقتصر على أطباء نفس الاختصاص.';

  @override
  String get public => 'عام';

  @override
  String get restricted => 'خاص';

  @override
  String get noMedicalRecordsInThisField =>
      'لا توجد لديك أي سجلات طبية في هذا المجال حتى الآن، وهذا أمر يدعو للتفاؤل.';

  @override
  String get profilePersonal => 'الملف الشخصي';

  @override
  String get appointments => 'المواعيد';

  @override
  String get home => 'الرئيسية';

  @override
  String get errorLoadingCategories => 'حدث خطأ في تحميل الفئات';

  @override
  String get doctors => 'الأطباء';

  @override
  String get noDoctorsAvailable => 'لا يوجد أطباء';

  @override
  String get failedToLoadCategories => 'فشل في تحميل الفئات';

  @override
  String get failedToFetchDoctors => 'فشل في جلب الأطباء';

  @override
  String get settingUpForYou => 'نقوم بإعداد كل شيء لك الآن...';

  @override
  String get firstStepHealthcare =>
      'خطوتك الأولى نحو عناية صحية متكاملة تبدأ الآن';

  @override
  String get chronicDiseases => 'الأمراض المزمنة';

  @override
  String get yourHealthMatters => 'صحتك تهمنا\nنرجى تزويدنا بمعلوماتك الطبية.';

  @override
  String get allergies => 'الحساسية';

  @override
  String get regularMedications => 'الأدوية المستخدمة بانتظام';

  @override
  String get chooseBloodType => 'اختر نوع زمرة دمك';

  @override
  String get lifestyleInformation => 'معلومات نمط الحياة';

  @override
  String get completePersonalInfo =>
      'نرغب بالتعرف عليك أكثر\nفضلًا أكمل بياناتك الشخصية.';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

  @override
  String get enterValidEmail => 'يرجى إدخال بريد إلكتروني صحيح';

  @override
  String get gender => 'الجنس';

  @override
  String get dateOfBirth => 'تاريخ الميلاد';

  @override
  String get currentJob => 'الوظيفة الحالية';

  @override
  String get fillAllRequiredFields => 'يرجى تعبئة جميع الحقول المطلوبة';

  @override
  String get errorGettingLocation => 'خطأ في الحصول على الموقع:';

  @override
  String get enterLocationOnMap => 'يرجى إدخال الموقع وتحديده على الخريطة';

  @override
  String get enterLocationMessage =>
      'لنكن أقرب إليك  \n أدخل موقعك وحدده على الخريطة';

  @override
  String get currentLocation => 'موقعك الحالي';

  @override
  String get enterAddress => 'اكتب عنوانك أو اسم منطقتك (مثال: شارع بغداد).';

  @override
  String get moveMapOrUseLocation =>
      'حرك الخريطة أو استخدم الموقع الحالي لتحديد موقعك بدقة';

  @override
  String get loadingMap => 'جاري تحميل الخريطة...';

  @override
  String get addPersonalTouch => 'أضف لمستك الشخصية';

  @override
  String get uploadPhoto => 'يرجى رفع صورتك.';

  @override
  String get photoGuidelines =>
      'يفضل أن تكون الصورة واضحة  \n وحديثة، وتظهر الوجه بوضوح.';

  @override
  String get failedToFetchFavorites => 'فشل في الحصول على المفضلة';

  @override
  String get connectionError => 'خطأ في الاتصال:';

  @override
  String get failedToFetchFavoriteDoctors => 'فشل في الحصول على أطباء المفضلة';

  @override
  String get failedToAddFavoriteDoctor => 'فشل في إضافة الطبيب للمفضلة';

  @override
  String get failedToRemoveFavoriteDoctor => 'فشل في حذف الطبيب من المفضلة';

  @override
  String get noFavoriteDoctors => 'لا يوجد أطباء مفضلين';

  @override
  String get pleaseLoginFirst => 'يرجى تسجيل الدخول أولاً';

  @override
  String get errorLoadingFavorites => 'حدث خطأ في تحميل المفضلة';

  @override
  String get favoriteDoctors => 'الأطباء المفضلون';

  @override
  String get searchSpecialty => 'ما هو التخصص الذي تبحث عنه';

  @override
  String get viewAll => 'عرض الكل';

  @override
  String get topDoctorsByRating => ' أفضل الأطباء حسب تقييم المرضى      ';

  @override
  String get errorLoadingData => 'حدث خطأ في تحميل البيانات';

  @override
  String get noDataAvailable => 'لا توجد بيانات متاحة';

  @override
  String get doctorsNearYou => 'أطباء بالقرب منك';

  @override
  String get noNearbyDoctors => 'لا يوجد أطباء قريبين في الوقت الحالي';

  @override
  String get errorLoadingNearbyDoctors => 'حدث خطأ في تحميل الأطباء القريبين';

  @override
  String get clinic => 'العيادة:';

  @override
  String get distanceFromYou => 'يبعد عنك';

  @override
  String get earliestAvailableAppointment => 'أقرب موعد متاح';

  @override
  String get bookNow => 'احجز الآن';

  @override
  String get greetingMessage => 'مرحباً، نتمنى لك يوماً سعيداً!';

  @override
  String get failedToUpdateData => 'فشل في تحديث البيانات';

  @override
  String get failedToUpdatePhoto => 'فشل في تحديث الصورة';

  @override
  String get failedToFetchData => 'فشل في جلب البيانات';

  @override
  String get loadingData => 'جاري تحميل البيانات...';

  @override
  String get personalInformation => 'المعلومات الشخصية';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get professionalInformation => 'المعلومات المهنية';

  @override
  String get profession => 'المهنة';

  @override
  String get medicalInformation => 'المعلومات الطبية';

  @override
  String get bloodType => 'فصيلة الدم';

  @override
  String get medicalHistory => 'التاريخ الطبي';

  @override
  String get notSpecified => 'غير محدد';

  @override
  String get currentMedications => 'الأدوية الحالية';

  @override
  String get lifestyle => 'نمط الحياة';

  @override
  String get smoker => 'مدخن';

  @override
  String get drinksAlcohol => 'يشرب الكحول';

  @override
  String get married => 'متزوج';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get logOut => 'تسجيل الخروج';

  @override
  String get confirmLogOut => 'هل أنت متأكد من أنك تريد تسجيل الخروج؟';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get language => 'اللغة';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'الانجليزية';

  @override
  String get account => 'الحساب';

  @override
  String get medicalRecords => 'السجلات الطبية';

  @override
  String get favorites => 'المفضلة';

  @override
  String get settings => 'الاعدادات';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get walkingMessage =>
      '“ 10 دقائق من المشي يومياً تصنع فرقاً كبيراً في صحتك ونشاطك. ابدأ الآن! ”';
}
