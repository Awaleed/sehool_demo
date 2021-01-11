import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: TimelineTile(
                      axis: TimelineAxis.horizontal,
                      alignment: TimelineAlign.end,
                      isFirst: true,
                      startChild: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Icon(
                          Icons.car_rental,
                          color: Colors.green,
                        ),
                      )),
                ),
                TimelineTile(
                  axis: TimelineAxis.horizontal,
                  alignment: TimelineAlign.end,
                  startChild: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Icon(
                      Icons.house,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Expanded(
                  child: TimelineTile(
                    axis: TimelineAxis.horizontal,
                    alignment: TimelineAlign.end,
                    isLast: true,
                    startChild: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Parent(
              style: ParentStyle()
                ..border(all: 1, color: Colors.grey)
                ..borderRadius(all: 10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Txt(
                                'order id',
                                style: TxtStyle()
                                  ..bold()
                                  ..textAlign.start(),
                              ),
                              Txt(
                                '1232432FDs',
                                style: TxtStyle()
                                  ..textAlign.start()
                                  ..textColor(Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Txt(
                                'date',
                                style: TxtStyle()
                                  ..bold()
                                  ..textAlign.start(),
                              ),
                              Txt(
                                '1232432FDs',
                                style: TxtStyle()
                                  ..textAlign.start()
                                  ..textColor(Colors.grey),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Txt(
                                'count',
                                style: TxtStyle()
                                  ..bold()
                                  ..textAlign.start(),
                              ),
                              Txt(
                                '33',
                                style: TxtStyle()
                                  ..textAlign.start()
                                  ..textColor(Colors.grey),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Txt(
                                'ricive date',
                                style: TxtStyle()
                                  ..bold()
                                  ..textAlign.start(),
                              ),
                              Txt(
                                '22/1',
                                style: TxtStyle()
                                  ..textAlign.start()
                                  ..textColor(Colors.grey),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RaisedButton(
                      color: Colors.white,
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.black)),
                      child: Txt('cancel'),
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 13,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.grey,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Txt('name'),
                                SizedBox(
                                  width: 30,
                                ),
                                Txt('quantty'),
                                SizedBox(
                                  width: 30,
                                ),
                                Txt('cutting style')
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
