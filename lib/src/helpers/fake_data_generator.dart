import 'package:faker/faker.dart';
import 'package:sehool/src/models/banner_model.dart';
import 'package:sehool/src/models/video_model.dart';

import '../models/address_model.dart';
import '../models/order_model.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';
import 'package:supercharged/supercharged.dart';

abstract class FakeDataGenerator {
  static SlicingMethodModel get slicingMethodsModel => SlicingMethodModel(
        id: random.integer(1000),
        name: faker.lorem.word(),
      );
  static BannerModel get bannerModel => BannerModel(
        id: random.integer(1000),
        image: faker.lorem.word(),
      );
  static VideoModel get videoModel => VideoModel(
        id: random.integer(1000),
        title: faker.lorem.word(),
        description: faker.lorem.sentence(),
        preview: faker.image.image(),
        video:
            'https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4',
      );

  static PaymentMethodModel get paymentMethodsModel => PaymentMethodModel(
        id: random.integer(1000),
        name: faker.lorem.word(),
      );

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
        image: faker.image.image(),
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
        city: cityModel,
        name: faker.address.neighborhood(),
      );
  static ProductModel get productModel => ProductModel(
        id: random.integer(1000),
        name: faker.person.name(),
        image: faker.image.image(),
        description: faker.lorem.sentence(),
        price: (random.decimal(scale: 100000) * 100).toInt() / 100,
        qyt: random.integer(1000),
      );
  static ReviewModel get reviewModel => ReviewModel(
        id: random.integer(1000),
        rating: random.integer(5),
        comment: faker.lorem.sentence(),
        createdAt: DateTime.now().subtract(random.integer(1000).hours),
        user: userModel,
      );
}
