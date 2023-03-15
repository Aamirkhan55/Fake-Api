import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Example3 extends StatefulWidget {
  const Example3({Key? key}) : super(key: key);

  @override
  State<Example3> createState() => _Example3State();
}

class _Example3State extends State<Example3> {

  var data;

  Future<void> getUserApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if(response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    }else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Api Practise'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
               future: getUserApi(),
                builder: (context, snapshot) {
                 if(snapshot.connectionState == ConnectionState.waiting) {
                   return const Text('Loading');
                 }else {
                   return ListView.builder(
                       itemCount: data.length,
                       itemBuilder: (context, index) {
                     return Card(
                       child: Column(
                         children: [
                           ReusedRow(
                               title: 'id',
                               value: data![index]['id'].toString()),
                           ReusedRow(
                             title: 'Name',
                             value: data![index]['name'].toString(),
                           ),
                           ReusedRow(
                             title: 'Address',
                             value: data![index]['address'].toString(),
                           ),
                           ReusedRow(
                               title: 'Street',
                               value: data![index]['address']['street'].toString(),
                           ),
                           ReusedRow(
                               title: 'City',
                               value: data![index]['address']['city'].toString(),
                           ),
                           ReusedRow(
                               title: 'Geo',
                               value: data![index]['address']['geo'].toString(),
                           ),
                         ],
                       ),
                     );
                   });
                 }
                }
            ),
          ),
        ],
      ),
    );
  }
}

class ReusedRow extends StatelessWidget {
  String title, value;
  ReusedRow({Key? key, required this.title, required this.value,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}

