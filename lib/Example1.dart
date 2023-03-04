import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Models/PhotoModel.dart';


class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {

  List<PhotoModel> photosList = [];

  Future<List<PhotoModel>> getPhotoApi() async{
     final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
     var data = jsonDecode(response.body.toString());

     if (response.statusCode == 200) {
       for(Map i in data ) {
         PhotoModel photoModel = PhotoModel(id: i['id'], title: i['title'], url: i['url']);
         photosList.add(photoModel);
       }
       return photosList;
     }else {
       return photosList;
     }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Api Practise'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getPhotoApi(),
                builder: (context, AsyncSnapshot<List<PhotoModel>> snapshot) {
              return ListView.builder(
                  itemCount: photosList.length,
                  itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage : NetworkImage(snapshot.data![index].url.toString()),
                    ),
                    subtitle: Text(snapshot.data![index].title.toString()),
                    title: Text('Notes ID :${snapshot.data![index].id}'),
                    );
                  }
              );
            }),
          )
        ],
      ),
    );
  }
}
