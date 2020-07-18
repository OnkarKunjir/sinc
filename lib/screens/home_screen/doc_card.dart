import 'package:flutter/material.dart';
import 'dart:io';
import '../../file_operations.dart';
import '../../colors.dart';
import '../viewdoc_screen/viewdoc_screen.dart';

class DocCard extends StatelessWidget {
  final FileOperations fileOperations;
  final String title, thumbnail;
  String shrunked;
  final double cardHeight;
  DocCard({
    @required this.title,
    @required this.thumbnail,
    @required this.cardHeight,
    @required this.fileOperations,
  }) {
    shrunked = this.title;
    if (title.length > 15) {
      shrunked = shrunked.substring(0, 15) + '...';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 20,
            color: kShadow.withOpacity(0.3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Hero(
              tag: this.title,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewDocScreen(
                        // fileOperations: this.fi,
                        fileOperations: this.fileOperations,
                        title: this.title,
                      ),
                    ),
                  );
                },
                child: Image.file(
                  File(this.thumbnail),
                  height: this.cardHeight * 0.6,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(
              this.shrunked,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
