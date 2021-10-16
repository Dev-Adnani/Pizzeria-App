import 'package:cache_manager/core/write_cache_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:pizzeria/app/constants/app.keys.dart';
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
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [
                  0.2,
                  0.45,
                  0.6,
                  0.9
                ],
                    colors: [
                  Colors.grey,
                  Colors.orange,
                ])),
          ),
          SizedBox(
            height: 500.0,
            width: MediaQuery.of(context).size.width,
            child: SizedBox(
              height: 200.0,
              width: 400.0,
              child: Lottie.asset('assets/animation/pizza.json'),
            ),
          ),
          Positioned(
            top: 420.0,
            left: 10.0,
            child: SizedBox(
              height: 200.0,
              width: 200.0,
              child: RichText(
                text: const TextSpan(
                  text: 'Welcome ',
                  style: TextStyle(
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 46.0),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'To Pizzeria ',
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 40.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 600.0,
            child: SizedBox(
              width: 400.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      signUpSheet(context: context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      width: 100.0,
                      height: 50.0,
                      child: const Center(
                        child: Text('Sign Up',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      loginSheet(context: context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                      ),
                      width: 100.0,
                      height: 50.0,
                      child: const Center(
                        child: Text('Login',
                            style: TextStyle(
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 720.0,
              left: 20.0,
              right: 20.0,
              child: Container(
                width: 400.0,
                constraints: const BoxConstraints(maxHeight: 200.0),
                child: Column(
                  children: [
                    Text("By continuing you agree Pizzeria's Terms of ",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12.0)),
                    Text("Services & Privacy Policy",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 12.0))
                  ],
                ),
              ))
        ],
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
                            WriteCache.setString(
                                key: AppKeys.userEmail,
                                value: userEmailController.text);
                            WriteCache.setString(
                                key: AppKeys.userPassword,
                                value: userPasswordController.text);
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
                            WriteCache.setString(
                                key: AppKeys.userEmail,
                                value: userEmailController.text);
                            WriteCache.setString(
                                key: AppKeys.userPassword,
                                value: userPasswordController.text);
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
