import 'dart:math';

import 'package:faker/faker.dart';
// ignore: implementation_imports
import 'package:faker/src/lorem.dart';
// ignore: implementation_imports
import 'package:faker/src/person.dart';
import 'package:supercharged/supercharged.dart';

import '../models/address_model.dart';
import '../models/banner_model.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';
import '../models/user_model.dart';
import '../models/video_model.dart';

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
        id: 0,
        name: faker.person.arabicName(),
        email: faker.internet.email(),
        level: UserLevel.values.random,
        phone: '${random.integer(4294967296)}',
        image: images.random,
        wallet: (random.decimal(scale: 100000) * 100).toInt() / 100,
      );

  static AddressModel get addressModel => AddressModel(
        id: random.integer(1000),
        city: cityModel,
        section: citySectionModel,
        lat: -90 + random.decimal(scale: 180),
        lang: -90 + random.decimal(scale: 180),
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
        // rating: random.integer(5),
        comment: faker.lorem.sentence(),
        createdAt: DateTime.now().subtract(random.integer(1000).hours),
        user: userModel,
      );
  // static OrderModel get orderModel => OrderModel(
  //       cartItems: List.generate(3, (_) => cartItemModel),
  //       orderDate: DateTime.now().subtract(random.integer(1000).hours),
  //       address: addressModel,
  //       pickupMethod: PickupMethod.values.random,
  //       type: OrderType.values.random,
  //       paymentMethod: PaymentMethodType.values.random,
  //       notes: faker.lorem.sentence(),
  //     );
  static CartItemModel get cartItemModel => CartItemModel()
    // ..note = faker.lorem.sentence()
    ..product = productModel
    ..slicingMethod = slicingMethodsModel;

  static List<SlicingMethodModel> get slicingMethods => [
        const SlicingMethodModel(
          id: 0,
          name: 'كامل',
        ),
        const SlicingMethodModel(
          id: 1,
          name: 'تقطيع ثلاجة',
        ),
        const SlicingMethodModel(
          id: 3,
          name: 'ارباع',
        ),
      ];
  static List<AddressModel> get addresses => [
        const AddressModel(
          id: 0,
          address: 'مخرج 28',
          city: CityModel(
            id: 0,
            name: 'الرياض',
          ),
          section: CitySectionModel(
            id: 0,
            name: 'العريجاء الغربي',
          ),
          lang: 0,
          lat: 0,
        ),
        const AddressModel(
          id: 1,
          address: 'شارع الملك عبداالله',
          city: CityModel(
            id: 0,
            name: 'الرياض',
          ),
          section: CitySectionModel(
            id: 1,
            name: 'العلياء',
          ),
          lang: 0,
          lat: 0,
        ),
      ];
  static List<ReviewModel> get reviews => List.generate(
        random.integer(50),
        (index) => ReviewModel(
          id: index,
          // rating: random.(5),
          comment: faker.lorem.arabic(),
          createdAt: DateTime.now().subtract(random.integer(1000).hours),
          user: userModel,
        ),
      );

  static List<ProductModel> get products => [
        ProductModel(
          id: 0,
          name: 'تني',
          image: images.random,
          description: faker.lorem.arabic(),
          price: 130,
          qyt: 1000,
        ),
        ProductModel(
          id: 1,
          name: 'جدع',
          image: images.random,
          description: faker.lorem.arabic(),
          price: 140,
          qyt: 1000,
        ),
        ProductModel(
          id: 2,
          name: 'رباع',
          image: images.random,
          description: faker.lorem.arabic(),
          price: 150,
          qyt: 1000,
        ),
      ];
}

extension on List {
  dynamic get random => this[Random().nextInt(length)];
}

