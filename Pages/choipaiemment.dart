import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class choidepaiemment extends StatefulWidget {
  final id;
  choidepaiemment({this.id});

  @override
  _choidepaiemmentState createState({id}) => _choidepaiemmentState({id});
}

class _choidepaiemmentState extends State<choidepaiemment> {
  final id;
  _choidepaiemmentState(this.id);
  Future delletPhone() async {
    var data = {"postd": 18};
     http.post(Uri.parse('http://172.20.10.4/mobitech/dellet.php'), body: data);
    //final respnsebody = jsonDecode(response.body);
    //return respnsebody
    //
    print("bonjour");
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Choisie le mode du paiemment'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              alignment: Alignment.center,
              height: 150,

              child: InkWell(
                  child: Container(color: Colors.white,
                    child:
                      Image.asset("images/images.png",fit: BoxFit.cover,),
                  ),
                onTap: (){
                  setState(() {
                    var data = {"postd": id};
                    http.post(Uri.parse('http://172.20.10.4/mobitech/dellet.php'), body: data);
                  });
                  debugPrint('delete Clicked');
                },
              ),
            ),
            InkWell(
              child: Container(
                alignment: Alignment.center,
                height: 150,
                color: Colors.grey,
                child: Row(
                  children: [
                    Image.asset("images/logoMasrviB.png"),

                  ],
                ),
              ),
              onTap: (){
                  setState(() {
                    var data = {"postd": id};
                    http.post(Uri.parse('http://172.20.10.4/mobitech/dellet.php'), body: data);
                  });
                  debugPrint('delete Clicked');
                },

            ),
          ],
        ));
    ;
  }
}
