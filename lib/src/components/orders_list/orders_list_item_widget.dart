import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sailor/sailor.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../generated/l10n.dart';
import '../../core/api_caller.dart';
import '../../helpers/helper.dart';
import '../../models/order_model.dart';
import '../../patched_components/custom_stepper.dart';
import '../../routes/config_routes.dart';
import '../../screens/home/home.dart';

class OrdersListItemWidget extends StatelessWidget {
  const OrdersListItemWidget({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final OrderModel cart;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.all(20),
      color: Colors.white54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Text(
                    '${S.current.order_id}: ${cart.id}',
                  ),
                  const Spacer(),
                  Text(
                    ' ${DateFormat.yMEd().format(cart.createdAt)}',
                  ),
                ],
              ),
            ),
            const Divider(),
            if ((cart.status.id >= 4 && cart.status.id <= 5) && cart.delivery != null) ...[
              ListTile(
                leading: Image.asset('assets/images/user-with-shirt-and-tie_icon-icons.com_68276.png'),
                trailing: cart.status.id != 4
                    ? null
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            iconSize: 50,
                            onPressed: () async {
                              final phone = cart.delivery.phone?.replaceFirst('0', '966');
                              final uri = 'https://api.whatsapp.com/send?phone=$phone';
                              if (await canLaunch(uri)) {
                                launch(uri);
                              } else {
                                throw 'Could not launch $uri';
                              }
                            },
                            icon: SvgPicture.asset('assets/images/logo_whatsapp_telephone_handset_icon_143174.svg', height: 50, width: 50),
                          ),
                          IconButton(
                            iconSize: 50,
                            icon: SvgPicture.asset('assets/images/call-phone-telephone_108619.svg', height: 50, width: 50),
                            onPressed: () async {
                              FlutterPhoneDirectCaller.directCall(
                                cart.delivery.phone,
                              );
                            },
                          ),
                        ],
                      ),
                title: Text(cart.delivery.name),
                subtitle: Text(cart.delivery.phone),
              ),
              const Divider(),
            ],
            OrderStatusWidget(order: cart),
            const Divider(),
            if (cart.products?.isNotEmpty ?? false)
              ...cart.products.map(
                (e) => ListTile(
                  title: Text(e.name),
                  subtitle: Text(
                    '${e.qyt} ${S.current.piece}, ${e.slicerType}',
                  ),
                  trailing: Text('${e.subtotal.format()} ﷼'),
                ),
              ),
            const Divider(),
            ListTile(
              title: Text(S.current.notes),
              subtitle: Text(cart.note ?? S.current.none),
            ),
            ListTile(
              title: Text(S.current.total),
              subtitle: Text('${cart.total.format()} ﷼'),
            ),
            ListTile(
              title: Text(S.current.payment_mode),
              subtitle: Text(cart.payment ?? S.current.none),
            ),
            // if (cart?.address?.address != null && cart.address.address.isNotEmpty)
            ListTile(
              title: Text(S.current.address),
              subtitle: Text(cart?.address?.address ?? S.current.pickup),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderStatusWidget extends StatelessWidget with ApiCaller {
  OrderStatusWidget({Key key, @required this.order}) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    if (order.status.id > 5) {
      Color color;
      IconData icon;
      switch (order.status.id) {
        case 5:
          icon = Icons.check;
          break;
        case 6:
          icon = Icons.cancel_outlined;
          color = Colors.red.withOpacity(.8);
          break;
        case 7:
          icon = Icons.access_time;
          color = Colors.amber.withOpacity(.8);
          break;
      }
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ListTile(
              trailing: Icon(icon),
              title: Text('${S.current.order_status}: ${order.status.name}'),
              tileColor: color,
            ),
          ),
          if (order.status.id == 7)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ListTile(
                title: const Text('اضغط هنا لارفاق صورة الايصال البنكي'),
                onTap: () async {
                  final source = await showDialog<ImageSource>(
                    context: context,
                    useRootNavigator: true,
                    builder: (context) => SimpleDialog(
                      children: [
                        SimpleDialogOption(
                          onPressed: () => Navigator.of(context).pop(ImageSource.camera),
                          child: Row(
                            children: [
                              const Icon(Icons.camera_alt),
                              const SizedBox(width: 10),
                              Text(S.of(context).camera),
                            ],
                          ),
                        ),
                        SimpleDialogOption(
                          onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
                          child: Row(
                            children: [
                              const Icon(FontAwesomeIcons.images),
                              const SizedBox(width: 10),
                              Text(S.of(context).gallery),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );

                  if (source == null) return null;

                  final imageFile = await _imagePick(source);
                  if (imageFile == null) return;
                  final croppedImage = await _imageCrop(imageFile);
                  if (croppedImage == null) return;

                  final c = Helpers.showLoading(context);
                  try {
                    await post(
                      path: '/attached/${order.id}',
                      data: FormData.fromMap(
                        {'attached': await MultipartFile.fromFile(croppedImage.path)},
                      ),
                    );
                    AppRouter.sailor.navigate(
                      HomeScreen.routeName,
                      navigationType: NavigationType.pushAndRemoveUntil,
                      removeUntilPredicate: (_) => false,
                    );
                  } finally {
                    c.complete();
                  }
                },
              ),
            ),
        ],
      );
    }
    return CustomStepper(
      controlsBuilder: (context, {onStepCancel, onStepContinue}) => const SizedBox.shrink(),
      physics: const NeverScrollableScrollPhysics(),
      currentCustomStep: (order.status.id - 2 <= 0) ? 0 : order.status.id - 2,
      steps: buildSteps(),
    );
  }

  static Future<PickedFile> _imagePick(ImageSource source) => ImagePicker().getImage(
        source: source,
      );

  static Future<File> _imageCrop(PickedFile imageFile) => ImageCropper.cropImage(
        sourcePath: imageFile.path,
        androidUiSettings: const AndroidUiSettings(
          toolbarWidgetColor: Colors.white,
          backgroundColor: Colors.amber,
          toolbarColor: Colors.amber,
          lockAspectRatio: true,
        ),
        iosUiSettings: const IOSUiSettings(minimumAspectRatio: 1.0),
      );

  List<CustomStep> buildSteps() {
    final steps = <CustomStep>[];
    for (final status in StatusModel.statuses) {
      if (status.id == 2) continue;

      final bool isActive = (status.id == order.status.id) || (order.status.id == 2 && status.id == 1);

      steps.add(
        CustomStep(
          isActive: isActive,
          title: Text(status.name),
        ),
      );
    }
    return steps;
  }
}

extension on double {
  String format() {
    return toStringAsFixed(truncateToDouble() == this ? 0 : 2);
  }
}