extension on Lorem {
  String arabic() {
    return [
      'لوريم ايبسوم دولار سيت أميت ,كونسيكتيتور أدايبا يسكينج أليايت,سيت دو أيوسمود تيمبور أنكايديديونتيوت لابوري ات دولار ماجنا أليكيوا . يوت انيم أد مينيم فينايم,كيواس نوستريد أكسير سيتاشن يللأمكو لابورأس نيسي يت أليكيوب أكس أيا كوممودو كونسيكيوات . ديواس أيوتي أريري دولار إن ريبريهينديرأيت فوليوبتاتي فيلايت أيسسي كايلليوم دولار أيو فيجايت نيولا باراياتيور. أيكسسيبتيور ساينت أوككايكات كيوبايداتات نون بروايدينت ,سيونت ان كيولبا كيو أوفيسيا ديسيريونتموليت انيم أيدي ايست لابوريوم.',
      'سيت يتبيرسبايكياتيس يوندي أومنيس أستي ناتيس أيررور سيت فوليبتاتيم أكيسأنتييوم دولاريمكيو لايودانتيوم,توتام ريم أبيرأم,أيكيو أبسا كيواي أب أللو أنفينتوري فيرأتاتيس ايت كياسي أرشيتيكتو بيتاي فيتاي ديكاتا سيونت أكسبليكابو. نيمو أنيم أبسام فوليوباتاتيم كيواي فوليوبتاس سايت أسبيرناتشر أيوت أودايت أيوت فيوجايت, سيد كيواي كونسيكيونتشر ماجناي دولارس أيوس كيواي راتاشن فوليوبتاتيم سيكيواي نيسكايونت. نيكيو بوررو كيوايسكيوم ايست,كيواي دولوريم ايبسيوم كيوا دولار سايت أميت, كونسيكتيتيور,أديبايسكاي فيلايت, سيد كيواي نون نيومكيوام ايايوس موداي تيمبورا انكايديونت يوت لابوري أيت دولار ماجنام ألايكيوام كيوايرات فوليوبتاتيم. يوت اينايم أد مينيما فينيام, كيواس نوستريوم أكسيركايتاشيم يلامكوربوريس سيوسكايبيت لابورايوسام, نايساي يوت ألايكيوايد أكس أيا كوموداي كونسيكيواتشر؟ كيوايس أيوتيم فيل أيوم أيوري ريبريهينديرايت كيواي ان إيا فوليوبتاتي فيلايت ايسسي كيوم نايهايل موليستايا كونسيكيواتيو,فيلايليوم كيواي دولوريم أيوم فيوجايات كيو فوليوبتاس نيولا باراياتيور؟',
      ' أت فيرو ايوس ايت أكيوساميوس ايت أيوستو أودايو دايجنايسسايموس ديوكايميوس كيواي بلاندايتاييس برايسينتايوم فوليوبتاتيوم ديلينايتاي أتكيوي كورريوبتاي كيوأوس دولوريس أيت سيما يليكيوسيونت ان كيولبا كيواي أوفايكيا ديسيريونت موللايتايا انايماي, أيدي ايست لابوريوم دايستا ينستايو. نام لايبيرو تيمبور, كيوم سوليوتا نوبايس ايست ايلاجينداي أوبتايو كيومكيوي نايهايل ايمبيدايت كيو ماينيوس ايدي كيوود ماكسهيمي بلاسايت فاسيري بوسسايميوس,أومنايس فوليوبتاس ايت ايوت أسسيو ميندايست, أومنيوس دولار ريبيللينديوس. تيمبورايبيوس أيوتيم كيواس موليستاياس أكسكيبتيوراي ساينت أوككايكاتاي كيبايدايتات نون بروفايدنت أيت دولوريوم فيوجا.ايت هاريوم كيوايديم ريريوم فاكايلايسايست ايت أكسبيدايتا كيوايبيوسدام ايت أوت أوففايكايس ديبايتايس أيوت ريريوم نيسيسسايتاتايبيوس سايبي ايفينايت يوت ايت فوليبتاتيس  ريبيودايايانداي ساينت ايت موليسفاياي نون ريكيوسانداي.اتاكيوي ايريوم ريريوم هايس تينيتور أ ساباينتي ديليكتيوس, يوت أيوت رياسايندايس فوليوبتاتايبص مايوريس ألايس كونسيكيواتور أيوت بيرفيريندايس دولورايبيوس أسبيرايوريس ريبيللات .',
    ].random;
  }
}

extension on Person {
  String arabicName() {
    return [
      'آية',
      'أسيل',
      'أمينة',
      'سمية',
      'اسراء',
      'إيمان',
      'إيناس',
      'السعدية',
      'بحرية',
      'بشرى',
      'بثينة',
      'جيداء',
      'حفصة',
      'حليمة',
      'داليا',
      'رامة',
      'رغد',
      'رفيف',
      'رقية',
      'رنا',
      'ريحانة',
      'زينب',
      'سارة',
      'سعيدة',
      'سلمى',
      'سلوى',
      'سمراء',
      'سميرة',
      'سها',
      'شيماء',
      'عائشة',
      'عبير',
      'غادة',
      'غيداء',
      'فاطمة',
      'فتيحة',
      'فرح',
      'كنزى',
      'لميس',
      'لولوه',
      'ليلى',
      'مبروكة',
      'مروة',
      'مروى',
      'مناصف',
      'منى',
      'مها',
      'مهيبة',
      'ميا',
      'ميساء',
      'ميمونة',
      'نادية',
      'نادين',
      'ندى',
      'نجلاء',
      'نورا',
      'هاجر',
      'هند',
      'هيفاء',
      'يارا',
      'ياسمين',
      'أبو بكر',
      'أجود',
      'أحمد',
      'أحنف',
      'أدهم',
      'أيوب',
      'إياد',
      'بدر',
      'بلال',
      'جعفر',
      'حسن',
      'حسين',
      'حكيم',
      'راكان',
      'رضوان',
      'زبير',
      'سلام',
      'صباح',
      'صلاح الدين',
      'طارق',
      'عارف',
      'عاطف',
      'عباس',
      'عبد الستار',
      'عبد المجيد',
      'عرقوب',
      'عزيز',
      'عفيف',
      'عكرمة',
      'علاء',
      'علي',
      'عمر',
      'عمرو',
      'فاروق',
      'فهد',
      'فيصل',
      'كنان',
      'لطيف',
      'محمد',
      'محمد علي',
      'محمود',
      'مروان',
      'مسلم',
      'مصطفى',
      'ملحم',
      'مهند',
      'ميثم',
      'ناصيف',
      'نجم الدين',
      'نعمان',
      'نعمة الله',
      'هاشم',
      'هشام',
      'هيثم',
      'ولاء الدين',
      'نور',
      'اسلام',
      'تحاسين',
      'نضال',
      'تحرير',
      'جهاد',
      'تمام',
      'نهاد',
      'حماس',
      'سهيل',
      'حياتي',
      'رجاء',
      'عفلق',
      'رماح',
      'غدق',
      'سرور',
      'مكارم',
      'سلام',
    ].random;
  }
}
