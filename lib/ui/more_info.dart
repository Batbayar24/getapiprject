import 'package:flutter/material.dart';
import 'package:getapiproject/model/post.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

Future<Post> negPost(int id) async {
  final res =
    await http.get(Uri.parse('http://192.168.43.70:8000/api/post/${id}'));
  if(res.statusCode==200){
    
    return Post.fromJson(jsonDecode(res.body));
  }else{
    throw Exception("Aldaatai bn");
  }
}

class MoreInfo extends StatefulWidget {
  final int id;
  const MoreInfo({ Key? key, required this.id }) : super(key: key);

  @override
  State<MoreInfo> createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Дэлгэрэнгүй мэдээлэл харах"),
      ),
      body: FutureBuilder(
        future: negPost(widget.id),
        builder: (context,AsyncSnapshot snapshot) {
          return Card(
            child: ListTile(
              title: Text(snapshot.data.title),
              subtitle: Text(snapshot.data.description),
              ),
            );
        },
      ),
    );
  }
}