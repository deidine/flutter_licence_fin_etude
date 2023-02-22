// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';

class UserName extends StatelessWidget {
  UserName({Key? key}) : super(key: key);
  final _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Enter your name"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 55),
              child: CupertinoTextField(
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25),
                maxLength: 25,
                controller: _text,
                keyboardType: TextInputType.name,
                autofillHints: const <String>[AutofillHints.name],
              ),
            )


    ],));
  }
}
