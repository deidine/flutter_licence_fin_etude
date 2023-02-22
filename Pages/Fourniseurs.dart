// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names

import 'package:awn_stage2/Pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import '../domain/request.dart';


class Fourniseurs extends StatefulWidget {
  final cat;
  final Title;
  const Fourniseurs({Key? key, required this.Title, required this.cat}) : super(key: key);

  @override
  _FourniseursState createState() => _FourniseursState();
}

class _FourniseursState extends State<Fourniseurs> {
  Future getData() async {
    final data = {"cat": widget.cat};
    final response =
        await http.post(Uri.parse(urlBase + 'index.php'), body: data);
    final respnsebody = jsonDecode(response.body);
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
      listFavorite.add(respnsebody[i]['id']);
    }
  }

  var id;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    id = preferences.getString("username");
    if (id != null) {
      setState(() {
        getFavorite();
        id = preferences.getString("id");
      });
    }
  }
  Future deleteFavorite({required String Uid, required String Aid,required bool isS,}) async{

    if(isS){
      var data = {"user_id": Uid, "admin_id": Aid};
      var response = await http
          .post(Uri.parse(urlBase+'delete.php'), body: data);
      setState(()  {
        listFavorite.remove(Aid);
        getFavorite();
      });

    }else {
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
  }

  @override
  void initState() {

    getFavorite();
    getData();
    getPref();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(widget.Title, style: const TextStyle(color: Colors.white),),
      ),
      body: FutureBuilder(
        future: getData(),
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
    );
  }
}
