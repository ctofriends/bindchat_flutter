import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(title: Text('BindChat')),
        body: Container(
            color: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Column(children: <Widget>[
              TextField(
                  decoration: InputDecoration(hintText: 'What do you like?')),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 200, height: 200),
                      child: ElevatedButton(
                        child: Text(
                          'Button',
                          style: TextStyle(fontSize: 24),
                        ),
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ])));
  }
}
