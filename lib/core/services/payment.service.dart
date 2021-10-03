import 'package:flutter/material.dart';
import 'package:pizzeria/core/services/maps.service.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentService with ChangeNotifier {
  TimeOfDay deliveryTiming = TimeOfDay.now();

  Future selectTime({required BuildContext context}) async {
    final selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (selectedTime != null && selectedTime != deliveryTiming) {
      deliveryTiming = selectedTime;
      notifyListeners();
    }
  }

  selectLocation(BuildContext context) {
    return showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 150.0),
                  child: Divider(
                    color: Colors.white,
                    thickness: 4.0,
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 70.0,
                    child: Text(
                      'Location : ${Provider.of<GenerateMaps>(context, listen: true).getMainAddress}',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: Provider.of<GenerateMaps>(context, listen: false)
                        .fetchMaps(),
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width,
                  ),
                )
              ],
            ),
            height: MediaQuery.of(context).size.height * 0.80,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(color: Color(0xFF191531)),
          );
        });
  }

  handlePaymentSuccess(
      BuildContext context, PaymentSuccessResponse paymentSuccessResponse) {
    return showResponse(
        context: context, response: paymentSuccessResponse.paymentId!);
  }

  handlePaymentError(
      BuildContext context, PaymentFailureResponse paymentFailureResponse) {
    return showResponse(
        context: context, response: paymentFailureResponse.message!);
  }

  handleExternalWallet(
      BuildContext context, ExternalWalletResponse externalWalletResponse) {
    return showResponse(
        context: context, response: externalWalletResponse.walletName!);
  }

  showResponse({required BuildContext context, required String response}) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SizedBox(
            height: 100,
            width: 400,
            child: Text(
              'This Is Response $response',
              style: const TextStyle(),
            ),
          );
        });
  }
}
