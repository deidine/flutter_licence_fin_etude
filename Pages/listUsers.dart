// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:awn_stage2/Pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Pages1/Modifier_MyProfile.dart';
import '../constants.dart';
import '../domain/request.dart';

class ListUsers extends StatefulWidget {
  const ListUsers({Key? key}) : super(key: key);

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  List<dynamic> listsearch =[] ;
  List<dynamic> listId =[] ;


  Future getData() async {
    var url = Uri.parse(urlBase+'search.php');
    var response = await http.get(url);
    var respnsebody = jsonDecode(response.body);
    for(int i=0 ; i < respnsebody.length ; i++){
      listsearch.add(respnsebody[i]['username']);

    }
  }

  Future getPhone() async {
    var response = await http.get(Uri.parse(urlBase + 'inde.php'));
    var respnsebody = jsonDecode(response.body);
    setState(() {
      getFavorite();

    });
    return respnsebody;
  }

  List<dynamic> listFavorite =[] ;


  Future getFavorite() async {
    final data = {"user_id": id.toString()};
    final response =
    await http.post(Uri.parse(urlBase + 'indChek.php'), body: data);
    var respnsebody = jsonDecode(response.body);
    for(int i=0 ; i < respnsebody.length ; i++){
      listFavorite.add(respnsebody[i]['id'].toString());
    }
  }

