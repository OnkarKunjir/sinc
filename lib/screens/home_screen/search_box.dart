import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 10,
      floating: true,
      snap: true,
      pinned: true,
      title: Text('Sinc'),
      leading: IconButton(icon: Icon(Icons.menu), onPressed: () => null),
      expandedHeight: 110,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(80),
          bottomRight: Radius.circular(80),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: <Widget>[
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Container(
                height: 40,
                margin: EdgeInsets.symmetric(horizontal: 20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                ),
                child: TextField(
                  autofocus: false,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    alignLabelWithHint: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
