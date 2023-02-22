// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types, import_of_legacy_library_into_null_safe
import 'package:sweetalert/sweetalert.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Pages1/Modifier_MyProfile.dart';
import 'package:http/http.dart' as http;
import '../constants.dart';
import '../domain/request.dart';



class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with SingleTickerProviderStateMixin{
  var username;
  var tel;
  var lastname;
  var img;
  var pawd;
  var id;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    username = preferences.getString("username");
    tel = preferences.getString("tel");
    img = preferences.getString("img");
    lastname = preferences.getString("lastname");
    if (username != null) {
      setState(() {
        username = preferences.getString("username");
        tel = preferences.getString("tel");
        img = preferences.getString("img");
        lastname = preferences.getString("lastname");
        pawd = preferences.getString("password");
        id = preferences.getString("id");
      });
    }
  }
  Future getCommande() async {
    var response = await http.get(Uri.parse(urlBase + 'getcommandeterminer.php'));
    var respnsebody = jsonDecode(response.body);
    return respnsebody;
  }
  late TabController controller;

  @override
  initState() {
    controller = TabController(length: 4, vsync: this, initialIndex: 0);
    getCommande();
    getPref();
    super.initState();
  }
  double value = 0;
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 2;
    return Scaffold(

      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade400,
                    Colors.blue.shade800,
                    kPrimaryColor,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )),
          ),
          SafeArea(
              child: Container(
                width: 200.0,
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (img == null)
                      const Icon(
                        Icons.person,
                        size: 32,
                        color: Colors.amber,
                      )
                    else
                      CircleAvatar(
                          radius: 50.0,
                          backgroundImage: NetworkImage(urlBaseImg + img)),
                    const SizedBox(
                      height: 10.0,
                    ),
                    if (username == null)
                      const SizedBox()
                    else
                      Text(
                        username + ' ' + lastname,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                        ),
                      ),
                    Container(
                      color: kPrimaryColor,
                      height: 3,
                      width: MediaQuery.of(context).size.width / 8,
                      padding: const EdgeInsets.only(top: 18, bottom: 10),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      tel.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                      ),
                    ),
                    const SizedBox(
                      height: 130,
                    ),
                    Expanded(
                        child: ListView(
                          children: [
                            ListTile(
                              onTap: () {
                                Navigator.of(context).pushNamed('HomeScreen');
                              },
                              leading: const Icon(
                                Icons.home_outlined,
                                color: Colors.white,
                                size: 31,
                              ),
                              title: const Text(
                                'Home',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context).pushNamed('MyProfilePage');
                              },
                              leading: const Icon(
                                Icons.person_outline,
                                color: Colors.white,
                                size: 31,
                              ),
                              title: const Text(
                                'Profile',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return Modifier(lastname: lastname, id: id, fistname: username, phone: tel, pawd: pawd,);

                                }));
                              },
                              leading: const Icon(
                                Icons.settings_applications,
                                color: Colors.white,
                                size: 31,
                              ),
                              title: const Text(
                                'Settings',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            ListTile(
                              onTap: () async {
                                SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                                preferences.clear();
                                Navigator.of(context).pushNamed("LoginPage");
                              },
                              leading: const Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: 31,
                              ),
                              title: const Text(
                                'Log out',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        )),
                  ],
                ),
              )),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInExpo,
              builder: (_, double val, __) {
                return (Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)
                      ..setEntry(0, 3, 200 * val)
                      ..rotateY((pi / 6) * val),
                      child: Scaffold(

                        appBar: AppBar(
                            title: TabBar(
                              indicator: const UnderlineTabIndicator(
                                insets:  EdgeInsets.symmetric(horizontal: 23)
                              ),
                              indicatorColor: Colors.white,
                              controller: controller,
                              labelColor: Colors.white,
                              unselectedLabelColor: Colors.black,
                              tabs: const [
                                Tab(icon: Text('En Cours', style: TextStyle(fontSize: 10),),),
                                Tab(icon: Text('En etant', style: TextStyle(fontSize: 10),),),
                                Tab(icon: Text('Terminer', style: TextStyle(fontSize: 10),),),
                                Tab(icon: Text('Refuser', style: TextStyle(fontSize: 10),),),
                              ],
                            ),
                            centerTitle: true,
                            backgroundColor: kPrimaryColor.withOpacity(0.8), elevation: 0),
                        drawer: TextButton(
                          child: value == 1 ? const SizedBox() : Icon(
                            Icons.arrow_forward_outlined,
                            size: 30, color: Colors.blue.shade800,
                          ),
                          onPressed: () {
                            setState(() {
                              value = 1;
                            });
                          },
                        ),

                        body:  TabBarView(
                          controller: controller,
                          children: const [
                            Commande(STUTUS: 'En cours'),
                            Commande(STUTUS: 'En etant'),
                            CommandeTerminer(STUTUS: 'Terminer'),
                            Commande(STUTUS: 'Refuser'),
                          ],
                        ),
                        bottomNavigationBar: BottomNavyBar(
                          selectedIndex: _selectedIndex,
                          itemCornerRadius: 8,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          showElevation: true, // use this to remove appBar's elevation
                          onItemSelected: (index) => setState(() {
                            _selectedIndex = index;
                            if(index == 1) {
                              Navigator.of(context).pushNamed('listUser');
                            }else if(index == 3) {
                              Navigator.of(context).pushNamed('Favorites');
                            }else if(index == 0) {
                              Navigator.of(context).pushNamed('HomeScreen');
                            }
                          }),


                          items: [
                            BottomNavyBarItem(
                              icon: const Icon(Icons.apps),
                              title: const Text('Home'),
                              activeColor: kPrimaryColor,
                            ),
                            BottomNavyBarItem(
                              icon: const Icon(Icons.people),
                              title: const Text('Fournisseur'),
                              activeColor: kPrimaryColor,
                            ),
                            BottomNavyBarItem(
                              icon: const Icon(Icons.add_alert),
                              title: const Text('Notifications'),
                              activeColor: kPrimaryColor,
                            ),
                            BottomNavyBarItem(
                              icon: const Icon(Icons.favorite),
                              title: const Text('Favorite'),
                              activeColor: kPrimaryColor, inactiveColor: null,
                            )
                          ],

                        ),
                      //bottomNavigationBar: MyBottomNavBar(),
                    )));
              }),
          GestureDetector(
            onHorizontalDragUpdate: (e) {
              setState(() {
                if (e.delta.dx > 0) {
                  value = 1;
                } else {
                  value = 0;
                }
              });
            },
          )
        ],
      ),
    );
  }
}