  var username;
  var tel;
  var lastname;
  var img;
  var id;
  var pawd;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString("username");
    if (id != null) {
      setState(() {
        getFavorite();
        username = preferences.getString("username");
        tel = preferences.getString("tel");
        img = preferences.getString("img");
        lastname = preferences.getString("lastname");
        id = preferences.getString("id");
        pawd = preferences.getString("password");
      });
    }
  }
  Future deleteFavorite({required String Uid, required String Aid}) async{

      var data = {"admin_id": Aid,"user_id": Uid, "fav": '1'};
      var response = await http
          .post(Uri.parse(urlBase+'addcomment.php'), body: data);
      var respnsebody = jsonDecode(response.body);

      if (respnsebody['status'] == "success add") {
        setState(()  {
          listFavorite.add(Aid);
          getFavorite();
        });
      } else {
        showAlert(context, id);
      }

  }

  @override
  void initState() {
    getPref();
    getFavorite();
    getData();

    super.initState();
  }

  double value = 0;
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 1;
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
                        automaticallyImplyLeading: true,
                        title: const Text('Lists des Fourniseur',style: TextStyle(fontSize: 21, color: Colors.white),),
                        centerTitle: true,
                        elevation: 2,
                        backgroundColor: kPrimaryColor.withOpacity(0.8),
                        actions: [
                          IconButton(icon: const Icon(Icons.search, color: Colors.black, size: 29,), onPressed: () {
                            showSearch(context: context, delegate: DataSearch(list: listsearch, id: id));
                          },)
                        ],
                        primary: true,

                      ),
                      drawer: FlatButton(
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
                      body: FutureBuilder(
                        future: getPhone(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, i) {
                                String world = snapshot.data[i]['id'].toString();
                                bool isSavedId = listFavorite.contains(world);
                                return InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                      return ProfilePage(isFavorite: isSavedId,cat_name_D: snapshot.data[i]['cat_name'],id_D: snapshot.data[i]['id'].toString(), des_D: snapshot.data[i]['des'], id_cat_D: snapshot.data[i]['id_cat'].toString(), img_D: snapshot.data[i]['img'], password_D: snapshot.data[i]['password'], tel_D: snapshot.data[i]['tel'].toString(), lastname_D: snapshot.data[i]['lastname'], username_D: snapshot.data[i]['username']);
                                    }));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 5.0),
                                    child: Card(
                                      elevation: 5.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.0),
                                      ),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0, vertical: 10.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 55,
                                                  width: 55,
                                                  child: CircleAvatar(
                                                    radius: null,
                                                    child: ClipRRect(child: Image.network(urlBaseImg+snapshot.data[i]['img'],
                                                      height: 76,
                                                      width: 76,
                                                      fit: BoxFit.cover,
                                                    ),
                                                      borderRadius: BorderRadius.circular(100.0),
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(
                                                  width: 10.0,
                                                ),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      snapshot.data[i]['username'] +' ' + snapshot.data[i]['lastname'],
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18.0,
                                                          fontWeight: FontWeight.bold),
                                                    ),
                                                    const SizedBox(height: 10,),
                                                    Text('  '+
                                                        snapshot.data[i]['cat_name'].toString(),
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 15.0,
                                                      ),
                                                    ),

                                                  ],
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        color: kPrimaryColor.withOpacity(0.3),
                                                        borderRadius: BorderRadius.circular(100)
                                                      ),
                                                      alignment: Alignment.center,
                                                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                                                      margin: const EdgeInsets.only(top: 8.0),
                                                      child: const Icon(Icons.phone,size: 27,

                                                      ),
                                                    ),
                                                    Container(
                                                        margin: const EdgeInsets.symmetric(horizontal: 10),
                                                        child: const Icon(Icons.arrow_forward_ios)
                                                    ),

                                                  ],
                                                ),
                                                /*
                                                Container(padding: EdgeInsets.zero,
                                                  margin: EdgeInsets.zero,
                                                  child: InkWell(
                                                    child:  isSavedId ? const Icon(Icons.favorite,color: kPrimaryColor,) :
                                                    const Icon(Icons.favorite_border,color: kPrimaryColor,),
                                                    onTap: (){
                                                      setState(()  {
                                                        getPref();
                                                        deleteFavorite(Aid: snapshot.data[i]['id'].toString(), Uid: id.toString());
                                                        getFavorite();
                                                        // print(id);
                                                      });
                                                    },
                                                  ),
                                                ),

                                                 */
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      bottomNavigationBar: BottomNavyBar(
                        selectedIndex: _selectedIndex,
                        itemCornerRadius: 8,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        showElevation: true, // use this to remove appBar's elevation
                        onItemSelected: (index) => setState(() {
                          _selectedIndex = index;
                          if(index == 0) {
                            Navigator.of(context).pushNamed('HomeScreen');
                          }else if(index == 2) {
                            Navigator.of(context).pushNamed('Categories');
                          }else if(index == 3) {
                            Navigator.of(context).pushNamed('Favorites');
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
  }) {
  }
}

class DataSearch extends SearchDelegate<String>{

  List<dynamic> list ;
  final id;
  DataSearch({required this.list, required this.id});
  Future getsearchData() async {
    var url = Uri.parse(urlBase + 'searchmob.php');
    var data = {"searchmobile" : query};
    var response = await http.post(url,body: data);
    var respnsebody = jsonDecode(response.body);
    return respnsebody;

  }
  List<dynamic> listFavorite =[] ;


  Future getFavorite() async {
    final data = {"user_id": id.toString()};
    final response =
    await http.post(Uri.parse(urlBase + 'indChek.php'), body: data);
    var respnsebody = jsonDecode(response.body);
    for(int i=0 ; i < respnsebody.length ; i++){
      listFavorite.add(respnsebody[i]['id']);
    }
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(onPressed: (){
        query = "";
      }, icon: const Icon(Icons.clear),)
    ];
  }
  Future deleteFavorite({required String Uid, required String Aid,required bool isS,}) async{

    if(isS){
      var data = {"user_id": Uid, "admin_id": Aid};
      var response = await http
          .post(Uri.parse(urlBase+'delete.php'), body: data);

        listFavorite.remove(Aid);
        getFavorite();
    }else {
      var data = {"admin_id": Aid,"user_id": Uid, "fav": '1'};
      var response = await http
          .post(Uri.parse(urlBase+'addcomment.php'), body: data);

    }
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: (){
      close(context, "");
    }, icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return FutureBuilder(
      future: getsearchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              int world = snapshot.data[i]['id'];
              bool isSavedId = listFavorite.contains(world);
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return ProfilePage(isFavorite: isSavedId,cat_name_D: snapshot.data[i]['cat_name'],id_D: snapshot.data[i]['id'].toString(), des_D: snapshot.data[i]['des'], id_cat_D: snapshot.data[i]['id_cat'].toString(), img_D: snapshot.data[i]['img'], password_D: snapshot.data[i]['password'], tel_D: snapshot.data[i]['tel'].toString(), lastname_D: snapshot.data[i]['lastname'], username_D: snapshot.data[i]['username']);
                  }));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  child: Card(
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 55,
                                width: 55,
                                child: CircleAvatar(
                                  radius: null,
                                  child: ClipRRect(child: Image.network(urlBaseImg+snapshot.data[i]['img'],
                                    height: 76,
                                    width: 76,
                                    fit: BoxFit.cover,
                                  ),
                                    borderRadius: BorderRadius.circular(100.0),
                                  ),
                                ),
                              ),

                              const SizedBox(
                                width: 10.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data[i]['username'] +' ' + snapshot.data[i]['lastname'],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 10,),
                                  Text('  '+
                                      snapshot.data[i]['cat_name'].toString(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15.0,
                                    ),
                                  ),

                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: kPrimaryColor.withOpacity(0.3),
                                        borderRadius: BorderRadius.circular(100)
                                    ),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                                    margin: const EdgeInsets.only(top: 8.0),
                                    child: const Icon(Icons.phone,size: 27,

                                    ),
                                  ),
                                  Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 10),
                                      child: const Icon(Icons.arrow_forward_ios)
                                  ),

                                ],
                              ),
                              /*
                                                Container(padding: EdgeInsets.zero,
                                                  margin: EdgeInsets.zero,
                                                  child: InkWell(
                                                    child:  isSavedId ? const Icon(Icons.favorite,color: kPrimaryColor,) :
                                                    const Icon(Icons.favorite_border,color: kPrimaryColor,),
                                                    onTap: (){
                                                      setState(()  {
                                                        getPref();
                                                        deleteFavorite(Aid: snapshot.data[i]['id'].toString(), Uid: id.toString());
                                                        getFavorite();
                                                        // print(id);
                                                      });
                                                    },
                                                  ),
                                                ),

                                                 */
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    var searchlis= query.isEmpty ? list : list.where((p) => p.startsWith(query)).toList();
    return ListView.builder(itemCount:searchlis.length,itemBuilder: (context, i){
      return ListTile(leading: const Icon(Icons.person),title: Text(searchlis[i]),
        onTap: (){
          query = searchlis[i];
          showResults(context);
        },);

    });
  }

}










/*

class ListUsers extends StatefulWidget {
  const ListUsers({Key? key}) : super(key: key);

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.green));
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          indicator: const UnderlineTabIndicator(
              insets: EdgeInsets.symmetric(horizontal: 16.0)),
          controller: controller,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          tabs: const [
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.person_add),
            ),
            Tab(
              icon: Icon(Icons.notifications),
            ),
            Tab(
              icon: Icon(Icons.clear_all),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: const [
          HomePage(),
          HomePage(),
          HomePage(),
          HomePage(),
        ],
      ),
    );
  }
}
 */