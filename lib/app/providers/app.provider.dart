import 'package:pizzeria/app/providers/test.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// App Provider Class For Adding All Providers - Dev Adnani
class AppProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => Test()),
  ];
}
