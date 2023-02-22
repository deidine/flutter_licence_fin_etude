//import 'package:firebase_core/firebase_core.dart';
// ignore_for_file: must_be_immutable

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'Pages/Intro.dart';
import 'Pages/commande.dart';
import 'Pages/form_screen.dart';
import 'Pages/listUsers.dart';
import 'Pages/login.dart';
import 'Pages/loginAdmin.dart';
import 'Pages/loginAdminPageUp.dart';
import 'Pages/login_admin.dart';
import 'Pages/login_page.dart';
import 'Pages1/Favorite.dart';
import 'Pages1/adminAmis.dart';
import 'Pages1/adminCommandeAcc.dart';
import 'Pages1/adminDemand.dart';
import 'Pages1/alertDialoge.dart';
import 'Pages1/home.dart';
import 'Pages1/homeFournisseur.dart';
import 'Pages1/login_page_admin.dart';
import 'Pages1/myProfile.dart';
import 'Pages1/tlphn.dart';
import 'firebase/ppp.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // ignore: prefer_final_fields
  Color _primaryColor = HexColor('#DC54FE');
  final Color _accentColor = HexColor('#8A02AE');

  MyApp({Key? key}) : super(key: key);


  // Design color
  // Color _primaryColor= HexColor('#FFC867');
  // Color _accentColor= HexColor('#FF3CBD');

  // Our Logo Color
  // Color _primaryColor= HexColor('#D44CF6');
  // Color _accentColor= HexColor('#5E18C8');

  // Our Logo Blue Color
  //Color _primaryColor= HexColor('#651BD2');
  //Color _accentColor= HexColor('#320181');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Login UI',
        theme: ThemeData(
          primaryColor: _primaryColor,
          accentColor: _accentColor,
          scaffoldBackgroundColor: Colors.grey.shade100,
          primarySwatch: Colors.grey,
        ),
        home: const Intro(),
        routes: {
          'login': (context) {
            return const Login();
          },
          'LoginPage': (context) {
            return const LoginPage();
          },
          'form': (context) {
            return const FormScreen();
          },
          'loginAdmin': (context) {
            return const LoginAdmin();
          },
          'loginAdminPage': (context) {
            return const LoginAdminPage();
          },
          'loginAdminPageUp': (context) {
            return const LoginAdminPageUp();
          },
          'listUser': (context) {
            return  const ListUsers();
          },
          'HomeScreen': (context) {
            return const HomeScreen();
          },
          'Categories': (context) {
            return const Categories();
          },
          'Favorites': (context) {
            return const Favorites();
          },
          'MyProfilePage': (context) {
            return const MyProfilePage();
          },
          'ProfilePage4': (context) {
            return const ProfilePage4();
          },
          'AlertDialig': (context) {
            return  const AlertDialig();
          },
          'HomeScreenFournisseur': (context) {
            return  const HomeScreenFournisseur();
          },
          'AdminCommande': (context) {
            return  const AdminCommande();
          },
          'AdminCommandeAcc': (context) {
            return  const AdminCommandeAcc();
          },
          'AdminClient': (context) {
            return  const AdminClient();
          },
          'ProfilePageAdmin': (context) {
            return  const ProfilePageAdmin();
          }


        }
    );
  }
/*
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Myapp',
      home: const Home(),
      routes: {
        'home': (context) {
          return const Home();
        },
        'login': (context) {
          return const Login();
        },
        'form': (context) {
          return const FormScreen();
        },
        'loginAdmin': (context) {
          return const LoginAdmin();
        },
        'dropDawn': (context) {
          return  const DropDawn();
        },
        'test': (context) {
          return  const Test();
        },
        'contactUs': (context) {
          return  const ContactUss();
        },
      },
    );
  }*/
  }
