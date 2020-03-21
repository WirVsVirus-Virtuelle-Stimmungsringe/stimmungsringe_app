import 'package:flutter/widgets.dart';
import 'package:flutter/cupertino.dart';

class AvatarRow extends StatefulWidget {
  final String name;
  final ImageProvider image;
  final Color gradientStartColor;
  final Color gradientEndColor;

  const AvatarRow({
    Key key,
    @required this.name,
    @required this.image,
    @required this.gradientStartColor,
    @required this.gradientEndColor,
  }) : super(key: key);

  @override
  _SelfAvatarRowState createState() {
    return _SelfAvatarRowState();
  }
}

class _SelfAvatarRowState extends State<AvatarRow> {
  final double avatarSize = 150;
  final GlobalKey imageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: avatarSize + 20,
      child: Stack(
        children: <Widget>[
          Container(
            height: avatarSize - (avatarSize / 7),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [widget.gradientStartColor, widget.gradientEndColor],
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Container(
              width: avatarSize,
              height: avatarSize,
              decoration: new BoxDecoration(
                image: new DecorationImage(
                  image: widget.image,
                  fit: BoxFit.cover,
                ),
                borderRadius:
                    new BorderRadius.all(new Radius.circular(avatarSize / 2)),
                border: new Border.all(
                  color: const Color(0xffffffff),
                  width: 4.0,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: avatarSize + 20 + 10,
            child: Text(
              widget.name,
              style: TextStyle(
                color: Color(0x7f000000),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
