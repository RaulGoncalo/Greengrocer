import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:quitanda/src/config/custom_colors.dart';

class UtilsServices {
  final storage = const FlutterSecureStorage();

  //Salva dados localmente em segurança
  Future<void> saveLocalData(
      {required String key, required String data}) async {
    await storage.write(key: key, value: data);
  }

  //Recupera dados salvo localmente em segurança
  Future<String?> getLocalData({required String key}) async {
    return await storage.read(key: key);
  }

  //Deleta dados salvo localmente em segurança
  Future<void> removeLocalData({required String key}) async {
    await storage.delete(key: key);
  }

  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: "pt_br");

    return numberFormat.format(price);
  }

  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd('pt_br').add_Hm();
    return dateFormat.format(dateTime.toLocal());
  }

  Uint8List decodeQrCodeImage(String value) {
    String base64String = value.split(',').last;

    return base64.decode(base64String);
  }

  void showCustomToast({
    required String message,
    bool isError = false,
    BuildContext? context,
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
