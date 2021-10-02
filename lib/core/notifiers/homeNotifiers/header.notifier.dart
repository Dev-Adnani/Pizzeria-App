import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pizzeria/core/services/maps.service.dart';
import 'package:provider/provider.dart';

class HeaderNotifier with ChangeNotifier {
  Widget appBar({required BuildContext context}) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.userAlt,
                color: Colors.grey.shade600,
              ),
            ),
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.locationArrow,
                  size: 16.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 250,
                      maxHeight: 150,
                    ),
                    child: Text(
                      Provider.of<GenerateMaps>(context, listen: true)
                          .finalAddress,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  FontAwesomeIcons.search,
                  color: Colors.black,
                )),
          ],
        ),
      ),
    );
  }

  Widget headerText() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 250.0),
      child: RichText(
        text: const TextSpan(
            text: 'What would you like',
            style: TextStyle(
                fontWeight: FontWeight.w300,
                color: Colors.black,
                fontSize: 30.0),
            children: [
              TextSpan(
                text: ' to eat?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              )
            ]),
      ),
    );
  }

  Widget headerMenu({required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  color: Colors.orange.shade100),
              height: 40.0,
              width: 100.0,
              child: const Center(
                child: Text(
                  'All Food',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  color: Colors.orange.shade100),
              height: 40.0,
              width: 100.0,
              child: const Center(
                child: Text(
                  'Pasta',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(50.0),
                  ),
                  color: Colors.orange.shade100),
              height: 40.0,
              width: 100.0,
              child: const Center(
                child: Text(
                  'Pizza',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
