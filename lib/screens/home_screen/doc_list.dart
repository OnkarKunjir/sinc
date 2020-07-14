import 'package:flutter/material.dart';
import './doc_card.dart';

class DocList extends StatelessWidget {
  final List<String> docNames;

  DocList({@required this.docNames});

  List<DocCard> _generateCard() {
    return List.generate(docNames.length, (index) {
      return DocCard(
          title: docNames[index],
          thumbnail:
              index.isEven ? 'assets/images/0.jpeg' : 'assets/images/1.jpeg');
    });
  }

  @override
  Widget build(BuildContext context) {
    return docNames.length == 0
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
            childAspectRatio: 0.87,
            crossAxisCount: 2,
            children: _generateCard(),
          );
  }
}
