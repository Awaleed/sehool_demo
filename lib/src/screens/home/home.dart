import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sehool/src/screens/orders/orders.dart';
import 'package:sehool/src/screens/profile/pages/orders_history.dart';
import '../../../main.dart';
import '../../components/orders_list/orders_list_sliver.dart';
import '../../core/api_caller.dart';
import '../../models/order_model.dart';
import '../checkout/pages/payment_method_review.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../cubits/cart_cubit/cart_cubit.dart';
import '../../helpers/helper.dart';
import '../../routes/config_routes.dart';
import '../checkout/checkout.dart';
import 'pages/main.dart';
import 'pages/userpage.dart';
import 'pages/videos.dart';

ValueNotifier<int> selectedIndex = ValueNotifier(0);

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // PageController pageController;
  List<_TabBarItem> get pages => [
        _TabBarItem(
          icon: FluentIcons.home_24_regular,
          label: S.current.home,
          page: const MainPage(),
        ),
        _TabBarItem(
          icon: FluentIcons.cart_24_filled,
          label: S.current.about,
          page: const SizedBox.shrink(),
        ),
        _TabBarItem(
          icon: FluentIcons.cart_24_filled,
          label: S.current.cart,
          page: const SizedBox.shrink(),
        ),
        _TabBarItem(
          icon: FluentIcons.video_24_regular,
          label: S.current.watch,
          page: const VideosPage(),
        ),
        _TabBarItem(
          icon: FluentIcons.person_24_regular,
          label: S.current.profile,
          page: UserPage(),
        ),
      ];

  @override
  void initState() {
    super.initState();

    // pageController = PageController(initialPage: selectedIndex);
  }

  void onPageChanged(int index) {
    setState(() => selectedIndex.value = index);
    // pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    // if (!added) WidgetsBinding.instance.addPostFrameCallback((_) => insertOverlay(context));

    return WillPopScope(
        onWillPop: () => Helpers.onWillPop(context),
        child: Parent(
          style: ParentStyle()
            // ..linearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [
            //     Colors.black,
            //     Colors.amber,
            //     Colors.black,
            //   ],
            // ),
            ..background.color(Colors.white)
            ..background.image(path: 'assets/images/black.png', fit: BoxFit.contain),
          child: Scaffold(
            backgroundColor: Colors.white70,
            floatingActionButton: WhatsappFloatingActionButton(),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                color: Colors.black45,
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                ),
              ),
              child: FittedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildRange(0, 2),
                    _buildCartButton(),
                    _buildRange(3, 5),
                  ],
                ),
              ),
            ),
            body: Stack(
              fit: StackFit.expand,
              children: [
                // const DecoratedBox(
                // decoration: BoxDecoration(
                //   color: Colors.black45,
                //   gradient: LinearGradient(
                //     begin: Alignment.topCenter,
                //     end: Alignment.bottomCenter,
                //     colors: [
                //       Colors.black,
                //       Colors.amber,
                //       Colors.black,
                //     ],
                //   ),
                // ),
                // ),
                SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: IndexedStack(
                          sizing: StackFit.expand,
                          alignment: Alignment.center,
                          // physics: const NeverScrollableScrollPhysics(),
                          // controller: pageController,
                          index: selectedIndex.value,
                          children: [
                            ...pages.map((e) => e.page),
                          ],
                        ),
                        // ),
                        // Container(
                        //   decoration: const BoxDecoration(
                        //     color: Colors.black45,
                        //     gradient: LinearGradient(
                        //       begin: Alignment.bottomCenter,
                        //       end: Alignment.topCenter,
                        //       colors: [
                        //         Colors.black,
                        //         Colors.transparent,
                        //       ],
                        //     ),
                        //   ),
                        //   child: FittedBox(
                        //     child: Row(
                        //       mainAxisSize: MainAxisSize.min,
                        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //       children: [
                        //         _buildRange(0, 2),
                        //         _buildCartButton(),
                        //         _buildRange(3, 5),
                        //       ],
                        //     ),
                        //   ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildRange(int min, int max) {
    final list = <Widget>[];
    for (var i = min; i < max; i++) {
      final isSelected = selectedIndex.value == i;
      final item = pages[i];

      if (item.label == S.current.cart) {
        list.add(_buildCartButton());
        continue;
      } else if (item.label == S.current.about) {
        list.add(_buildMessageButton());
        continue;
      }
      final tab = Parent(
        gesture: Gestures()
          ..onTap(() {
            if (!isSelected) onPageChanged(i);
          }),
        style: ParentStyle()
          ..animate(600, Curves.easeOut)
          ..width(isSelected ? 130 : 70)
          ..background.color(isSelected ? Colors.black87 : Colors.transparent)
          ..padding(
            horizontal: 20,
            vertical: 10,
          )
          ..borderRadius(all: 50)
          ..alignmentContent.center(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              color: Colors.amber,
            ),
            if (isSelected)
              Flexible(
                child: FittedBox(
                  child: Text(
                    '  ${item.label}',
                    style: const TextStyle(
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
      list.add(tab);
    }
    return Row(children: list);
  }

  Widget _buildMessageButton() => Parent(
        gesture: Gestures()
          ..onTap(() async {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                clipBehavior: Clip.hardEdge,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                backgroundColor: Colors.white,
                title: Text(S.current.contact_us),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(
                        FontAwesomeIcons.whatsapp,
                        color: Color(
                          0xFF20b038,
                        ),
                      ),
                      title: const Text('Whatsapp'),
                      onTap: () {
                        launch('https://api.whatsapp.com/send?phone=966508808940');
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        FontAwesomeIcons.telegram,
                        color: Color(
                          0xFF289CDE,
                        ),
                      ),
                      title: const Text('Telegram'),
                      onTap: () {
                        launch('https://t.me/'); // TelegramFloatingActionButton
                      },
                    ),
                    ListTile(
                      leading: const Icon(FontAwesomeIcons.facebook),
                      title: const Text('Facebook'),
                      onTap: () => launchUrl('https://www.facebook.com/sehoool/'),
                    ),
                    ListTile(
                      leading: const Icon(FontAwesomeIcons.snapchat),
                      title: const Text('Snapchat'),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => Dialog(
                            clipBehavior: Clip.hardEdge,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            backgroundColor: Colors.transparent,
                            child: Image.asset('assets/images/snapchat.jpeg'),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(FontAwesomeIcons.instagram),
                      title: const Text('Instagram'),
                      onTap: () => launchUrl('https://www.instagram.com/sehoool/'),
                    ),
                    ListTile(
                      leading: const Icon(FontAwesomeIcons.twitter),
                      title: const Text('Twitter'),
                      onTap: () => launchUrl('https://twitter.com/sehoool/'),
                    ),
                  ],
                ),
              ),
            );
            // const url = "https://wa.me/249966787917?text=I'm redirected from sehool user app.";
            // if (await canLaunch(url)) {
            //   await launch(url);
            // }
          }),
        style: ParentStyle()
          ..animate(600, Curves.easeOut)
          ..width(70)
          ..background.color(Colors.transparent)
          ..padding(
            horizontal: 20,
            vertical: 10,
          )
          ..borderRadius(all: 50)
          ..alignmentContent.center(),
        child: const Icon(FontAwesomeIcons.shareAlt, color: Colors.amber),
      );
  Future<void> launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Widget _buildCartButton() => Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CartCubit, CartState>(
          cubit: getIt<CartCubit>(),
          builder: (context, state) => FloatingActionButton(
            elevation: 0,
            backgroundColor: Colors.transparent,
            // foregroundColor: Colors.transparent,
            onPressed: () {
              if (state.cart.cartItems.isNotEmpty) {
                AppRouter.sailor.navigate(CheckoutScreen.routeName);
              } else {
                Helpers.showMessageOverlay(
                  context,
                  message: S.current.dont_have_any_item_in_your_cart,
                );
              }
            },
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                const Icon(
                  FluentIcons.cart_24_filled,
                  color: Colors.amber,
                ),
                if (state.cart.cartItems.isNotEmpty)
                  Positioned(
                    top: -20,
                    left: -20,
                    right: -20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox.fromSize(
                          size: const Size.fromRadius(14),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              '${state.cart.cartItems.length}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.amber),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
}

class WhatsappFloatingActionButton extends StatelessWidget {
  const WhatsappFloatingActionButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // FloatingActionButton(
          //   heroTag: 'WhatsappFloatingActionButton',
          //   onPressed: () {
          // WhatsappFloatingActionButton
          //   },
          //   backgroundColor: Colors.transparent,
          //   foregroundColor: Colors.transparent,
          //   child: SvgPicture.asset('assets/images/whatsapp.svg'),
          //   // child: const Icon(
          //   //   FontAwesomeIcons.whatsapp,
          //   //   color: Color(
          //   //     0xFF20b038,
          //   //   ),
          //   // ),
          // ),
          const PinnedOrders(),
        ],
      ),
    );
  }
}

class _TabBarItem {
  final Widget page;
  final IconData icon;
  final String label;

  const _TabBarItem({this.page, this.icon, this.label});
}

class PinnedOrders extends StatefulWidget {
  const PinnedOrders({Key key}) : super(key: key);

  @override
  PinnedOrdersState createState() => PinnedOrdersState();
}

class PinnedOrdersState extends State<PinnedOrders> with ApiCaller {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'TelegramFloatingActionButton',
          onPressed: () {
            launch('https://t.me/'); // TelegramFloatingActionButton
          },
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          child: SvgPicture.asset('assets/images/telegram_104163.svg'),
          // child: const Icon(
          //   FontAwesomeIcons.whatsapp,
          //   color: Color(
          //     0xFF20b038,
          //   ),
          // ),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          heroTag: 'WhatsappFloatingActionButton',
          onPressed: () {
            launch('https://api.whatsapp.com/send?phone=966508808940');
            // WhatsappFloatingActionButton
          },
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,

          child: SvgPicture.asset('assets/images/iconfinder-whatsapp-4550867_121343.svg'),
          // child: const Icon(
          //   FontAwesomeIcons.whatsapp,
          //   color: Color(
          //     0xFF20b038,
          //   ),
          // ),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          heroTag: 'PinnedOrdersFloatingActionButton',
          onPressed: () {
            AppRouter.sailor.navigate(OrdersHistory.routeName);
            // showDialog(
            //   context: context,
            //   builder: (context) => AlertDialog(
            //     clipBehavior: Clip.hardEdge,
            //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            //     backgroundColor: Colors.white,
            //     contentPadding: EdgeInsets.zero,
            //     insetPadding: EdgeInsets.zero,
            //     title: Row(
            //       children: [
            //         Text(S.current.pinned_orders),
            //         const Spacer(),
            //         ElevatedButton(
            //           onPressed: () {
            //             showDialog(
            //               context: context,
            //               builder: (context) => BankInfoWidget(),
            //             );
            //           },
            //           child: Text(S.current.bank_info),
            //         ),
            //       ],
            //     ),
            //     content: SizedBox(
            //       width: MediaQuery.of(context).size.width * .9,
            //       height: MediaQuery.of(context).size.height * .9,
            //       child: OrdersListWidget(
            //         orders: snapshot.data,
            //         isLoading: false,
            //       ),
            //     ),
            //   ),
            // );
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset('assets/images/delivery.png'),
          ),
        ),
      ],
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FutureBuilder<List<OrderModel>>(
          future: () async {
            final List res = await get(path: '/pending/orders');
            return ApiCaller.listParser(res, (data) {
              data['total'] = double.tryParse('${data['total']}' ?? '');
              // data['lat'] = double.tryParse('${data['lat']}' ?? '');
              data['items'] = data['products'];
              // data['address'] = data['description'];
              if (data['address'] != null) {
                data['address']['lang'] = double.tryParse('${data['address']['lang']}' ?? '');
                data['address']['lat'] = double.tryParse('${data['address']['lat']}' ?? '');
                data['address']['note'] = data['address']['description'];
                data['address']['address'] = data['address']['description'];
              }
              return OrderModel.fromJson(data);
            });
          }(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // if (snapshot.data.isEmpty) {
              //   return const SizedBox.shrink();
              // }
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  FloatingActionButton(
                    heroTag: 'PinnedOrdersFloatingActionButton',
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                          backgroundColor: Colors.white,
                          contentPadding: EdgeInsets.zero,
                          insetPadding: EdgeInsets.zero,
                          title: Row(
                            children: [
                              Text(S.current.pinned_orders),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => BankInfoWidget(),
                                  );
                                },
                                child: Text(S.current.bank_info),
                              ),
                            ],
                          ),
                          content: SizedBox(
                            width: MediaQuery.of(context).size.width * .9,
                            height: MediaQuery.of(context).size.height * .9,
                            child: OrdersListWidget(
                              orders: snapshot.data,
                              isLoading: false,
                            ),
                          ),
                        ),
                      );
                    },
                    child: const Icon(FontAwesomeIcons.history),
                  ),
                  Positioned(
                    bottom: -10,
                    left: -10,
                    right: -10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox.fromSize(
                          size: const Size.fromRadius(14),
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: Text(
                              '${snapshot?.data?.length}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.amber),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return FloatingActionButton(
                heroTag: 'PinnedOrdersFloatingActionButton',
                onPressed: () {
                  // WhatsappFloatingActionButton
                },
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
