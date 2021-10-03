import 'package:flutter/material.dart';
import 'package:pizzeria/app/routes/app.routes.dart';
import 'package:pizzeria/core/services/maps.service.dart';
import 'package:provider/provider.dart';

class Maps extends StatelessWidget {
  const Maps({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Provider.of<GenerateMaps>(context, listen: false).fetchMaps(),
            Positioned(
                top: 700,
                left: 30,
                child: Container(
                    color: Colors.blueGrey,
                    width: 300.0,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Expanded(
                          child: Text(
                            Provider.of<GenerateMaps>(context, listen: true)
                                .getMainAddress,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ))),
            Positioned(
              top: 0,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.cartRoute);
                },
                icon: const Icon(Icons.arrow_back_ios_new_outlined,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
