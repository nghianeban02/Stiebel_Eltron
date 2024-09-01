import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/config/utils.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';

import '../screen/widget/custom_text.dart';
int MAX_LENGTH_CHARACTER = 255;

class Validator {
  static validateEmail(String? value) {
    if (!Utils.isNullOrEmpty(value)) {
      if (value!.length > MAX_LENGTH_CHARACTER) {
        return LocaleKeys.maxCharacter.tr;
      } else if (RegExp(EMAIL_REGEXP).hasMatch(value) == false) {
        return LocaleKeys.checkYourEmail.tr;
      }
    } else {
      return LocaleKeys.pleaseEnterYourMail.tr;
    }
  }

  static checkNull(String? value, {String? messageErrorNull, int? maxChar, int? minChar}) {
    if (value == null || value.isEmpty || value == ' ' || value.contains('  ') || value == 'null') {
      return messageErrorNull;
    }
    if (!Utils.isNullOrEmpty(maxChar) && value.length > maxChar!) {
      return '${LocaleKeys.enterMax}$maxChar${LocaleKeys.characters.tr}';
    }
    if (!Utils.isNullOrEmpty(minChar) && value.length < minChar!) {
      return '${LocaleKeys.enterMin}$minChar${LocaleKeys.characters.tr}';
    }
    return null;
  }

  static checkPhoneNumber(String? value) {
    if (value == null || (value.length <= 8 || value.length > 12 || value.isEmpty)) {
      return LocaleKeys.pleaseCheckYourPhone.tr;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value.replaceFirst('-', '').replaceFirst('+', ''))) {
      return LocaleKeys.pleaseEnterYourPhoneNumber.tr;
    }
    return null;
  }

  static checkPassword(String? value) {
    if (Utils.isNullOrEmpty(value) || value == ' ' || value!.contains('  ')) {
      return LocaleKeys.pleaseEnterYourPassword.tr;
    } else if (value.length > MAX_LENGTH_CHARACTER) {
      return '${LocaleKeys.enterMax} $MAX_LENGTH_CHARACTER${LocaleKeys.characters.tr}';
    } else if (RegExp(EMOJI_REGEXP).hasMatch(value)) {
      return LocaleKeys.dontInsertSpecialCharacter;
    } else if (value.length < 6) {
      return LocaleKeys.password6Minium.tr;
    }
    return null;
  }

  static checkInputNumber(String? value, {double? min, double? max, double maxLength = 14}) {
    if (Utils.isNullOrEmpty(value)) {
      return 'Không thể để trống';
    }
    if (double.parse(value!) <= 0) {
      return 'Số  phải lớn hơn 0';
    }
    if (value.length >= maxLength) {
      return 'Nhập tối đa $maxLength kí tự';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return "Phải nhập số nguyên";
    }
    if (!Utils.isNullOrEmpty(min) && double.parse(value) < (min ?? 0)) {
      return 'Không nhỏ hơn $min';
    }
    if (!Utils.isNullOrEmpty(max) && double.parse(value) > (max ?? 0)) {
      return 'Không lớn hơn $max';
    }
    return null;
  }
}

