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
    'https://r4---sn-5hnekn7z.googlevideo.com/videoplayback?expire=1610679012&ei=hK4AYNKqMs6z-gb22Co&ip=212.102.39.72&id=o-AH0EHpTNKxUOdu38e55NBWNVBlkvCwatqG_sk6HOlNYa&itag=18&source=youtube&requiressl=yes&vprv=1&mime=video%2Fmp4&ns=lGvIvqI88TqhuF1UzA1IrGgF&gir=yes&clen=20443066&ratebypass=yes&dur=238.956&lmt=1584020831932064&fvip=4&c=WEB&txp=6216222&n=-kISEdhqJPdfNK&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cvprv%2Cmime%2Cns%2Cgir%2Cclen%2Cratebypass%2Cdur%2Clmt&sig=AOq0QJ8wRQIgfDu5WN_R1qYUyrihoUav2ss9H2_yEE6i4-NNdMyTD9YCIQCoxEB8pXyTpVLSWs8u4bvKKubZ0rb0BKK9lxqVpwJwkg%3D%3D&rm=sn-n02xgoxufvg3-2gbz7k&req_id=f097a2cdc10aa3ee&redirect_counter=2&cm2rm=sn-2gbe67z&cms_redirect=yes&mh=dG&mip=89.38.97.132&mm=34&mn=sn-5hnekn7z&ms=ltu&mt=1610657078&mv=m&mvi=4&pl=24&lsparams=mh,mip,mm,mn,ms,mv,mvi,pl&lsig=AG3C_xAwRgIhAJmoC6vjkpQEUIuebVV0zU6bUIFRluAbK2bTz_4ugQNNAiEAsEbAgDBPZsTh5ZP7pnjq8DGCq-sECqUNSiuMK27w5Zg%3D',
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