class BottomNavyBar extends StatelessWidget {
  final int selectedIndex;
  final double iconSize;
  final Color? backgroundColor;
  final bool showElevation;
  final Duration animationDuration;
  final List<BottomNavyBarItem> items;
  final ValueChanged<int> onItemSelected;
  final MainAxisAlignment mainAxisAlignment;
  final double itemCornerRadius;

  BottomNavyBar({Key? key,
    this.selectedIndex = 0,
    this.showElevation = true,
    this.iconSize = 24,
    this.backgroundColor,
    this.itemCornerRadius = 50,
    this.animationDuration = const Duration(milliseconds: 270),
    this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key) {
    assert(items.length >= 2 && items.length <= 5);
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = (backgroundColor == null)
        ? Theme.of(context).bottomAppBarColor
        : backgroundColor;

    return Container(
        decoration: BoxDecoration(color: bgColor, boxShadow: [
          if (showElevation)
            const BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
            )
        ]),
        child: SafeArea(
            child: Container(
                width: double.infinity,
                height: 56,
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                child: Row(
                  mainAxisAlignment: mainAxisAlignment,
                  children: items.map((item) {
                    var index = items.indexOf(item);
                    return GestureDetector(
                        onTap: () => onItemSelected(index),
                        child: _ItemWidget(
                          item: item,
                          iconSize: iconSize,
                          isSelected: index == selectedIndex,
                          backgroundColor: bgColor,
                          itemCornerRadius: itemCornerRadius,
                          animationDuration: animationDuration,
                        ));
                  }).toList(),
                ))));
  }
}

class _ItemWidget extends StatelessWidget {
  final double iconSize;
  final bool isSelected;
  final BottomNavyBarItem item;
  final Color? backgroundColor;
  final double itemCornerRadius;
  final Duration animationDuration;

