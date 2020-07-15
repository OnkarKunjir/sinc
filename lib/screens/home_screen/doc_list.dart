import 'package:flutter/material.dart';
import './doc_card.dart';

// TODO : Use thumbnails from storage.
class DocList extends StatelessWidget {
  final List<String> docNames;
  final deleteCallback;
  DocList({@required this.docNames, @required this.deleteCallback});

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
              thumbnail: index.isEven
                  ? 'assets/images/0.jpeg'
                  : 'assets/images/1.jpeg'),
        );
      },
    );
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
            children: _generateCard(context),
          );
  }
}
