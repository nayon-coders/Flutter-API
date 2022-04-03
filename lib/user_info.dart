import 'dart:convert';

import 'package:api_practice/model/Usermodel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {

  //create a list
  List<Usermodel> UserList = [];

  //API Response
  Future<List<Usermodel>> getUserInfo() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        UserList.add(Usermodel.fromJson(i));
        return UserList;
      }
    }else{
      return UserList;
    }
    return getUserInfo();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Complex User Informatoion"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserInfo(),
                builder: (context, AsyncSnapshot<List<Usermodel>> snapshot){
                if(snapshot.hasData){
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
                      itemCount: UserList.length,
                      itemBuilder: (BuildContext context, int index) {
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
                                UserDetails(title: "User Name: ", value: UserList[index].username.toString()),
                                UserDetails(title: "Name: ", value: UserList[index].name.toString()),
                                UserDetails(title: "Email: ", value: UserList[index].email.toString()),
                                UserDetails(title: "Phone Number: ", value: UserList[index].phone.toString()),
                                UserDetails(title: "Website: ", value: UserList[index].website.toString()),
                                UserDetails(title: "Address: ", value:
                                UserList[index].address!.street.toString()+", " + UserList[index].address!.city.toString() + ", " + UserList[index].address!.zipcode.toString()),
                                UserDetails(title: "Google Map: ", value:
                                "Lat:" +UserList[index].address!.geo!.lat.toString() + ", Lan:" +UserList[index].address!.geo!.lng.toString()),

                                UserDetails(title: "Company Name: ", value: UserList[index].company!.name.toString()),
                                UserDetails(title: "Position: ", value: UserList[index].company!.bs.toString()),
                              ],
                            ),
                          ),
                        );
                      },

                    );
                  }

                }else{
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
                }

                }
            ),
          )

        ],
      ),
    );
  }
}
class UserDetails extends StatelessWidget {
  final String title, value;
  UserDetails({required this.title, required this.value});

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

