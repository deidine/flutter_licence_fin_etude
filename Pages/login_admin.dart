import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awn_stage2/common/theme_helper.dart';
import '../Pages1/home.dart';
import '../Pages1/homeFournisseur.dart';
import '../domain/request.dart';
import 'loginAdminPageUp.dart';
import 'registration_page.dart';
import 'widgets/header_widget.dart';



class LoginAdminPage extends StatefulWidget{
  const LoginAdminPage({Key? key}): super(key:key);

  @override
  _LoginAdminPageState createState() => _LoginAdminPageState();
}

class _LoginAdminPageState extends State<LoginAdminPage>{


  showdialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: const [Text("Loading ..."), CircularProgressIndicator()],
            ),
          );
        });
  }

  showdialogall(context, String mytitle, String mycontent) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              mytitle,
              style: const TextStyle(fontSize: 22, color: Colors.red),
            ),
            content: Text(mycontent),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("done")),
            ],
          );
        });
  }

  final double _headerHeight = 270;
  final Key _formKey = GlobalKey<FormState>();

  TextEditingController password = TextEditingController();
  TextEditingController tel = TextEditingController();
  TextEditingController id = TextEditingController();

  GlobalKey<FormState> formstatesigin = GlobalKey<FormState>();
  GlobalKey<FormState> formstatesiginup = GlobalKey<FormState>();

  savePref(
      {required String username,
        required String tel,
        required String id,
        required String img,
        required String password,
        required String lastname}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("id", id);
    preferences.setString("username", username);
    preferences.setString("tel", tel);
    preferences.setString("img", img);
    preferences.setString("password", password);
    preferences.setString("lastname", lastname);
  }

  String pattern = r'[0-9]{8}$';

  String? validTEL(String val) {
    RegExp regex = RegExp(pattern);
    if (val.trim().isEmpty) {
      return "Ce champ  ne peut pas être vide";
    } else if (val.trim().length < 8) {
      return "Le longuer min c'est 8 nombre ";
    } else if (val.trim().length > 13) {
      return "Le longuer max c'est 13 nombre";
    }
    if (!regex.hasMatch(val)) {
      return "Le numero tel n'est pas valide";
    }
    return null;
  }

  String? validpass(String val) {
    if (val.trim().isEmpty) {
      return "Le mot de passe ne peut pas être vide";
    }
    if (val.trim().length < 6) {
      return "Le longuer min c'est 6 characteur ";
    }
    if (val.trim().length > 100) {
      return "Le longuer max c'est 100 characteur";
    } else {
      return null;
    }
  }

  sigin() async {
    showdialog(context);
    var data = {"tel": tel.text, "password": password.text};
    var response = await http
        .post(Uri.parse(urlBase+'loginAdmin.php'), body: data);
    var respnsebod = jsonDecode(response.body);
    if (respnsebod['status'] == "success") {
      savePref(id: respnsebod['id'].toString(), lastname: respnsebod['lastname'].toString(), tel: respnsebod['tel'].toString(), img: respnsebod['img'], username: respnsebod['username'], password: respnsebod['password']);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreenFournisseur()));
    } else {
      Navigator.of(context).pop();
      showdialogall(context, "Erreur :",
          "Numéro de télephone ou le mot de passe est faux");
    }

  }

  bool isOPscure = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SizedBox(
              height: _headerHeight ,
              child: HeaderWidget(_headerHeight, true, Icons.login_rounded), //let's create a common header widget
            ),
            Container(
              padding: const EdgeInsets.only(top: 220),
              child: SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 60,),
                    const Text(
                      'Bien Venue',
                      style:  TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'connecter avec vos compte',
                      style:  TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 40,),
                    Container(
                      //padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      // margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),/
                        margin: const EdgeInsets.symmetric(horizontal: 50),// This will be the login form/ This will be the login form
                        child: Column(
                          children: [

                            const SizedBox(height: 40.0),
                            Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    Container(
                                      child: buildFormFieldAlltel(false,
                                          tel, validTEL, 'Numero de tel', 'Enter votre numero de tel'),
                                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Container(
                                      child: buildFormFieldAll(isOPscure,
                                          password, validpass, 'Mots de passe', 'Enter votre mots de passe', InkWell(
                                            child: isOPscure ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off),
                                            onTap: (){
                                              setState(() {
                                                isOPscure = !isOPscure;
                                              });
                                            },
                                          )),
                                      decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                    ),
                                    const SizedBox(height: 30.0),
                                    /*
                                  Container(
                                    margin: const EdgeInsets.fromLTRB(10,0,10,20),
                                    alignment: Alignment.topRight,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push( context, MaterialPageRoute( builder: (context) => const ForgotPasswordPage()), );
                                      },
                                      child: const Text( "Forgot your password?", style: TextStyle( color: Colors.grey, ),
                                      ),
                                    ),
                                  ),
                                   */
                                    Container(
                                      decoration: ThemeHelper().buttonBoxDecoration(context),
                                      child: ElevatedButton(
                                        style: ThemeHelper().buttonStyle(),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 30),
                                          child: Text('Sign In'.toUpperCase(), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                        ),
                                        onPressed: sigin,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.fromLTRB(10,20,10,20),
                                      //child: Text('Don\'t have an account? Create'),
                                      child: Text.rich(
                                          TextSpan(
                                              children: [
                                                const TextSpan(text: "Vous na ves pas de compte? "),
                                                TextSpan(
                                                  text: 'Create',
                                                  recognizer: TapGestureRecognizer()
                                                    ..onTap = (){
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginAdminPageUp()));
                                                    },
                                                  style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.secondary),
                                                ),
                                              ]
                                          )
                                      ),
                                    ),
                                  ],
                                )
                            ),
                          ],
                        )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }
}

TextFormField buildFormFieldAll(bool pass,
    TextEditingController mycontroller, myvalid, String s1, String s2, Widget wd) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: myvalid,
    controller: mycontroller,
    obscureText: pass,
    decoration: ThemeHelper().textInputDecoration(s1, s2, const Icon(Icons.vpn_key_rounded),  wd),
  );
}
TextFormField buildFormFieldAlltel(bool pass,
    TextEditingController mycontroller, myvalid, String s1, String s2) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: myvalid,

    controller: mycontroller,
    obscureText: pass,
    keyboardType: TextInputType.phone,
    decoration: ThemeHelper().textInputDecoration(s1, s2, const Icon(Icons.phone_android)),
  );
}