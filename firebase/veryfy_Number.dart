// ignore_for_file: no_logic_in_create_state, prefer_typing_uninitialized_variables, constant_identifier_names

import 'package:awn_stage2/firebase/user_Name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum Status { Wating, Error }

class VerifyNumber extends StatefulWidget {
  const VerifyNumber({Key? key, this.number}) : super(key: key);
  final number;
  @override
  _VerifyNumberState createState() => _VerifyNumberState(number);
}

class _VerifyNumberState extends State<VerifyNumber> {
  final phoneNumber;
  var _status = Status.Wating;
  var _verificationId;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _textEditingController = TextEditingController();
  _VerifyNumberState(this.phoneNumber);

  @override
  void initState() {
    _verifyPhoneNumber();
    super.initState();
  }

  Future _verifyPhoneNumber() async {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (phonesCuthCredentials) async {},
        verificationFailed: (verificationFailed) async {},
        codeSent: (verificationId, resendingToken) async {
          setState(() {
            _verificationId = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (verificationId) async {});
  }

  Future _sendCodeToFirebase({String? code}) async {
    if (_verificationId != null) {
      var credential = PhoneAuthProvider.credential(
          verificationId: _verificationId, smsCode: code!);
      await _auth
          .signInWithCredential(credential)
          .then((value) {
            Navigator.push(context, CupertinoPageRoute(builder: (context)=>UserName()));
      })
          .whenComplete(() {})
          .onError((error, stackTrace) {
            setState(() {
              _textEditingController.text = "";
              _status = Status.Error;
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("Verify Number"),
          previousPageTitle: "Edit Number",
        ),
        child: _status == Status.Error
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "OTP Verification",
                      style: TextStyle(
                          color: Colors.green.withOpacity(0.7), fontSize: 30),
                    ),
                  ),
                  const Text(
                    "Enter OTP sent to",
                    style: TextStyle(
                        color: CupertinoColors.secondaryLabel, fontSize: 20),
                  ),
                  Text(phoneNumber ?? ""),
                  CupertinoTextField(
                    onChanged: (value) async {
                      print(value);
                      if (value.length == 6) {
                        _sendCodeToFirebase(code: value);

                      }
                    },
                    textAlign: TextAlign.center,
                    style: const TextStyle(letterSpacing: 30, fontSize: 30),
                    maxLength: 6,
                    controller: _textEditingController,
                    keyboardType: TextInputType.number,
                    autofillHints: const <String>[AutofillHints.telephoneNumber],
                  ),
                  SizedBox(height: 200,width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Di"),
                        CupertinoButton(
                            child: const Text("RESEND OTP"), onPressed: () async => _verifyPhoneNumber())
                      ],
                    ),
                  )
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "OTP Verification",
                      style: TextStyle(
                          color: Colors.green.withOpacity(0.7), fontSize: 30),
                    ),
                  ),
                  const Text("The code used is invalid!"),
                  CupertinoButton(
                      child: const Text("Edit Number"),
                      onPressed: () => Navigator.pop(context)),
                  CupertinoButton(
                      child: const Text("Resend Code"),
                      onPressed: () {

                      }),
                ],
              ));
  }
}
