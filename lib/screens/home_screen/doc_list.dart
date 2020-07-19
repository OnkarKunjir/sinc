import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../file_operations.dart';
import './doc_card.dart';

class DocList extends StatelessWidget {
  final List<String> docNames;
  final List<String> thumbnails;
  final deleteCallback;
  final FileOperations fileOperations;
  DocList({
    @required this.docNames,
    @required this.thumbnails,
    @required this.deleteCallback,
    @required this.fileOperations,
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
            fileOperations: this.fileOperations,
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
                    child: Container(
                  width: size.width,
                  height: size.height * 0.8,

                  child: SvgPicture.asset(
                    'assets/images/empty.svg',
                    fit: BoxFit.fitWidth,
                  ),
                  // child: Image.asset(
                  //   'assets/images/empty.png',
                  //   fit: BoxFit.fitWidth,
                  //   height: 400,
                  // ),
                ))
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
