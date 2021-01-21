import 'package:onesignal_flutter/onesignal_flutter.dart';

Future<void> initPushNotifications() async {
  OneSignal.shared.init('e0f421ff-976a-421e-ad25-f1d8d719ea48', iOSSettings: {
    OSiOSSettings.autoPrompt: true,
    OSiOSSettings.inAppLaunchUrl: true
  });
  OneSignal.shared.setInFocusDisplayType(
    OSNotificationDisplayType.notification,
  );

  await OneSignal.shared.promptUserForPushNotificationPermission(
    fallbackToSettings: true,
  );
}
