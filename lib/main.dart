import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pizzeria/app/providers/app.provider.dart';
import 'package:pizzeria/app/routes/app.routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Core());
}

class Core extends StatelessWidget {
  const Core({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AppProvider.providers,
      child: const Lava(),
    );
  }
}

class Lava extends StatelessWidget {
  const Lava({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pizzeria',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashRoute,
      routes: AppRoutes.routes,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Colors.redAccent,
        fontFamily: 'Avenir',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}
