import 'package:pizzeria/core/notifiers/header.notifier.dart';
import 'package:pizzeria/core/notifiers/middle.notifier.dart';
import 'package:pizzeria/core/services/firebase.service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// App Provider Class For Adding All Providers - Dev Adnani
class AppProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => HeaderNotifier()),
    ChangeNotifierProvider(create: (_) => MiddleNotifier()),
    ChangeNotifierProvider(create: (_) => FirebaseService()),
  ];
}