  const _ItemWidget(
      {Key? key,
        required this.item,
        required this.isSelected,
        this.backgroundColor,
        required this.animationDuration,
        required this.itemCornerRadius,
        required this.iconSize})
      : assert(backgroundColor != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        width: isSelected ? 130 : 50,
        height: double.maxFinite,
        duration: animationDuration,
        padding: const EdgeInsets.only(left: 12),
        decoration: BoxDecoration(
          color:
          isSelected ? item.activeColor.withOpacity(0.2) : backgroundColor,
          borderRadius: BorderRadius.circular(itemCornerRadius),
        ),
        child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: IconTheme(
                        data: IconThemeData(
                            size: iconSize,
                            color: isSelected
                                ? item.activeColor.withOpacity(1)
                                : item.inactiveColor ?? item.activeColor),
                        child: item.icon,
                      ),
                    ),
                    isSelected
                        ? DefaultTextStyle.merge(
                      style: TextStyle(
                        color: item.activeColor,
                        fontWeight: FontWeight.bold,
                      ),
                      child: item.title,
                    )
                        : const SizedBox.shrink()
                  ])
            ]));
  }
}

class BottomNavyBarItem {
  final Icon icon;
  final Text title;
  final Color activeColor;
  final Color? inactiveColor;

  BottomNavyBarItem({
    required this.icon,
    required this.title,
    this.activeColor = Colors.blue,
    this.inactiveColor,
  }) ;
}



class Commande extends StatefulWidget {
  final STUTUS;
   const Commande({Key? key, required this.STUTUS}) : super(key: key);

  @override
  State<Commande> createState() => _CommandeState();
}

class _CommandeState extends State<Commande> {


  var id;


  Future getCommande() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString("id");
    final data = {"user_id": id, "stus": widget.STUTUS};
    final response =
    await http.post(Uri.parse(urlBase + 'getcommande.php'), body: data);
    var respnsebody = jsonDecode(response.body);
    return respnsebody;

  }


  DeleteCommand(String idC) async {
    var data = {"id": idC };
    var response =
    await http.post(Uri.parse(urlBase + 'deletcommande.php'), body: data);
    var respnsebody = jsonDecode(response.body);
    if (respnsebody['status'] == "success delete") {
      SweetAlert.show(context,title: "Just show a message",
          subtitle: "Sweet alert is pretty",
          style: SweetAlertStyle.success);
    }else{
      SweetAlert.show(context,
          title: "Just show a message",
          subtitle: "Sweet alert is pretty",
          style: SweetAlertStyle.error);
    }

  }
  showAlertWaring(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
               Container(
                 padding: const EdgeInsets.all(5),
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(100,),
                  border: Border.all(color: Colors.red,width: 2.0)
                    ),
                 child: widget.STUTUS == 'Refuser' ? const Icon(Icons.delete,size: 40,
                  color: Colors.red,
                     ) : const Icon(Icons.clear,size: 40,
                  color: Colors.red,
                 ),
               ),
              const SizedBox(height: 15,),
              const Text('Êtes-Vous Sur?', style: TextStyle(
                fontSize: 22,

              ),)
            ],
          ),
          titleTextStyle: const TextStyle(
            fontSize: 15.0,
            color: Colors.black,//Theme.of(context).textTheme.titleMedium.backgroundColor,
            fontWeight: FontWeight.w800,
          ),

          actions: <Widget>[
            Row(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(color: Colors.grey.shade500,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'.toUpperCase(), style: const TextStyle(color: Colors.white),),
                ),
                FlatButton(color: Colors.red,
                  onPressed: () {
                    DeleteCommand(id);
                    Navigator.of(context).pop();
                    //Navigator.of(context).pop();
                  },
                  child: Text('Delete!'.toUpperCase(), style: const TextStyle(color: Colors.white),),
                ),
              ],
            )
          ],
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: widget.STUTUS == 'Refuser' ? const Text('Pour Suprimer le commande') : const Text('Pour annuler le commande'),
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: FutureBuilder(
        future: getCommande(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      SizedBox(height: 20,),
                                      Text('Date', style:  TextStyle(fontSize: 17, ),),SizedBox(height: 3,),
                                      Text('Location', style: TextStyle(fontSize: 17, )),SizedBox(height: 3,),
                                      Text('Contenue', style: TextStyle(fontSize: 17, )),

                                    ],
                                  )),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 20,),
                                    Text(snapshot.data[i]['date_de_commande'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                    const SizedBox(height: 3,),Text(snapshot.data[i]['location'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                    const SizedBox(height: 3,),Text(snapshot.data[i]['Commande'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width - 130,),
                      padding: const EdgeInsets.only(right: 15, top: 0),
                      child: RawMaterialButton(
                        elevation: 2,
                        padding: EdgeInsets.zero,
                        shape: const CircleBorder(),
                        child: Container(
                          padding: const  EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade300,
                          ),
                          child: widget.STUTUS == 'Refuser' ? Row(
                            children: [
                              Container(
                                  margin: const EdgeInsets.only(right: 4),
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100,),
                                      border: Border.all(color: Colors.red,width: 1.5)
                                  ),child: const Icon(Icons.delete,size: 16, )),
                              const SizedBox(height: 5,),
                              const Text('Suprimer', style: TextStyle(fontSize: 15),),
                            ],
                          ) : Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 4),
                                  padding: const EdgeInsets.all(1),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100,),
                                      border: Border.all(color: Colors.red,width: 1.5)
                                  ),child: const Icon(Icons.clear,size: 16,)),
                              const SizedBox(height: 5,),
                              const Text('Annuler', style: TextStyle(fontSize: 16),),
                            ],
                          ),
                        ),
                        onPressed: () {
                            showAlertWaring(snapshot.data[i]['idc'].toString());
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}


