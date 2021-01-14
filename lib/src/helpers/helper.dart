import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

import 'flash_helper.dart';

abstract class Helpers {
  static void dismissFauces(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static bool isArabic(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'ar';

  static void showErrorOverlay(
    BuildContext context, {
    @required dynamic error,
  }) {
    String message;
    if (error is DioError && error?.response?.data != null) {
      if (error?.response?.data is Map) {
        message = error?.response?.data['message']?.toString() ??
            error?.response?.data['error']?.toString() ??
            error?.response?.data?.toString();
      } else if (error?.response?.data is List) {
        message = error?.response?.data?.first['message']?.toString() ??
            error?.response?.data?.first['error']?.toString() ??
            error?.response?.data?.first?.toString();
      } else {
        message = error?.response?.data?.toString();
      }
      if (error.response.statusCode == 401) {
        // if (UserRepository.currentUser.value != null) {
        //   message = 'Logged Out';
        //   shouldLogout = true;
        // }
      }
    } else {
      message = '$error';
    }
    debugPrint('$error');
    if (context == null) return;
    final completer = Completer();
    Future.delayed(3.seconds).then((_) {
      completer.complete();
    });

    FlashHelper.blockErrorMessage(
      context,
      message: message,
      dismissCompleter: completer,
    );
  }

  static Future<void> showSuccessOverlay(
    BuildContext context, {
    @required String message,
  }) {
    if (context == null) return Future.value();
    final completer = Completer();
    Future.delayed(3.seconds).then((_) => completer.complete());

    FlashHelper.blockSuccessMessage(
      context,
      message: message,
      dismissCompleter: completer,
    );
    return completer.future;
  }

  static Future<void> showMessageOverlay(
    BuildContext context, {
    @required String message,
  }) {
    if (context == null) return Future.value();
    final completer = Completer();
    Future.delayed(3.seconds).then((_) => completer.complete());

    FlashHelper.blockMessage(
      context,
      message: message,
      dismissCompleter: completer,
    );
    return completer.future;
  }

  static Future<bool> onWillPop(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => const AlertDialog(
        title: Text('Text'),
      ),
    );
  }

  static Completer showLoading(BuildContext context) {
    final completer = Completer();
    if (context != null) {
      FlashHelper.blockDialog(context, dismissCompleter: completer);
    }
    return completer;
  }
}
