import 'package:cached_network_image/cached_network_image.dart';
import 'package:division/division.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/l10n.dart';
import '../../../init_injectable.dart';
import '../../cubits/cart_cubit/cart_cubit.dart';
import '../../routes/config_routes.dart';
import '../checkout/checkout.dart';
import 'pages/main.dart';
import 'pages/profile.dart';
import 'pages/videos.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex;
  PageController pageController;
  List<_TabBarItem> get pages => [
        _TabBarItem(
          icon: FluentIcons.home_24_regular,
          label: S.current.home,
          page: const MainPage(),
        ),
        _TabBarItem(
          icon: FluentIcons.cart_24_filled,
          label: S.current.cart,
        ),
        _TabBarItem(
          icon: FluentIcons.video_24_regular,
          label: S.current.watch,
          page: const VideosPage(),
        ),
        _TabBarItem(
          icon: FluentIcons.person_24_regular,
          label: S.current.profile,
          page: const ProfilePage(),
        ),
      ];

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    pageController = PageController(initialPage: selectedIndex);
  }

  void onPageChanged(int index) {
    setState(() => selectedIndex = index);
    pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  'https://i.pinimg.com/originals/77/59/a2/7759a2ff203398743fd020a4bedbff14.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.black45,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.amber,
                  Colors.black,
                ],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    children: [...pages.map((e) => e.page)],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
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
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      // mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        ...() {
                          final list = <Widget>[];
                          for (var i = 0; i < pages.length; i++) {
                            final isSelected = selectedIndex == i;
                            final item = pages[i];

                            if (item.page == null) {
                              list.add(_buildCartButton());
                              continue;
                            }
                            final tab = Parent(
                              gesture: Gestures()
                                ..onTap(() {
                                  if (!isSelected) onPageChanged(i);
                                }),
                              style: ParentStyle()
                                ..animate(600, Curves.easeOut)
                                ..width(isSelected ? 150 : 70)
                                ..background.color(isSelected
                                    ? Colors.black87
                                    : Colors.transparent)
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
                                    color: isSelected
                                        ? Colors.amber
                                        : Colors.white,
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
                          return list;
                        }()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartButton() => BlocBuilder<CartCubit, CartState>(
        cubit: getIt<CartCubit>(),
        builder: (context, state) => FloatingActionButton(
          onPressed: () {
            if (state.cart.cartItems.isNotEmpty) {
              AppRouter.sailor.navigate(CheckoutScreen.routeName);
            }
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(FluentIcons.cart_24_filled),
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
      );
}

class _TabBarItem {
  final Widget page;
  final IconData icon;
  final String label;

  const _TabBarItem({this.page, this.icon, this.label});
}
