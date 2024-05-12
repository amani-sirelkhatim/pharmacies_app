import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Use extends StatefulWidget {
  const Use({super.key});

  @override
  State<Use> createState() => _UseState();
}

class _UseState extends State<Use> {
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              Icons.circle,
              size: 10,
              color: Colors.grey,
            ),
            title: Text('data'),
          );
        });
  }
}