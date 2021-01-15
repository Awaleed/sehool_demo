import 'dart:math';

import 'package:faker/faker.dart';
import '../models/banner_model.dart';
import '../models/cart_model.dart';
import '../models/video_model.dart';

import '../models/address_model.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';
import 'package:supercharged/supercharged.dart';

abstract class FakeDataGenerator {
  static const List videos = [
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4',
  ];
  static const List images = [
    'https://images.unsplash.com/photo-1544025162-d76694265947?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=749&q=80',
    'https://images.unsplash.com/photo-1508615263227-c5d58c1e5821?ixid=MXwxMjA3fDB8MHxzZWFyY2h8MTA5fHxtZWF0JTIwbWVhbHxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60',
  ];

  static const List names = [
    'تني',
    'جدع',
    'رباع',
  ];

  static SlicingMethodModel get slicingMethodsModel => SlicingMethodModel(
        id: random.integer(1000),
        name: faker.lorem.word(),
      );
  static BannerModel get bannerModel => BannerModel(
        id: random.integer(1000),
        image: images.random,
      );
  static VideoModel get videoModel => VideoModel(
        id: random.integer(1000),
        title: faker.lorem.word(),
        description: faker.lorem.sentence(),
        preview: images.random,
        video: videos.random,
      );

  // static PaymentMethodModel get paymentMethodsModel => PaymentMethodModel(
  //       id: random.integer(1000),
  //       name: faker.lorem.word(),
  //     );

  static UserWithTokenModel get userWithTokenModel => UserWithTokenModel(
        accessToken: AccessTokenModel(token: faker.guid.guid()),
        user: userModel,
      );

  static UserModel get userModel => UserModel(
        id: random.integer(1000),
        name: faker.person.name(),
        email: faker.internet.email(),
        level: 'user',
        phone: '${random.integer(4294967296)}',
        image: images.random,
        wallet: (random.decimal(scale: 100000) * 100).toInt() / 100,
      );

  static AddressModel get addressModel => AddressModel(
        id: random.integer(1000),
        city: cityModel,
        citySection: citySectionModel,
        lat: -90 + random.decimal(scale: 180),
        lang: -90 + random.decimal(scale: 180),
        note: faker.lorem.sentence(),
        address: faker.address.streetAddress(),
      );
  static CityModel get cityModel => CityModel(
        id: random.integer(1000),
        name: faker.address.city(),
      );

  static CitySectionModel get citySectionModel => CitySectionModel(
        id: random.integer(1000),
        name: faker.address.neighborhood(),
      );
  static ProductModel get productModel => ProductModel(
        id: random.integer(1000),
        name: names.random,
        image: images.random,
        description: faker.lorem.sentence(),
        price: ((random.decimal(scale: 100) * 100) + 100).toInt() / 100,
        qyt: random.integer(1000),
      );
  static ReviewModel get reviewModel => ReviewModel(
        id: random.integer(1000),
        rating: random.integer(5),
        comment: faker.lorem.sentence(),
        createdAt: DateTime.now().subtract(random.integer(1000).hours),
        user: userModel,
      );
  static OrderModel get orderModel => OrderModel(
        cartItems: List.generate(3, (_) => cartItemModel),
        orderDate: DateTime.now().subtract(random.integer(1000).hours),
        address: addressModel,
        pickupMethod: PickupMethod.values.random,
        type: OrderType.values.random,
        paymentMethod: PaymentMethodType.values.random,
        notes: faker.lorem.sentence(),
      );
  static CartItemModel get cartItemModel => CartItemModel()
    ..notes = faker.lorem.sentence()
    ..product = productModel
    ..slicingMethod = slicingMethodsModel;
}

extension on List {
  get random => this[Random().nextInt(this.length)];
}
