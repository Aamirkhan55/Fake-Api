import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Example5 extends StatefulWidget {
  const Example5({Key? key}) : super(key: key);

  @override
  State<Example5> createState() => _Example5State();
}

class _Example5State extends State<Example5> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future signIn(String email, password) async{
    try{
      Response response = await post(
        Uri.parse('https://reqres.in/api/register'),
         // For Login
         // Uri.parse('https://reqres.in/api/login'),
        body : {
          'email': email,
          'password': password,
        }
      );
      if(response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        
        //For Login
        //print(data['token']);
        //print('Account Login Successfully');
        
        
        print('Account Created Successfully');
      }else {
        print('Failed');
    }

    }catch(e) {
      return e.toString();
    }
  }

  @override
  void dispose() {
     _emailController.dispose();
     _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Api'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                color: Colors.grey,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20),
                  ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                      fillColor: Colors.grey,
                      filled: true,
                    ),
                  ),
                ),
              ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Container(
              color: Colors.grey,
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    fillColor: Colors.grey,
                    filled: true,
                  ),
                ),
              ),
            ),
          ),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: GestureDetector(
          onTap: () {
            signIn(
              _emailController.text.toString(),
              _passwordController.text.toString(),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 65,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
                'Sign In',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
          ),
        )
      )],
      ),
    );
  }
}
