import 'package:flutter/material.dart';
import 'package:final_project/services/service.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  Service service = Service();
  String cat;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          
         backgroundColor:Color.fromARGB(255, 66, 68, 107),
        ),
        body: Card(
          child: Container(
            child: Form(
              child: Column(children: <Widget>[
                Text('Kategori isimini giriniz'),
                SizedBox(height: 20.0),
                TextFormField(
                  validator: (val) => val.isEmpty ? 'Kategori girin' : null,
                  onChanged: (val) {
                    setState(() {
                      cat = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                 RaisedButton(
                color: Color.fromARGB(255, 66, 68, 107),
                child: Text(
                  'Ekle',style:TextStyle(color: Colors.white),
                ),
                onPressed: ()  {
                 service.addCategory(cat);
                }),SizedBox(height: 12.0),
              ]),
            ),
          ),
        ));
  }

 
}
