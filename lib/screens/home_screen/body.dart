import 'package:flutter/material.dart';
import './search_box.dart';
import './doc_list.dart';

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: <Widget>[
        SearchBox(),
        DocList(),
      ],
    );
  }
}
