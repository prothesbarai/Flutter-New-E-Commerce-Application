import 'package:flutter/material.dart';


class ExitConfirmationWrapper extends StatelessWidget{
  final Widget child;
  final String title;
  final String message;
  final String confirmText;
  final String cancelText;

  const ExitConfirmationWrapper({
    super.key,
    required this.child,
    required this.title,
    required this.message,
    required this.confirmText,
    required this.cancelText,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        child: child,
        onWillPop: () async {
          bool shouldExit = await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(title),
                content: Text(message,maxLines: 1,),
                actions: [
                  TextButton(onPressed: () => Navigator.of(context).pop(false), child: Text(cancelText)),
                  TextButton(onPressed: () => Navigator.of(context).pop(true), child: Text(confirmText)),
                ],
              ),
          );
          return shouldExit;
        }
    );
  }

}

