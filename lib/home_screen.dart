import 'dart:convert';
import 'package:api_practice/complex-json.dart';
import 'package:api_practice/photo_screen.dart';
import 'package:api_practice/user_info.dart';
import 'package:api_practice/user_info_without_model.dart';
import 'package:flutter/material.dart';
import 'model/PostModel.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  List<PostModel> postList = [];

  //show post data
  Future<List<PostModel>> getPostdata() async{
    //response
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200){
      for(Map i in data){
        postList.add(PostModel.fromJson(i));
      }
      return postList;
    }else {
      return postList;
    }
}
@override
  void initState() {
    print(postList.length);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>UserInfo())),
              icon: Icon(
                Icons.supervised_user_circle,
              )
          ),
          IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>WithOutModelUserInfo())),
              icon: Icon(
                Icons.verified_user,
              )
          ),
          IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context)=>ComplexJsonVeiw())),
              icon: Icon(
                Icons.add_shopping_cart,
              )
          ),
        ],
      ),
      body: Column(
        children: [
            Expanded(
              child: FutureBuilder(
                future: getPostdata(),
                  builder: (context, snapshot){
                    if(!snapshot.hasData){
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
                          itemCount: postList.length,
                          itemBuilder: (context, index){
                            return  GestureDetector(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>PhotoScreen()));
                              },
                              child: Card(
                                elevation: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(postList[index].title.toString(),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      ),
                                      const SizedBox(height: 5,),
                                      Text(postList[index].userId.toString(),
                                        style: const TextStyle(
                                          color:  Colors.deepOrangeAccent,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                      );

                    }
                  }
              ),
            ),
        ],
      ),
    );
  }
}
