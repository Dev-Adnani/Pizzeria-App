import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:pizzeria/core/services/firebase.service.dart';
import 'package:provider/provider.dart';

class MiddleNotifier with ChangeNotifier {
  Widget textFav() {
    return Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: RichText(
        text: TextSpan(
            text: "Best ",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black,
              fontSize: 30.0,
            ),
            children: [
              TextSpan(
                text: 'Bites!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
      ),
    );
  }

  Widget dataFav({required BuildContext context, required String collection}) {
    return Container(
      height: 250,
      child: FutureBuilder(
        future: Provider.of<FirebaseService>(context, listen: false)
            .fetchData(collection: collection),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset('assets/animation/delivery.json'),
            );
          } else {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {},
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      width: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(40.0),
                        ),
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey.shade400,
                          width: 3.1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  height: 140,
                                  width: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 2.0,
                                      right: 32.0,
                                    ),
                                    child: Image.network(
                                      snapshot.data[index].data()['image'],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 120.0,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      EvaIcons.heart,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                snapshot.data[index].data()['name'],
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4),
                              child: Text(
                                snapshot.data[index].data()['category'],
                                style: TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.cyan,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.star, color: Colors.yellow),
                                      Text(
                                        snapshot.data[index]
                                            .data()['rating']
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 30.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.rupeeSign,
                                          size: 12,
                                        ),
                                        Text(
                                          snapshot.data[index]
                                              .data()['price']
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
