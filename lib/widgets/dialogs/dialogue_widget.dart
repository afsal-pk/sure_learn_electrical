import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dialogs {
  static final _singleton = Dialogs._internal();

  Dialogs._internal();

  factory Dialogs() {
    return _singleton;
  }

  static Widget questionStarDialogue({required VoidCallback onTap}) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Hi...",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text("Please login to continue"),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onTap,
          child: Text("OK"),
        )
      ],
    );
  }
}
