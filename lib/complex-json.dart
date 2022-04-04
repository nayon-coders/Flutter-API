import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ComplexJsonVeiw extends StatefulWidget {
  const ComplexJsonVeiw({Key? key}) : super(key: key);

  @override
  _ComplexJsonVeiwState createState() => _ComplexJsonVeiwState();
}

class _ComplexJsonVeiwState extends State<ComplexJsonVeiw> {
var data;
  //connection api
  Future<void> getComplexJsonViewer() async{
    final response = await http.get(Uri.parse("https://webhook.site/ea3e43c6-2071-4d42-a7b2-7c6eb81014ed"));
    if(response.statusCode == 200){
     return data = jsonDecode(response.body.toString());
    }else{
     return data;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Complex Json View"),
      ),
      body:Column(
        children: [
          Expanded(
              child: FutureBuilder(
                future: getComplexJsonViewer(),
                  builder: (context , snapshot){
                  if(snapshot.hasData){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return Text("It si loging");

                    }else{
                      for(var i = 0; i > data['data'].length; i++){
                        return Text(data['data'][i]['name'].toString());
                      }

                    }
                  }else{
                    return Text("Now Data Found....");
                  }


                  }
              ),
          ),
        ],
      ),
    );
  }
}

class pRow extends StatelessWidget {
  final String ProductUrl, ProductName, ProductPrice;
  pRow({required this.ProductName, required this.ProductPrice, required this.ProductUrl});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(ProductUrl,height: 150,width: 150,),
        Text(ProductName),
        Text(ProductPrice),
      ],
    );
  }
}

