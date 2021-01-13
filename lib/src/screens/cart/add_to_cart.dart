import 'package:cached_network_image/cached_network_image.dart';
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sehool/src/models/product_model.dart';
import 'pages/finish.dart';
import 'pages/notes.dart';
import 'pages/quantity.dart';
import 'pages/slicing_method.dart';

import '../../patched_components/stepper.dart';

class AddToCartScreen extends StatelessWidget {
  static const routeName = '/add_to_cart';

  const AddToCartScreen({
    Key key,
    @required this.product,
  }) : super(key: key);

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // pinned: true,
        // expandedHeight: 400,
        elevation: 0,
        backgroundColor: Colors.black54,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: const [
          DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.amber,
              image: DecorationImage(
                image: CachedNetworkImageProvider(
                  'https://i.pinimg.com/originals/77/59/a2/7759a2ff203398743fd020a4bedbff14.jpg',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: NewWidget(),
          ),
        ],
      ),
    );
  }
}

class NewWidget extends StatefulWidget {
  const NewWidget({
    Key key,
  }) : super(key: key);

  @override
  _NewWidgetState createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  int currentStep = 0;
  List<PatchedStep> get steps => [
        PatchedStep(
          isActive: 0 == currentStep,
          title: const Text('الكمية', style: TextStyle(color: Colors.white)),
          content: const QuantityPage(),
        ),
        PatchedStep(
          isActive: 1 == currentStep,
          title: const Text('طريقة التقطيع',
              style: TextStyle(color: Colors.white)),
          content: const SlicingMethodPage(),
        ),
        PatchedStep(
          isActive: 2 == currentStep,
          title: const Text('ملاحظات', style: TextStyle(color: Colors.white)),
          content: const NotesPage(),
        ),
        PatchedStep(
          isActive: 3 == currentStep,
          title: const Text('انهاء', style: TextStyle(color: Colors.white)),
          content: const FinishPage(),
        ),
      ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PatchedStepper(
            currentPatchedStep: currentStep,
            physics: const BouncingScrollPhysics(),
            onPatchedStepTapped: (value) => setState(() {
              currentStep = value;
            }),
            type: PatchedStepperType.horizontal,
            controlsBuilder: (context, {onStepCancel, onStepContinue}) =>
                const SizedBox.shrink(),
            patchedSteps: steps,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            children: <Widget>[
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                onPressed: currentStep == 0
                    ? null
                    : () {
                        setState(() {
                          currentStep--;
                        });
                      },
                child: Row(
                  children: const [
                    FaIcon(FontAwesomeIcons.chevronRight),
                    SizedBox(width: 10),
                    Text('السابق'),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                onPressed: currentStep == steps.length - 1
                    ? null
                    : () {
                        setState(() {
                          currentStep++;
                        });
                      },
                child: Row(
                  children: const [
                    Text('التالي'),
                    SizedBox(width: 10),
                    FaIcon(FontAwesomeIcons.chevronLeft),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 30),
            child: Card(
              color: Colors.white70,
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              child: ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    children: [
                      Text(faker.lorem.word()),
                      const Spacer(),
                      RatingBarIndicator(
                        rating: 2.75,
                        itemBuilder: (context, index) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 13.0,
                        // direction: Axis.vertical,
                      )
                    ],
                  ),
                ),
                subtitle: Text(faker.lorem.sentence() +
                    faker.lorem.sentence() +
                    faker.lorem.sentence() +
                    faker.lorem.sentence() +
                    faker.lorem.sentence() +
                    faker.lorem.sentence()),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: -10,
            child: CircleAvatar(
              radius: 30,
            ),
          )
        ],
      ),
    );
  }
}
