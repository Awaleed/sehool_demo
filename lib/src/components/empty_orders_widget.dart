import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class EmptyOrdersWidget extends StatelessWidget {
  const EmptyOrdersWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Colors.amber.withOpacity(0.3),
                      Colors.amber.withOpacity(0.2),
                    ])),
            child: Icon(
              FluentIcons.re_order_dots_24_regular,
              color: Theme.of(context).scaffoldBackgroundColor,
              size: 70,
            ),
          ),
          const SizedBox(height: 15),
          Opacity(
            opacity: 0.4,
            child: Text(
              S.current.dont_have_any_item_in_the_orders_list,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4.merge(
                  const TextStyle(
                      fontWeight: FontWeight.w300, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
