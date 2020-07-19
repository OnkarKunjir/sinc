import 'package:flutter/material.dart';
import '../../colors.dart';
import '../../file_operations.dart';
import '../confim_screen/confirm_screen.dart';

class BottomBar extends StatelessWidget {
  final FileOperations fileOperations;
  final int count;
  final confirmCallback;
  BottomBar({
    @required this.fileOperations,
    @required this.count,
    @required this.confirmCallback,
  });

  void _launchConfirm(context) {
    if (this.count > 0) {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConfirmScreen(
            fileOperations: fileOperations,
            docPath: fileOperations.tempDirectory.path,
            confirmCallback: this.confirmCallback,
          ),
        ),
      );
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: Text('I think you would like to click few photos first :)'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: kPrimary,
      shape: CircularNotchedRectangle(),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          Positioned(
            right: 50,
            top: 15,
            child: IconButton(
              tooltip: 'Finish',
              icon: Icon(
                Icons.check,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => _launchConfirm(context),
            ),
          ),
          Positioned(
            left: 50,
            top: 20,
            child: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: kSecondary,
                borderRadius: BorderRadius.all(Radius.circular(100)),
              ),
              child: Center(
                  child: Text(
                '$count',
                style: TextStyle(color: Colors.white),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
