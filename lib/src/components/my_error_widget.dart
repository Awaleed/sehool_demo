import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    Key key,
    @required this.onRetry,
    @required this.message,
    this.buttonLabel,
  }) : super(key: key);

  final VoidCallback onRetry;
  final String message;
  final String buttonLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: Card(
          color: Theme.of(context).errorColor.withOpacity(.75),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(color: Colors.black),
                ),
                if (onRetry != null)
                  ElevatedButton(
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(
                        const Size.fromRadius(25),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                    ),
                    onPressed: onRetry,
                    child: Text(
                      buttonLabel ?? S.current.retry,
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          .copyWith(color: Colors.black),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
