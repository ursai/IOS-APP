import 'dart:io';

import 'package:app/contants/business_constants.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class DbUtil {
  static final DbUtil shared = DbUtil();

  late Box chatMsgBox;

  DbUtil() {
    _initDb();
  }

  void _initDb() async {
    Directory docDir = await getApplicationDocumentsDirectory();
    Hive.init('${docDir.path}/${BusinessConstants.chatFilePath}');

    chatMsgBox = await Hive.openBox(BusinessConstants.chatMsgBox);
  }
}
