import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sailor/sailor.dart';
import '../../core/api_caller.dart';
import '../../helpers/helper.dart';
import '../../patched_components/custom_stepper.dart';
import '../../routes/config_routes.dart';
import '../../screens/home/home.dart';

import '../../../generated/l10n.dart';
import '../../models/order_model.dart';

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
                    // style: Theme.of(context).textTheme.headline5,
                  ),
                  const Spacer(),
                  Text(
                    ' ${DateFormat.yMEd().format(cart.createdAt)}',
                    // style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
            ),
            const Divider(),
            // Text(
            //   '${S.current.order_status}: ${cart.status.name}',
            //   // style: Theme.of(context).textTheme.headline5,
            // ),
            OrderStatusWidget(order: cart),

            const Divider(),
            if (cart.products?.isNotEmpty ?? false)
              ...cart.products.map(
                (e) => ListTile(
                  title: Text(e.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        '${e.qyt} ${S.current.piece}, ${e.slicerType}',
                      ),
                      Text(
                        '${S.current.notes}: ${e.note ?? S.current.none}',
                      ),
                    ],
                  ),
                  trailing: Text('${e.subtotal.format()} ﷼'),
                ),
              ),
            const Divider(),
            // Text(
            //   S.current.notes,
            //   style: Theme.of(context).textTheme.headline5,
            // ),
            ListTile(
              title: Text(S.current.notes),
              subtitle: Text(cart.note ?? S.current.none),
            ),
            // const Divider(),
            // Card(
            //   elevation: 2,
            //   clipBehavior: Clip.hardEdge,
            //   margin: EdgeInsets.zero,
            //   color: Colors.white70,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(25),
            //   ),
            //   child: ListTile(
            //     title: Text(cart.note ?? S.current.none),
            //   ),
            // ),
            // const Divider(),
            // Text(
            //   S.current.shipping_address,
            //   style: Theme.of(context).textTheme.headline5,
            // ),
            // const Divider(),
            // Card(
            //   elevation: 2,
            //   clipBehavior: Clip.hardEdge,
            //   margin: EdgeInsets.zero,
            //   color: Colors.white70,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(25),
            //   ),
            //   child: Column(
            //     children: [
            //       ListTile(
            //         title: Text(S.current.cites),
            //         subtitle: Text(cart.address?.city?.name ?? S.current.none),
            //       ),
            //       ListTile(
            //         title: Text(S.current.neighborhood),
            //         subtitle: Text(cart.address?.section?.name ?? S.current.none),
            //       ),
            //       ListTile(
            //         title: Text(S.current.address),
            //         subtitle: Text(cart.address?.address ?? S.current.none),
            //       ),
            //     ],
            //   ),
            // ),
            // const Divider(),
            // Text(
            //   S.current.total,
            //   style: Theme.of(context).textTheme.headline5,
            // ),
            ListTile(
              title: Text(S.current.total),
              subtitle: Text('${cart.total.format()} ﷼'),
            ),
            // const Divider(),
            // Card(
            //   elevation: 2,
            //   clipBehavior: Clip.hardEdge,
            //   margin: EdgeInsets.zero,
            //   color: Colors.white70,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(25),
            //   ),
            //   child: ListTile(
            //     title: Text('${cart.total} ﷼'),
            //   ),
            // ),
            // const Divider(),
            // Text(
            //   S.current.payment_mode,
            //   style: Theme.of(context).textTheme.headline5,
            // ),
            // const Divider(),
            ListTile(
              title: Text(S.current.payment_mode),
              subtitle: Text(cart.payment),
            ),

            // Card(
            //   elevation: 2,
            //   clipBehavior: Clip.hardEdge,
            //   margin: EdgeInsets.zero,
            //   color: Colors.white70,
            //   shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(25),
            //   ),
            //   child: ListTile(title: Text(cart.payment ?? '')),
            // ),
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
      return Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ListTile(
              trailing: Icon(order.status.id == 7 ? Icons.access_time : Icons.cancel_outlined),
              title: Text('${S.current.order_status}: ${order.status.name}'),
              tileColor: order.status.id == 7 ? Colors.amber.withOpacity(.8) : Colors.red.withOpacity(.8),
            ),
          ),
          if (order.status.id == 7)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ListTile(
                title: Text('اضغط هنا لارفاق صورة الايصال البنكي'),
                onTap: () async {
                  final source = await showDialog<ImageSource>(
                    context: context,
                    useRootNavigator: true,
                    child: SimpleDialog(
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
                  } catch (e) {} finally {
                    c.complete();
                  } // showDialog(
                  //   context: context,
                  //   builder: (context) => AlertDialog(
                  //     clipBehavior: Clip.hardEdge,
                  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  //     backgroundColor: Colors.white,
                  //     contentPadding: EdgeInsets.zero,
                  //     insetPadding: EdgeInsets.zero,
                  //     title: Text(S.current.pinned_orders),
                  //     content: SizedBox(
                  //       width: MediaQuery.of(context).size.width * .9,
                  //       height: MediaQuery.of(context).size.height * .9,
                  //     ),
                  //   ),
                  // );
                },
              ),
            ),
        ],
      );
    }
    return CustomStepper(
      controlsBuilder: (context, {onStepCancel, onStepContinue}) => const SizedBox.shrink(),
      physics: const NeverScrollableScrollPhysics(),
      currentCustomStep: order.status.id - 1,
      steps: [
        ...StatusModel.statuses.map(
          (e) => CustomStep(
            isActive: e.id == order.status.id,
            title: Text(e.name),
          ),
        ),
      ],
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final status in StatusModel.statuses)
          ListTile(
            title: Text(status.name),
            leading: Container(
              height: 30,
              width: 30,
              alignment: Alignment.center,
              decoration: const BoxDecoration(color: Colors.amber),
              child: Text('${status.id}'),
            ),
          ),
      ],
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
}

extension on double {
  String format() {
    return toStringAsFixed(truncateToDouble() == this ? 0 : 2);
  }
}
