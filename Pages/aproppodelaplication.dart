import 'package:flutter/material.dart';

class aproppo extends StatelessWidget {
  const aproppo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("À propos de l'application",
          style: TextStyle(
              color: Colors.black87,
              fontStyle: FontStyle.italic,
              fontSize: 20),),
      ),
      body: Container(),
    );
  }
}

