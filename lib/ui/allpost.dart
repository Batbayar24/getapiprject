import 'package:flutter/material.dart';
import 'package:getapiproject/model/post.dart';
import 'package:getapiproject/ui/more_info.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<List<Post>> getPost() async{
  final res = await http.get(Uri.parse('http://192.168.43.70:8000/api/post'));
  if(res.statusCode==200){
    List data = json.decode(res.body);
    print(res.body);
    List<Post> posts = data.map((data) => new Post.fromJson(data)).toList();
    return posts;
  }else{
    throw Exception("Aldaatai bn");
  }
}

class GetPost extends StatefulWidget {
  const GetPost({ Key? key }) : super(key: key);

  @override
  State<GetPost> createState() => _GetPostState();
}

class _GetPostState extends State<GetPost> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Post>>(
        future: getPost(),
        builder: (context, AsyncSnapshot snapshot){
          if(snapshot.hasData){
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index){
                    return Card(
                      child: ListTile(
                          title: Text(snapshot.data[index].title),
                          subtitle: Text(snapshot.data[index].description),
                          onTap: () {
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (BuildContext ctx) => 
                                  MoreInfo(id: snapshot.data[index].id),
                                  ),
                                );
                          }),
                      
                    );
                  
                });
          }else if(snapshot.hasError) {
            return Text("data irsengvi ee:${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}