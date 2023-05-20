import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

class UntilPrice {
  final storage = const FlutterSecureStorage();

  Future<void> saveLocalData({required String key, required String value}) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> getLocalData({required String key}) async {
    return await storage.read(key: key);
  }

  Future<void> deleteLocalData({required String key}) async {
    await storage.delete(key: key);
  }

  String localPrice(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_BR');
    return numberFormat.format(price);
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  void showToast({required String message, bool type = false}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: type ? Colors.red : Colors.white,
        textColor: type ? Colors.white : Colors.black,
        fontSize: 14.0);
  }

  Uint8List decodeQrCode(String qrCode) {
    String data = qrCode.split(',').last;
    return base64Decode(data);
  }
}
