import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PhotoScreen extends StatefulWidget {
  const PhotoScreen({Key? key}) : super(key: key);

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  
  List<PhotoModel> photoList = [];
  
  Future<List<PhotoModel>> getPhoto() async{
    final response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data = jsonDecode(response.body.toString()); 
    if(response.statusCode == 200){
      for(Map i in data){
        PhotoModel photoModel = PhotoModel(title: i['title'], url: i["url"], id: i['id']);
        photoList.add(photoModel);
      }
      return photoList;
    }else{
      return photoList;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API Photo showing"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhoto(),
                builder: (context, AsyncSnapshot<List<PhotoModel>> snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: photoList.length,
                        itemBuilder: (context, index){
                        return  ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(snapshot.data![index].url.toString()),
                            backgroundColor: Colors.grey,
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(snapshot.data![index].id.toString()),
                              Text(snapshot.data![index].title.toString()),
                            ],
                          ),
                        );
                          // return Card(
                          //   elevation: 3,
                          //   child: Padding(
                          //     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          //     child: Image.network(snapshot.data![index].url.toString())
                          //   ),
                          // );
                        }
                    );
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

class PhotoModel{
  final String title;
  final String url;
  final int id;

  PhotoModel({required this.title, required this.url, required this.id});
}
