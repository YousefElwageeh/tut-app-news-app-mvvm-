import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'app/app.dart';
import 'app/app_prefs.dart';
import 'data/network/dio_factory.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppPreferences.init();
  await DioFactory.getDio();

  runApp(
    Phoenix(child: MyApp()),
  );
}
