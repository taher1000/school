import 'package:flutter/material.dart';

import '../resources/app_localization.dart';

class Validation {
  static String? isValid(BuildContext context, String value) {
    if (value.isEmpty) {
      return AppLocalization.of(context)
          .getTranslatedValues("this_field_is_required");
    }
    return null;
  }

  static String? isValidQuestion(
      BuildContext context, String value, String answer) {
    if (value.isEmpty) {
      return AppLocalization.of(context)
          .getTranslatedValues("this_field_is_required");
    } else if (value.toUpperCase() != answer) {
      return AppLocalization.of(context)
          .getTranslatedValues("the_answer_is_incorrect");
    }
    return null;
  }

  static String? isNationalNumber(BuildContext context, String nationalNumber) {
    String p = r'^[0-9]{10}$';
    RegExp regExp = RegExp(p);
    if (nationalNumber.isEmpty) {
      return AppLocalization.of(context)
          .getTranslatedValues("please_enter_your_national_number");
    } else if (!regExp.hasMatch(nationalNumber)) {
      return AppLocalization.of(context)
          .getTranslatedValues("please_enter_valid_national_number");
    }
    return null;
  }

  static String? isBillingNumber(BuildContext context, String value) {
    String p = r'^[0-9]';
    RegExp regExp = RegExp(p);

    if (value.isEmpty) {
      return null;
    } else if (!regExp.hasMatch(value)) {
      return AppLocalization.of(context)
          .getTranslatedValues("please_enter_valid_billing_number");
    }
    return null;
  }

  static String? isEmail(BuildContext context, String email) {
    String p =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    RegExp regExp = RegExp(p);
    if (email.isEmpty) {
      return AppLocalization.of(context)
          .getTranslatedValues("please_enter_your_email");
    } else if (!regExp.hasMatch(email)) {
      return AppLocalization.of(context)
          .getTranslatedValues("please_enter_valid_email");
    }
    return null;
  }

  static String? isPassword(BuildContext context, String password) {
    String p =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\+/\\\$%^&*(),.?":{}|<>~\-\_]).{8,}$'; //(?=.*?[!@#\$&*~-])
    RegExp regExp = RegExp(p);
    if (password.isEmpty) {
      return AppLocalization.of(context)
          .getTranslatedValues("please_enter_password");
    } else if (!regExp.hasMatch(password)) {
      return AppLocalization.of(context)
          .getTranslatedValues("please_enter_valid_password");
    }
    return null;
  }

  static String? isConfirmPassword(
      BuildContext context, String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return AppLocalization.of(context)
          .getTranslatedValues("please_enter_confirm_password");
    } else if (password != confirmPassword) {
      return AppLocalization.of(context)
          .getTranslatedValues("password_does_not_match");
    }
    return null;
  }

  static String? isVerificationCode(BuildContext context, String code) {
    String p = r'^[0-9]{6}$';
    RegExp regExp = RegExp(p);
    if (code.isEmpty) {
      return AppLocalization.of(context)
          .getTranslatedValues("please_enter_verification_code");
    } else if (!regExp.hasMatch(code)) {
      return AppLocalization.of(context)
          .getTranslatedValues("please_enter_valid_verification_code");
    }
    return null;
  }

  static String? isVerificationCode2(BuildContext context, String code) {
    String p = r'^[0-9]{4}$';
    RegExp regExp = RegExp(p);
    if (code.isEmpty) {
      return AppLocalization.of(context)
          .getTranslatedValues("please_enter_verification_code");
    } else if (!regExp.hasMatch(code)) {
      return AppLocalization.of(context)
          .getTranslatedValues("please_enter_valid_verification_code");
    }
    return null;
  }

  static String? isPinCode(BuildContext context, String code) {
    String p = r'^[0-9]{4}$';
    RegExp regExp = RegExp(p);
    if (code.isEmpty) {
      return AppLocalization.of(context)
          .getTranslatedValues("please_enter_pin_code");
    } else if (!regExp.hasMatch(code)) {
      return AppLocalization.of(context)
          .getTranslatedValues("please_enter_valid_pin_code");
    }
    return null;
  }

  static String? isConfirmPinCode(
      BuildContext context, String code, String confirmCode) {
    if (confirmCode.isEmpty) {
      return AppLocalization.of(context)
          .getTranslatedValues("please_enter_confirm_pin_code");
    } else if (code != confirmCode) {
      return AppLocalization.of(context)
          .getTranslatedValues("pin_code_does_not_match");
    }
    return null;
  }

  static String? isText(BuildContext context, String text) {
    String p =
        r'^[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z]+[\u0600-\u065F\u066A-\u06EF\u06FA-\u06FFa-zA-Z-_\. ]*$';
    RegExp regExp = RegExp(p);
    if (text.trim().isEmpty) {
      return AppLocalization.of(context)
          .getTranslatedValues("this_field_is_required");
    } else if (!regExp.hasMatch(text)) {
      return AppLocalization.of(context)
          .getTranslatedValues("please_enter_valid_text");
    }
    return null;
  }

  static String? isValidDate(
      BuildContext context, DateTime value, DateTime answer) {
    if (!value.isAtSameMomentAs(answer)) {
      return AppLocalization.of(context)
          .getTranslatedValues("the_answer_is_incorrect");
    }
    return null;
  }
}
