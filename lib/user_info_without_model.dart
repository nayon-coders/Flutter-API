import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WithOutModelUserInfo extends StatefulWidget {
  const WithOutModelUserInfo({Key? key}) : super(key: key);

  @override
  _WithOutModelUserInfoState createState() => _WithOutModelUserInfoState();
}

class _WithOutModelUserInfoState extends State<WithOutModelUserInfo> {
  var data; 
  Future<void> getuserInfoWithoutModel() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if(response.statusCode == 200){
      data = jsonDecode(response.body.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Show complex data Without Model"),
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
                future: getuserInfoWithoutModel(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                        child: Card(
                            elevation: 10,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: Colors.amber, ),
                            )
                        )
                    );
                  }else{
                    return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index){
                          return Card(
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: Colors.black87,
                                          borderRadius: BorderRadius.circular(100)
                                      ),
                                      child: Center(
                                        child: Text("N",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      )
                                  ),
                                  SizedBox(height: 5,),
                                  UserDetailswithoutModel(title: "User Name: ", value: data[index]["username"]),
                                  UserDetailswithoutModel(title: "User Name: ", value: data[index]["name"]),
                                  UserDetailswithoutModel(title: "Email: ", value: data[index]["email"]),
                                  UserDetailswithoutModel(title: "Address: ", value: data[index]["address"]["street"]+", "+ data[index]["address"]["city"]),
                                  UserDetailswithoutModel(title: "Google Map: ", value:"lat:" +data[index]['address']["geo"]["lat"]+", lng: "+data[index]['address']["geo"]["lng"]),

                                ],
                              ),
                            ),
                          );
                        }
                    );
                  }

                },
                
              )
          ),
        ],
      ),
    );
  }
}

class UserDetailswithoutModel extends StatelessWidget {
  final String title, value;
  UserDetailswithoutModel({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            Text(title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            Text(value,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),

      ),
    );
  }
}

