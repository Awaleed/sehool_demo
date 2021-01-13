import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehool/init_injectable.dart';
import 'package:sehool/src/cubits/cart_cubit/cart_cubit.dart';
import 'package:supercharged/supercharged.dart';

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
  List<_TabBarItem> pages;
  PageController pageController;

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
    pageController = PageController(initialPage: selectedIndex);
    pages = const [
      _TabBarItem(
        icon: FluentIcons.home_24_regular,
        label: 'الرئيسية',
        page: MainPage(),
      ),
      _TabBarItem(
        icon: FluentIcons.video_24_regular,
        label: 'شاهد',
        page: VideosPage(),
      ),
      _TabBarItem(
        icon: FluentIcons.person_24_regular,
        label: 'ملفي',
        page: ProfilePage(),
      ),
    ];
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
              children: [
                Expanded(
                    child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    ...pages.map((e) => e.page),
                  ],
                )),
                BlocBuilder<CartCubit, CartState>(
                  cubit: getIt<CartCubit>(),
                  builder: (context, state) {
                    if (state.cart.cartItems.isEmpty) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          FloatingActionButton.extended(
                            onPressed: () => AppRouter.sailor
                                .navigate(CheckoutScreen.routeName),
                            label: Text(
                              '${state.cart.cartItems.length} منتجات في السلة',
                            ),
                            icon: const Icon(FluentIcons.cart_24_filled),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 75,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ...() {
                          final list = <Widget>[];
                          for (var i = 0; i < pages.length; i++) {
                            final isSelected = selectedIndex == i;
                            final item = pages[i];
                            final widget = GestureDetector(
                              onTap: () {
                                if (!isSelected) onPageChanged(i);
                              },
                              child: AnimatedContainer(
                                duration: 600.milliseconds,
                                curve: Curves.easeOut,
                                width: isSelected ? 150 : 70,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.black87
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(25),
                                ),
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
                              ),
                            );
                            list.add(widget);
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
}

class _TabBarItem {
  final Widget page;
  final IconData icon;
  final String label;

  const _TabBarItem({this.page, this.icon, this.label});
}
