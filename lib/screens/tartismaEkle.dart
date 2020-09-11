import 'package:flutter/material.dart';
import 'package:final_project/services/service.dart';

class TartismaEkle extends StatefulWidget {  static const routeName = '/tartisEkle';

  @override
  _TartismaEkleState createState() => _TartismaEkleState();
}

class _TartismaEkleState extends State<TartismaEkle> {
  Service service = Service();
  String baslik;
  String konu;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor:  Color.fromARGB(250, 58, 60, 94)
                .withOpacity(.9), //         ,
        ),
        body: Card(
          child: Container(
            child: Form(
              child: Column(children: <Widget>[
                SizedBox(height: 20.0),Text('Konu başlığını giriniz',style: TextStyle(color:Color.fromARGB(250, 58, 60, 94)
                .withOpacity(.6),)),
                TextFormField(
                
                  validator: (val) => val.isEmpty ? 'Konuyu Başlığını Giriniz' : null,
                  onChanged: (val) {
                    setState(() {
                      baslik = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                Text('Konu ile ilgili fikrinizi giriniz',style: TextStyle(color:Color.fromARGB(250, 58, 60, 94)
                .withOpacity(.6),),),
                 TextFormField(
                   maxLines: 10,
                   keyboardType: TextInputType.multiline,

                  validator: (val) => val.isEmpty ? 'Konu içeriği' : null,
                  onChanged: (val) {
                    setState(() {
                      konu = val;
                    });
                  },
                ),
                 RaisedButton(
                color:  Color.fromARGB(250, 58, 60, 94)
                .withOpacity(.6), //         
                child: Text(
                  'Ekle',style:TextStyle(color: Colors.white),
                ),
                onPressed: ()  {
                 service.addTartisma(baslik,konu);service.baslikTartisma(baslik);
                                 Navigator.pushNamed(context, "/tartis");

                }),SizedBox(height: 12.0),
              ]),
            ),
          ),
        ));
  }

 
}
