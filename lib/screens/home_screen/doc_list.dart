import 'package:flutter/material.dart';
import './doc_card.dart';

// TODO : Use thumbnails from storage.
class DocList extends StatelessWidget {
  final List<String> docNames;
  final deleteCallback;
  DocList({@required this.docNames, @required this.deleteCallback});

  double cardWidth = 0;
  double cardHeight = 0;

  List<Widget> _generateCard(context) {
    return List.generate(
      docNames.length,
      (index) {
        return GestureDetector(
          onLongPress: () {
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('Delete ${docNames[index]}?'),
                action: SnackBarAction(
                    label: 'Delete', onPressed: () => deleteCallback(index)),
              ),
            );
          },
          child: DocCard(
              title: docNames[index],
              cardHeight: cardHeight,
              thumbnail: index.isEven
                  ? 'assets/images/0.jpeg'
                  : 'assets/images/1.jpeg'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print((size.width * 0.5) / (size.height * 0.3));
    this.cardWidth = size.width * 0.5;
    this.cardHeight = size.height * 0.3;

    return docNames.length == 0
        ? SliverList(
            delegate: SliverChildListDelegate(
              [
                Center(
                  child: Image.asset(
                    'assets/images/empty.png',
                    fit: BoxFit.fitWidth,
                    height: 400,
                  ),
                ),
              ],
            ),
          )
        : SliverGrid.count(
            // childAspectRatio: 0.87,
            childAspectRatio: this.cardWidth / this.cardHeight,
            crossAxisCount: 2,
            children: _generateCard(context),
          );
  }
}
