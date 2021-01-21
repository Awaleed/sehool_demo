import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:supercharged/supercharged.dart';

import '../../generated/l10n.dart';
import 'flash_helper.dart';

abstract class Helpers {
  static void dismissFauces(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  static Size getWidgetSize(GlobalKey key) {
    final RenderBox renderBox = key.currentContext?.findRenderObject();
    return renderBox?.size;
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

  static DateTime _currentBackPressTime;

  static Future<bool> onWillPop(BuildContext context) {
    final now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;
      Helpers.showMessageOverlay(
        context,
        message: S.current.tap_back_again_to_leave,
      );
      return Future.value(false);
    }
    return Future.value(true);
  }

  static Completer showLoading(BuildContext context) {
    final completer = Completer();
    if (context != null) {
      FlashHelper.blockDialog(context, dismissCompleter: completer);
    }
    return completer;
  }

  static String mapErrorToMessage(dynamic error) {
    try {
      String message;
      if (error is DioError) {
        message = _mapDioError(error);
      } else {
        message = '$error';
      }
      debugPrint('$error');
      return message;
    } catch (e) {
      debugPrint('Error in mapErrorToMessage: $e\nError: $error');
      return '$error';
    }
  }

  static String _mapDioError(DioError error) {
    final message = StringBuffer();
    if (error.response?.data['errors'] != null &&
        error.response?.data['errors'] is Map) {
      final map = error.response?.data['errors'] as Map;
      for (final value in map.values) {
        if (value is List) {
          for (final str in value) {
            message.write('$str\n');
          }
        } else {
          message.write('$value\n');
        }
      }
      return message.toString();
    } else if (error.response?.data['error'] != null) {
      return '${error.response?.data['error']}';
    } else {
      return '${error.response?.data}';
    }
  }
}
