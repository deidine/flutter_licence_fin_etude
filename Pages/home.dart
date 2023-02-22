import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import '../domain/request.dart';
import '../myDrawer.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'MobList.dart';
import 'mobDetails.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
  return HomeState();
}
}

class HomeState extends State<Home> {

  List<dynamic> listsearch = [] ;

  Future getData() async {
    var url = Uri.parse(urlBase+'search.php');
    var response = await http.get(url);
    var respnsebody = jsonDecode(response.body);
    for(int i=0 ; i < respnsebody.length ; i++){
      listsearch.add(respnsebody[i]['username']);
    }
  }

  Future getPhone() async {

    var response = await http.get(Uri.parse(urlBase+'inde.php'));
    var respnsebody = jsonDecode(response.body);
     return respnsebody;

  }
  @override
  void initState() {
       getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Acceuil',style: TextStyle(fontSize: 22),),
          centerTitle: true,
          elevation: 2,
          actions: [
            IconButton(icon: const Icon(Icons.search), onPressed: () {
               showSearch(context: context, delegate: DataSearch(list: listsearch));
            },)
          ],
          primary: true,
        ),
        drawer: const MyDrawer(),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            SizedBox(
              height: 200,width: double.infinity,
              child: Carousel(
                images: const [
                  AssetImage('images/p1.JPG'),
                  AssetImage('images/p2.JPG'),
                  AssetImage('images/p4.JPG'),
                ],
                boxFit: BoxFit.cover,
                dotColor: Colors.blueGrey,
                dotBgColor: Colors.yellowAccent.withOpacity(0.2),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(3),
              child: const Text(
                'Categories',
                style: TextStyle(fontSize: 30, color: Colors.blue),
              ),
            ),

            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  //Start Categories
                  InkWell(
                    child: SizedBox(
                      height: 80,
                      width: 100,
                      child: ListTile(
                        title: Image.asset(
                          'images/c6.PNG',
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain,
                          ),
                        subtitle: const Text(
                          'Samsung',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('samsung');
                    },
                  ),
                  InkWell(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: ListTile(
                        title: Image.asset(
                          'images/c5.JPG',
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                        subtitle: const Text(
                          'Apple',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('iphone');
                    },
                  ),
                  InkWell(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: ListTile(
                        title: Image.asset(
                          'images/c1.JPG',
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                        subtitle: const Text(
                          'Huawei',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('huawei');
                    },
                  ),
                  InkWell(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: ListTile(
                        title: Image.asset(
                          'images/O1.jpg',
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                        subtitle: const Text(
                          'Oppo',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('oppo');
                    },
                  ),
                  InkWell(
                    child: SizedBox(
                      height: 100,
                      width: 100,
                      child: ListTile(
                        title: Image.asset(
                          'images/R1.png',
                          width: 80,
                          height: 80,
                          fit: BoxFit.contain,
                        ),
                        subtitle: const Text(
                          'Realme',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('realme');
                    },
                  ),

                ], //End Categories
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: const Text(
                'Tous les produits : ',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue,
                ),
              ),
            ),
            //Start Latest Products

            FutureBuilder(
              future: getPhone(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Card(color: Colors.white70,
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
                                          snapshot.data[i]['username'],
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
                                Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 10.0),
                                  child: FlatButton(
                                    onPressed: () {},
                                    color: Colors.red[200],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: const Text(
                                      "Invite",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              ],
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
            )
          //End
          ],
        ),
      ),
    );
  }
}


class DataSearch extends SearchDelegate<String>{

  List<dynamic> list ;
  DataSearch({required this.list});
  Future getsearchData() async {
    var url = Uri.parse(urlBaseAdmin+'searchmob.php');
    var data = {"searchmobile" : query};
    var response = await http.post(url,body: data);
    var respnsebody = jsonDecode(response.body);
    return respnsebody;

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
                itemCount: snapshot.data.length,
                itemBuilder: (context, i) {
                return MobList(id: snapshot.data[i]['id'], des: snapshot.data[i]['des'], id_cat: snapshot.data[i]['id_cat'], img: snapshot.data[i]['img'], password: snapshot.data[i]['password'], tel: snapshot.data[i]['tel'], username: snapshot.data[i]['username']);

        });
      }
      return const Center(child:CircularProgressIndicator());
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    var searchlis= query.isEmpty ? list : list.where((p) => p.startsWith(query)).toList();
    return ListView.builder(itemCount:searchlis.length,itemBuilder: (context, i){
        return ListTile(leading: const Icon(Icons.mobile_screen_share),title: Text(searchlis[i]),
        onTap: (){
          query = searchlis[i];
          showResults(context);
        },);

    });
  }

}

class phone extends StatelessWidget {
  final id;
  final username;
  final tel;
  final password;
  final id_cat;
  final img;
  final des;
   phone(this.id, this.username, this.tel, this.password, this.id_cat, this.img, this.des);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: SizedBox(height: 270,
        child: GridTile(
            child: Image.network(urlBaseAdmin+"upload/$img",
              fit: BoxFit.contain,
            ),
            footer: Container(margin: const EdgeInsets.only(bottom: 10),
              height: 40,
              color: Colors.black.withOpacity(0.5),
              child: Row(
                children: [
                  Text(
                    username ,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700,fontSize: 20),
                  ),const Text(
                    "   " ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),const Text(
                    "cv" ,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                ],
              ),
            ),

        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return MobDetails(id: id,username: username,tel: tel, des: des, img: img, id_cat: id_cat, password: password);
        }));
      },
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('id', id));
  }
}










/*

            FutureBuilder(
              future: getPhone(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                List<dynamic> snap = listphone;
                List<dynamic> sna = listphon;
                List<dynamic> sn = listpho;

                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(snapshot.hasError){
                  return Center(
                    child: Text('error fatch'),
                  );
                }
                for(int i=0; i<listphone.length; i++ )
                return Container(height: 500,
                  child: ListView.builder(
                      itemCount: snap.length,
                      itemBuilder: (context, index){
                        return SizedBox(

                          height: 500,
                          child: GridView(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                            children: [
                              InkWell(
                                child: GridTile(
                                  child: Image.network("http://172.20.10.4/img/${sna[i]}",
                                    fit: BoxFit.contain,
                                  ),
                                  footer: Container(
                                    height: 20,
                                    color: Colors.black.withOpacity(0.5),
                                    child: Row(
                                      children: [
                                        Text(
                                          listphone[i] ,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white, fontWeight: FontWeight.w700),
                                        ),Text(
                                          "   " ,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white, fontWeight: FontWeight.w700),
                                        ),Text(
                                          sn[i] ,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white, fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                onTap: () => {
                                  debugPrint("P30 Pro")
                                },
                              ),




                            ],
                          ),
                        );
                      }
                  ),
                );
              },

            )





showDialog(context: context, builder: (context){
                return AlertDialog(title: Text("search"),content: Container(height: 100,child: Column(children: [
                  Text("Entre le nom du phone qui tu recherche"),
                  TextFormField(decoration: InputDecoration(
                    hintText: "écrire ici",
                  ),),
                ],),),actions: [
                      FlatButton(onPressed: (){}, child: Text("Ok")),
                      FlatButton(onPressed: (){Navigator.of(context).pop();}, child: Text("Anuller")),
                ],);
              });
*/
