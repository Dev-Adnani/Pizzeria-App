import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pizzeria/app/routes/app.routes.dart';
import 'package:pizzeria/core/services/auth.service.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(),
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
                text: TextSpan(
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
                  child: Text(
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
                  child: Text(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 2.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        labelText: "Enter Email",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      controller: userEmailController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 2.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        labelText: "Enter Password",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      controller: userPasswordController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  MaterialButton(
                    color: Colors.black,
                    minWidth: 140,
                    height: 34,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
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
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.homeRoute);
                            userEmailController.clear();
                            userPasswordController.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                '${Provider.of<AuthNotifier>(context, listen: false).getErrorMessage}',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ));
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Fill All Details',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ));
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 150.0),
                    child: Divider(
                      thickness: 4.0,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 2.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        labelText: "Enter Email",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      controller: userEmailController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 2.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        labelText: "Enter Password",
                        labelStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      controller: userPasswordController,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  MaterialButton(
                    color: Colors.black,
                    minWidth: 140,
                    height: 34,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
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
                            .signUpAccount(
                          email: userEmailController.text,
                          password: userPasswordController.text,
                        )
                            .then((value) {
                          if (value) {
                            Navigator.of(context)
                                .pushReplacementNamed(AppRoutes.homeRoute);
                            userEmailController.clear();
                            userPasswordController.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                '${Provider.of<AuthNotifier>(context, listen: false).getErrorMessage}',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ));
                          }
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Fill All Details',
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ));
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
