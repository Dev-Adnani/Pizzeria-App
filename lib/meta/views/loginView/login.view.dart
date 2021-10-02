import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pizzeria/app/routes/app.routes.dart';
import 'package:pizzeria/core/services/auth.service.dart';
import 'package:pizzeria/core/utils/obscure.util.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200.0,
              width: 400.0,
              child: Lottie.asset('assets/animation/pizza.json'),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: RichText(
                text: const TextSpan(
                  text: 'Pizzeria ',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  color: Colors.blueGrey,
                  onPressed: () {
                    signUpSheet(context: context);
                  },
                  child: const Text(
                    'SignUp',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                MaterialButton(
                  color: Colors.teal.shade800,
                  onPressed: () {
                    loginSheet(context: context);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }

  loginSheet({required BuildContext context}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.33,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade700,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 2.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        hintText: "Enter Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      controller: userEmailController,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 2.0),
                    child: Consumer<ObscureTextState>(
                      builder: (context, obs, child) {
                        return TextFormField(
                          controller: userPasswordController,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                          obscureText: Provider.of<ObscureTextState>(context,
                                  listen: false)
                              .isTrue,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  Provider.of<ObscureTextState>(context,
                                          listen: false)
                                      .toggleObs();
                                },
                                icon: Provider.of<ObscureTextState>(context,
                                        listen: false)
                                    .switchObsIcon,
                              ),
                              hintText: "Enter Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                        );
                      },
                    ),
                  ),
                  MaterialButton(
                    color: Colors.lightBlueAccent,
                    minWidth: 140,
                    height: 34,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      if (userEmailController.text.isNotEmpty &&
                              userPasswordController.text.isNotEmpty ||
                          RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                              .hasMatch(userEmailController.text)) {
                        Provider.of<AuthNotifier>(context, listen: false)
                            .logIntoAccount(
                          email: userEmailController.text,
                          password: userPasswordController.text,
                        )
                            .then((value) {
                          if (value) {
                            showLoaderDialog(context);
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.homeRoute);
                            userEmailController.clear();
                            userPasswordController.clear();
                          } else {
                            Fluttertoast.showToast(
                              msg:
                                  "${Provider.of<AuthNotifier>(context, listen: false).getErrorMessage}",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey.shade500,
                              textColor: Colors.white70,
                              fontSize: 16.0,
                            );
                          }
                        });
                      } else {
                        Fluttertoast.showToast(
                          msg: "Please Fill All The Fields",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey.shade500,
                          textColor: Colors.white70,
                          fontSize: 16.0,
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  signUpSheet({required BuildContext context}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.33,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade700,
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 2.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.email),
                        hintText: "Enter Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      controller: userEmailController,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 2.0),
                    child: Consumer<ObscureTextState>(
                      builder: (context, obs, child) {
                        return TextFormField(
                          controller: userPasswordController,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                          ),
                          obscureText: Provider.of<ObscureTextState>(context,
                                  listen: false)
                              .isTrue,
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  Provider.of<ObscureTextState>(context,
                                          listen: false)
                                      .toggleObs();
                                },
                                icon: Provider.of<ObscureTextState>(context,
                                        listen: false)
                                    .switchObsIcon,
                              ),
                              hintText: "Enter Password",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0))),
                        );
                      },
                    ),
                  ),
                  MaterialButton(
                    color: Colors.lightBlueAccent,
                    minWidth: 140,
                    height: 34,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () {
                      if (userEmailController.text.isNotEmpty &&
                              userPasswordController.text.isNotEmpty ||
                          RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                              .hasMatch(userEmailController.text)) {
                        Provider.of<AuthNotifier>(context, listen: false)
                            .signUpAccount(
                          email: userEmailController.text,
                          password: userPasswordController.text,
                        )
                            .then((value) {
                          if (value) {
                            showLoaderDialog(context);
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.homeRoute);
                            userEmailController.clear();
                            userPasswordController.clear();
                          } else {
                            Fluttertoast.showToast(
                              msg:
                                  "${Provider.of<AuthNotifier>(context, listen: false).getErrorMessage}",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey.shade500,
                              textColor: Colors.white70,
                              fontSize: 16.0,
                            );
                          }
                        });
                      } else {
                        Fluttertoast.showToast(
                          msg: "Please Fill All The Fields",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.grey.shade500,
                          textColor: Colors.white70,
                          fontSize: 16.0,
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
