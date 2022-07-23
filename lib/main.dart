import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:order/screens/introduction.dart';
import 'package:provider/provider.dart';

import 'services/routes_manager.dart';

class Data with ChangeNotifier {
  String place = '';
  void changePlace(String newPlace) {
    place = newPlace;
    print(place);
    notifyListeners();
  }
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ((context) => Data())),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: RouteGenerator.getRoute,
          initialRoute: Routes.splashRoute,
          home: Introduction()),
    );
  }
}
