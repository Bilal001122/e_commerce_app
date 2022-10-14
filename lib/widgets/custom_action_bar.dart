import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../services/database.dart';

class CustomActionBar extends StatelessWidget {
  final String? text;
  final bool hasBackArrow;
  final bool hasTitle;

  const CustomActionBar(
      {Key? key, this.text, this.hasBackArrow = false, this.hasTitle = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');
    return Container(
      decoration: BoxDecoration(),
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: 24,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (hasBackArrow)
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          if (hasTitle)
            Text(
              text ?? 'Action Bar',
              style: Constants.boldHeading,
            ),
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: StreamBuilder<List<int>>(
                  stream: DatabaseService().productsCart,
                  builder: (context, snapshot) {
                    int? totalItems = 0;
                    if (snapshot.connectionState == ConnectionState.active) {
                      final productsCart = snapshot.data;
                      totalItems = productsCart?.length;
                    }
                    return Text(
                      '$totalItems',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
