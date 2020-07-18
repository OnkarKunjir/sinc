import 'package:flutter/material.dart';
import './doc_card.dart';

class DocList extends StatelessWidget {
  final List<String> docNames;
  final List<String> thumbnails;
  final deleteCallback;
  DocList({
    @required this.docNames,
    @required this.thumbnails,
    @required this.deleteCallback,
  });

  List<Widget> _generateCard(context, cardHeight) {
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
            thumbnail: thumbnails[index],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // print((size.width * 0.5) / (size.height * 0.3));
    double cardWidth = size.width * 0.5;
    double cardHeight = size.height * 0.3;

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
            childAspectRatio: cardWidth / cardHeight,
            crossAxisCount: 2,
            children: _generateCard(context, cardHeight),
          );
  }
}
