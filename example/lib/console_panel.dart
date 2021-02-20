import 'package:flutter/material.dart';

/// @author DoggieX
/// @create 2021/2/20 10:20
/// @mail coldpuppy@163.com

class ConsolePanel extends StatelessWidget {
  List<String> contents;

  ConsolePanel(this.contents);

  @override
  Widget build(BuildContext context) {
    if (null == contents) return Container();
    return Container(
      constraints: BoxConstraints(maxHeight: 500),
      padding: EdgeInsets.all(10),
      color: Colors.black12,
      child: ListView.builder(
          itemCount: contents.length,
          itemBuilder: (_, i) {
            String c = contents[i];
            return Text(c);
          }),
    );
  }
}
