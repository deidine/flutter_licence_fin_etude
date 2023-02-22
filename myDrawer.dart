// ignore: duplicate_ignore
// ignore: file_names
// ignore_for_file: file_names
import 'package:shared_preferences/shared_preferences.dart';
import "package:flutter/material.dart";

import 'constants.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<MyDrawer> {
  var username;
  var tel;
  bool isSigin = false;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString("username");
    tel = preferences.getString("tel");

    if (username != null) {
      setState(() {
        username = preferences.getString("username");
        tel = preferences.getString("tel");
        isSigin = true;
      });
    }
  }

  @override
  initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return Drawer(
        child: Container(
      color: Colors.white,
          child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: isSigin
                ? Text(
                    username,
                    style: const TextStyle(fontSize: 18),
                  )
                : const Text(""),
            accountEmail: isSigin
                ? Text(
                    tel,
                    style: const TextStyle(fontSize: 18),
                  )
                : const Text(""),
            currentAccountPicture: CircleAvatar(
                child: isSigin
                    ? const Icon(
                        Icons.person,
                        size: 32,
                        color: Colors.amber,
                      )
                    : null,
                backgroundColor: Colors.brown),
            decoration: const BoxDecoration(
                color: Colors.amber,
                image:  DecorationImage(
                  image: AssetImage("images/IMG.JPG"),
                  fit: BoxFit.cover,
                )),
          ),
          ListTile(
            title: const Text(
              "Page D'accueil",
              style:  TextStyle(
                  color: Colors.black87,
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
            ),
            leading: const Icon(
              Icons.home,
              color: kPrimaryColor,
              size: 28,
            ),
            onTap: () => Navigator.of(context).pushNamed('home'),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.6),
          ),
          ListTile(
            title: const Text(
              "Categories",
              style: TextStyle(
                  color: Colors.black87,
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
            ),
            leading: const Icon(
              Icons.category,
              color: kPrimaryColor,
              size: 28,
            ),
            onTap: () => Navigator.of(context).pushNamed('categories'),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.6),
          ),

          ListTile(
            title: const Text(
              "À propos de l'application",
              style: TextStyle(
                  color: Colors.black87,
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
            ),
            leading: const Icon(
              Icons.info,
              color: kPrimaryColor,
              size: 28,
            ),
            onTap: () => Navigator.of(context).pushNamed("aproppo"),
          ),
          Divider(
            color: Colors.grey.withOpacity(0.6),
          ),
          isSigin
              ? ListTile(
                  title: const Text(
                    "Ajouter post",
                    style: TextStyle(
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                        fontSize: 20),
                  ),
                  leading: const Icon(
                    Icons.add_comment_rounded,
                    color: kPrimaryColor,
                    size: 28,
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed("post");
                  },
                )
              : const SizedBox(height: 0),
          isSigin
              ? Divider(
            color: Colors.grey.withOpacity(0.6),
          ) : const SizedBox(height: 0),
          isSigin
              ? ListTile(
                  title: const Text(
                    "Se Déconnecter",
                    style: TextStyle(
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                        fontSize: 20),
                  ),
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: kPrimaryColor,
                    size: 28,
                  ),
                  onTap: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.remove("username");
                    preferences.remove("tel");
                    Navigator.of(context).pushNamed("login");
                  })
              : ListTile(
                  title: const Text(
                    "Se connecter",
                    style: TextStyle(
                        color: Colors.black87,
                        fontStyle: FontStyle.italic,
                        fontSize: 20),
                  ),
                  leading: const Icon(
                    Icons.exit_to_app,
                    color: kPrimaryColor,
                    size: 28,
                  ),
                  onTap: () => Navigator.of(context).pushNamed('login'),
                ),
          ListTile(
            title: const Text(
              "En registerer",
              style: TextStyle(
                  color: Colors.black87,
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
            ),
            leading: const Icon(
              Icons.account_box_outlined,
              color: kPrimaryColor,
              size: 28,
            ),
            onTap: () => Navigator.of(context).pushNamed('form'),
          ),
          ListTile(
            title: const Text(
              "Admin ",
              style: TextStyle(
                  color: Colors.black87,
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
            ),
            leading: const Icon(
              Icons.account_box_outlined,
              color: kPrimaryColor,
              size: 28,
            ),
            onTap: () => Navigator.of(context).pushNamed('loginAdmin'),
          ),
          ListTile(
            title: const Text(
              "Test ",
              style: TextStyle(
                  color: Colors.black87,
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
            ),
            leading: const Icon(
              Icons.arrow_forward,
              color: kPrimaryColor,
              size: 28,
            ),
            onTap: () => Navigator.of(context).pushNamed('test'),
          ),ListTile(
            title: const Text(
              "ContactUs ",
              style: TextStyle(
                  color: Colors.black87,
                  fontStyle: FontStyle.italic,
                  fontSize: 20),
            ),
            leading: const Icon(
              Icons.contact_page,
              color: kPrimaryColor,
              size: 28,
            ),
            onTap: () => Navigator.of(context).pushNamed('MyApp4'),
          ),
        ],
      ),
    ));
  }
}
