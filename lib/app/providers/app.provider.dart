import 'package:pizzeria/core/notifiers/detailNotifers/detail.calculations.notifier.dart';
import 'package:pizzeria/core/notifiers/homeNotifiers/footer.notifier.dart';
import 'package:pizzeria/core/notifiers/homeNotifiers/header.notifier.dart';
import 'package:pizzeria/core/notifiers/homeNotifiers/middle.notifier.dart';
import 'package:pizzeria/core/services/auth.service.dart';
import 'package:pizzeria/core/services/firebase.service.dart';
import 'package:pizzeria/core/services/maps.service.dart';
import 'package:pizzeria/core/services/payment.service.dart';
import 'package:pizzeria/core/utils/obscure.util.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

// App Provider Class For Adding All Providers - Dev Adnani
class AppProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => AuthNotifier()),
    ChangeNotifierProvider(create: (_) => ObscureTextState()),
    ChangeNotifierProvider(create: (_) => FirebaseService()),
    ChangeNotifierProvider(create: (_) => HeaderNotifier()),
    ChangeNotifierProvider(create: (_) => MiddleNotifier()),
    ChangeNotifierProvider(create: (_) => FooterNotfier()),
    ChangeNotifierProvider(create: (_) => GenerateMaps()),
    ChangeNotifierProvider(create: (_) => DetailCalculations()),
    ChangeNotifierProvider(create: (_) => PaymentService()),
  ];
}
