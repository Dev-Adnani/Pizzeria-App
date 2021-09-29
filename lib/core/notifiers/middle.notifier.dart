import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pizzeria/app/routes/app.routes.dart';
import 'package:pizzeria/core/services/firebase.service.dart';
import 'package:provider/provider.dart';

class MiddleNotifier with ChangeNotifier {
  Widget favText() {
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

  Widget favData({required BuildContext context, required String collection}) {
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
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.detailRoute,
                      arguments: snapshot.data[index],
                    );
                  },
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
                              padding: EdgeInsets.only(top: 4.0, right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0)),
                                    child: Row(
                                      children: [
                                        Icon(Icons.star, color: Colors.yellow),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            snapshot.data[index]
                                                .data()['rating']
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 30.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          '₹ ${snapshot.data[index].data()['price'].toString()}',
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

  Widget businessText() {
    return Padding(
      padding: EdgeInsets.only(top: 5.0),
      child: RichText(
        text: TextSpan(
            text: "Business ",
            style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black,
              fontSize: 30.0,
            ),
            children: [
              TextSpan(
                text: 'Lunch!',
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

  Widget businessData(
      {required BuildContext context, required String collection}) {
    return Container(
        height: 400,
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
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 3.1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                height: 100,
                                width: 100,
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: 20,
                                  backgroundImage: NetworkImage(
                                      snapshot.data[index].data()['image']),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(right: 60.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    snapshot.data[index]
                                        .data()['name']
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data[index]
                                        .data()['category']
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                  Text(
                                    'Orignal Price : ₹ ${snapshot.data[index].data()['notPrice'].toString()}',
                                    style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Discounted Price : ₹ ${snapshot.data[index].data()['price'].toString()}',
                                        style: TextStyle(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
