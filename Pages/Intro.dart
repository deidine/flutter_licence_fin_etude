import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../domain/request.dart';
import 'login.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => _IntroState();
}

class _IntroState extends State<Intro> {

  final TextEditingController _descripon = TextEditingController();
  final TextEditingController _localisation = TextEditingController();

  AddCommande() async {
    var dat = {
      "des": _descripon.text,
      "id_user": '13',
      "id_fourni": '12',
      "loc": _localisation.text
    };
    var respons = await http.post(
        Uri.parse(urlBase+'addcommade.php'),
        body: dat);
    var respnsebod = jsonDecode(respons.body);
    if (respnsebod['status'] == "success add") {
      Navigator.of(context).pop();

    }else{

      showdialogall(context, "Erreur", "Numéro de télephone existe déjà ");
    }
    //Navigator.of(context).pushNamed("home");


  }
  showAlertNew() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Dialog Title',
            textAlign: TextAlign.center,
          ),
          titleTextStyle: const TextStyle(
            fontSize: 16.0,
            color: kPrimaryColor,//Theme.of(context).textTheme.titleMedium.backgroundColor,
            fontWeight: FontWeight.w800,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),

          ),
          actions: <Widget>[
            FlatButton(color: Colors.red.shade400,
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'.toUpperCase()),
            ),
            FlatButton(color: Colors.blue.shade400,
              onPressed: () {
                AddCommande();
                //Navigator.of(context).pop();
              },
              child: Text('OK'.toUpperCase()),
            ),
          ],
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: _localisation,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: 'Localisation',
                  ),
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    //FocusScope.of(context).requestFocus(_nodePassword);
                  },
                ),
                TextField(
                  controller: _descripon,
                  obscureText: false,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  late List<Widget> _pages;
  late int _activePage = 0 ;
  @override
  Widget build(BuildContext context) {
    _pages = [
      const IntroPage(),
      const Center(
        child:  Text('pag2'),
      ),  Center(
        child:  InkWell(child: Text('pag3'),onTap: () {
          //Navigator.of(context).pushNamed('AlertDialig');
          Navigator.of(context).pushNamed('HomeScreenFournisseur');
        },)
      )
    ];
    return Scaffold(
      body: Stack(
        children:  [
           Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              top: 0.0,
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    _activePage = value;
                  });
                },
                children: _pages,
              )
          ),
           Positioned(
            bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: ButtonOptions(
                totalPage: _pages.length,
                activePage: _activePage,
              )
          ),
        ],
      ),
    );
  }

}

class ButtonOptions extends StatelessWidget {
  const ButtonOptions({Key? key, required this.totalPage,required this.activePage}) : super(key: key);
  final int totalPage;
  final int activePage;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children:  [
          
          //Page View Pagination
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(totalPage, (index) {
                return AnimatedContainer(
                  duration: const Duration(microseconds: 500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  width: activePage == index ? 12 : 7,
                  height: 5,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: activePage == index ? Colors.indigo : Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 35,),
          //Page View Pagination


            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed('loginAdminPage');
                },
              child: Container(
                height: 60,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.black.withOpacity(0.05),
                        width: 2
                    ),
                    borderRadius: BorderRadius.circular(35)
                ),
                child: Row(
                  children: [
                    Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle
                        ),
                        child: const Icon(Icons.login,
                          color: Colors.white,
                        )

                    ),
                    Expanded(
                        child: Container(
                            alignment: Alignment.center,
                            child: const Text('Entre un tanque Admin',
                              style:  TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 17
                              ),
                            )
                        )
                    )
                  ],
                ),
              ),
            ),

           const SizedBox(height: 20,),
          InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('LoginPage');
              },
            child: Container(
              height: 60,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(35)
              ),
              child: Row(
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle
                      ),
                      child: const Icon(Icons.login,
                        color: Colors.blue,
                        size: 25,
                      )
                  ),
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: const Text('Entre un tanque Utilisateur',
                            style:  TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 17
                            ),
                          )
                      )
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 50),

        ],
      ),
    );
  }
}



class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        children: [
          const SizedBox(height: 125,),
          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.symmetric(horizontal: 110),
            decoration:  BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(12),
              boxShadow:  [BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 30,
                offset: const Offset(0, 30),
              ),
              ]
            ),
            child: const Image(image: AssetImage("images/c1.JPG"),
            height: 48,
            width: 48,
            ),
          ),
          const SizedBox(height: 32,),
          const Text('AWN ', style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w700,
          ),),
          const SizedBox(height: 32,),
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child:  Text("Bonjojn jcnsjn njcncjn jnjncjns njnc jsdncnksq nkjnkcs jnkjsndknc "
                "ncncosqoisd ncks chndc jcskksopk jsnckosck cnksncn jnzk ncnzc zizen cn",
            textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.54),
              ),
            ),
          )
        ],
      ),
    );
  }
}
