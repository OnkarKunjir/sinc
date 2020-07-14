import 'package:flutter/material.dart';
import './doc_card.dart';
import '../../colors.dart';

class DocList extends StatelessWidget {
  final List<String> _docNames = [];

  DocList() {
    _getDocNames();
  }

  void _getDocNames() {
    const featchedNames = [
      'Algorithums book',
      'TOC notes',
      'bing bong',
      'ching chong'
    ];
    _docNames.addAll(featchedNames);
  }

  List<DocCard> _generateCard() {
    return List.generate(_docNames.length, (index) {
      return DocCard(
          title: _docNames[index],
          thumbnail:
              index.isEven ? 'assets/images/0.jpeg' : 'assets/images/1.jpeg');
    });
  }

  @override
  Widget build(BuildContext context) {
    return _docNames.length == 0
        ? SliverList(
            delegate: SliverChildListDelegate(
              [
                Image.asset(
                  'assets/images/empty.png',
                  fit: BoxFit.fitWidth,
                  height: 400,
                ),
              ],
            ),
          )
        : SliverGrid.count(
            childAspectRatio: 7 / 8,
            crossAxisCount: 2,
            children: _generateCard(),
          );
  }
}
