import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:quitanda/src/config/custom_colors.dart';

class UtilsServices {
  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: "pt_br");

    return numberFormat.format(price);
  }

  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd('pt_br').add_Hm();
    return dateFormat.format(dateTime);
  }

  void showCustomToast({
    required String message,
    bool isError = false,
    required context,
  }) {
    showToast(
      message,
      context: context,
      backgroundColor:
          isError ? CustomColors.customContrastColor : Colors.white,
      borderRadius: BorderRadius.circular(20),
      textStyle: TextStyle(
        color: isError ? Colors.white : Colors.black,
        fontSize: 16,
      ),
      animation: StyledToastAnimation.fadeScale,
    );
  }
}