class CommandeTerminer extends StatefulWidget {
  final STUTUS;
  const CommandeTerminer({Key? key, required this.STUTUS}) : super(key: key);

  @override
  State<CommandeTerminer> createState() => _CommandeTerminerState();
}

class _CommandeTerminerState extends State<CommandeTerminer> {


  var id;


  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      id = preferences.getString("id");
    });
  }
  Future getCommande() async {

    SharedPreferences preferences = await SharedPreferences.getInstance();
     id = preferences.getString("id");
      final data = {"user_id": id, "stus": widget.STUTUS};
      final response =
          await http.post(Uri.parse(urlBase + 'getcommande.php'), body: data);
      var respnsebody = jsonDecode(response.body);
      return respnsebody;

  }
  @override
  initState() {
    getPref();
    super.initState();
  }

  DeleteCommand(String id) async {
    var data = {"id": id, "stus": widget.STUTUS};
    var response = await http
        .post(Uri.parse(urlBase+'deletcommande.php'), body: data);
    var respnsebody = jsonDecode(response.body);
    if (respnsebody['status'] == "success delete"){
         SweetAlert.show(context,title: "Just show a message",
          subtitle: "Sweet alert is pretty",
          style: SweetAlertStyle.success);
      }else{
        SweetAlert.show(context,
        title: "Just show a message",
        subtitle: "Sweet alert is pretty",
        style: SweetAlertStyle.error);
    }
  }

  showAlertWaring(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100,),
                    border: Border.all(color: Colors.red,width: 2.0)
                ),
                child: const Icon(Icons.delete,size: 40,

                ),
              ),
              const SizedBox(height: 15,),
              const Text('Êtes-Vous Sur?', style: TextStyle(
                fontSize: 22,

              ),)
            ],
          ),
          titleTextStyle: const TextStyle(
            fontSize: 15.0,
            color: Colors.black,//Theme.of(context).textTheme.titleMedium.backgroundColor,
            fontWeight: FontWeight.w800,
          ),

          actions: <Widget>[
            Row(crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FlatButton(color: Colors.grey.shade500,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'.toUpperCase(), style: const TextStyle(color: Colors.white),),
                ),
                FlatButton(color: Colors.red,
                  onPressed: () {
                    DeleteCommand(id);
                    Navigator.of(context).pop();
                    //Navigator.of(context).pop();
                  },
                  child: Text('Delete!'.toUpperCase(), style: const TextStyle(color: Colors.white),),
                ),
              ],
            )
          ],
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: const Text('Pour Suprimer la commande'),
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: FutureBuilder(
        future: getCommande(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (context, i) {
                return Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5.0),
                      child: Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.symmetric(
                              vertical: 13.0, horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      SizedBox(height: 30,),
                                      Text('Date', style:  TextStyle(fontSize: 17, ),),SizedBox(height: 3,),
                                      Text('Nom', style:  TextStyle(fontSize: 17, ),),SizedBox(height: 3,),
                                      Text('Tel', style:  TextStyle(fontSize: 17, ),),SizedBox(height: 3,),
                                      Text('Location', style: TextStyle(fontSize: 17, )),SizedBox(height: 3,),
                                      Text('Contenue', style: TextStyle(fontSize: 17, )),

                                    ],
                                  )),
                              Expanded(
                                flex: 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 30,),
                                    Text(snapshot.data[i]['date_de_commande'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                    const SizedBox(height: 3,), Text(snapshot.data[i]['username'] + ' ' + snapshot.data[i]['lastname'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                    const SizedBox(height: 3,),Text(snapshot.data[i]['tel'].toString(), style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                    const SizedBox(height: 3,),Text(snapshot.data[i]['location'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                    const SizedBox(height: 3,),Text(snapshot.data[i]['Commande'], style: const TextStyle(fontSize: 17, color: Colors.blueGrey)),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),

                    /*
                    Container(

                        margin: const EdgeInsets.only(left:344, bottom: 2),
                        child:
                        RawMaterialButton(
                          elevation: 1,
                          padding: const EdgeInsets.all(2.0),
                          shape: const CircleBorder(),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: kPrimaryColor
                            ),
                            child: const Icon(
                              Icons.clear_rounded,
                              color: Colors.white,
                              size: 25.0,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              showAlertWaring(snapshot.data[i]['id'].toString());
                              //
                            });
                            //pickerCamera();
                          },
                        )
                    ),
                    */

                    Container(
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width - 135,),
                        padding: const EdgeInsets.only(right: 15, top: 0),
                        child: RawMaterialButton(
                          elevation: 2,
                          padding: EdgeInsets.zero,
                          shape: const CircleBorder(),
                          child: Container(
                              padding: const  EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.shade300,
                              ),
                              child:  Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(right: 4),
                                      padding: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100,),
                                          border: Border.all(color: kPrimaryColor,width: 1.5)
                                      ),child: const Icon(Icons.phone,size: 16,)),
                                  const SizedBox(height: 5,),
                                  const Text('Contacter', style: TextStyle(fontSize: 13),),
                                ],
                              )),
                          onPressed: () {
                            setState(() {
                              showAlert(context, snapshot.data[i]['tel'].toString());
                              //print(id);
                              // showAlertWaring(id_c: snapshot.data[i]['id'].toString(), stus: "Finit");
                              //
                            });
                            //pickerCamera();
                          },
                        )
                    ),
                    Container(margin: EdgeInsets.only(right: MediaQuery.of(context).size.width - 130,),
                        padding: const EdgeInsets.only(left: 15, top: 0),
                        child: RawMaterialButton(
                          elevation: 2,
                          padding: EdgeInsets.zero,
                          shape: const CircleBorder(),
                          child: Container(
                              padding: const  EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey.shade300,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.only(right: 4),
                                      padding: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100,),
                                          border: Border.all(color: Colors.red,width: 1.5)
                                      ),child: const Icon(Icons.delete,size: 16,)),
                                  const SizedBox(height: 5,),
                                  const Text('Suprimer', style: TextStyle(fontSize: 13),),
                                ],
                              )),
                          onPressed: () {
                            setState(() {
                              //showAlert(context, snapshot.data[i]['tel'].toString());
                              //print(id);
                              showAlertWaring(snapshot.data[i]['id'].toString());
                              //
                            });
                            //pickerCamera();
                          },
                        )
                    ),
                  ],
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}




showAlert(BuildContext context, String phoneNumber) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 8.0,
        contentPadding: const EdgeInsets.all(18.0),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () => launch('tel:' + phoneNumber),
              child: Container(
                height: 50.0,
                alignment: Alignment.center,
                child: const Text('Call'),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () => launch('sms:' + phoneNumber),
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: const Text('Message'),
              ),
            ),
            const Divider(),
            InkWell(
              onTap: () => launch('https://wa.me/' + phoneNumber),
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: const Text('WhatsApp'),
              ),
            ),
          ],
        ),
      );
    },
  );
}