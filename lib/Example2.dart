import 'dart:convert';
import 'dart:math';
import 'package:fake_api/UerModel/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Example2 extends StatefulWidget {
  const Example2({Key? key}) : super(key: key);

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {

  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
     var data = jsonDecode(response.body.toString());
    if(response.statusCode == 200) {
      for(Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
    }else {
      return userList;
    }
    return userList;
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
                future: getUserApi(),
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                 return ListView.builder(
                     itemCount: userList.length,
                     itemBuilder: (context, index) {
                       return Card(
                         color: Colors.primaries[Random().nextInt(30)],
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             children: [
                             reUseAblRow(
                                 title: 'Id',
                                 value: snapshot.data![index].id.toString(),
                             ),
                               reUseAblRow(
                                   title: 'Name',
                                   value: snapshot.data![index].name.toString(),
                               ),
                               reUseAblRow(
                                   title: 'Email',
                                   value: snapshot.data![index].email.toString(),
                               ),
                               reUseAblRow(
                                   title: 'Address',
                                   value: snapshot.data![index].address.toString(),
                               ),
                               reUseAblRow(
                                   title: 'Company',
                                   value: snapshot.data![index].company.toString(),
                               ),
                             ],
                           ),
                         ),
                       );
                     }
                 );
                },
              )
          )
        ],
      ),
    );
  }
}
class reUseAblRow extends StatelessWidget {
  String title, value;
   reUseAblRow({Key? key, required this.title, required this.value,}) : super(key: key);

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

