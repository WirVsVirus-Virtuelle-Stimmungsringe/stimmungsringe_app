import 'package:familiarise/widgets/paragraph.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';

class ShareGroupCode extends StatelessWidget {
  final String groupCode;

  const ShareGroupCode({Key? key, required this.groupCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Paragraph(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            groupCode,
            style: const TextStyle(
              color: Color(0xff951919),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          CupertinoButton(
            onPressed: () {
              Share.share(
                'Trete bei Familiarise der Fam-Group bei: $groupCode',
                subject: 'Trete Familiarise bei!',
              );
            },
            child: const Icon(
              CupertinoIcons.share,
              color: CupertinoColors.link,
            ),
          )
        ],
      ),
    );
  }
}
