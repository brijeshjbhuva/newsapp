import 'package:flutter/material.dart';

import 'my_app.dart';
import 'utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialize shared preferences here to ensure that it is initialized and can then be accessed
  await PrefsUtils.init();

  runApp(const MyApp());
}
