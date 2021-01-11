import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:division/division.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Parent(
            style: ParentStyle()
              ..width(MediaQuery.of(context).size.width * 0.9)
              ..height(MediaQuery.of(context).size.height * 0.2)
              ..background.color(Colors.yellow),
            child: Center(
              child: Txt('banners'),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        SliverToBoxAdapter(
          child: CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              enlargeCenterPage: true,
              aspectRatio: 2.0,
            ),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Parent(
                    style: ParentStyle()
                      ..borderRadius(all: 10)
                      ..width(MediaQuery.of(context).size.width * 0.85)
                      ..background.color(Colors.black),
                    child: Image.asset('assets/logo.png'),
                  );
                },
              );
            }).toList(),
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        SliverToBoxAdapter(
          child: CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              enlargeCenterPage: true,
              scrollDirection: Axis.vertical,
            ),
            items: [1, 2, 3, 4, 5].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Parent(
                    style: ParentStyle()
                      ..borderRadius(all: 10)
                      ..width(MediaQuery.of(context).size.width * 0.85)
                      ..background.color(Colors.black),
                    child: Image.asset('assets/logo.png'),
                  );
                },
              );
            }).toList(),
          ),
        )
      ],
    );
  }
}
