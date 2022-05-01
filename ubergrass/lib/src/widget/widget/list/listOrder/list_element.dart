import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constant/size.dart';
import '../../button/custom_simple_button.dart';
import '../../placement/custom_center.dart';

class ListElementOrder extends StatelessWidget {
  const ListElementOrder({
    Key? key,
    required this.map,
    required this.maxChar,
    required this.position,
    required this.onAccept,
    required this.scrollController,
  }) : super(key: key);

  final dynamic map;
  final int maxChar;
  final int position;
  final VoidCallback? onAccept;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (map["Name"] == null || map["Name"]!.isEmpty) {
      return Container();
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                map["Name"] ?? "Empty Title",
                style: GoogleFonts.montserrat(
                  fontSize: largeTextSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              "Address of the Seller: " + map["Address_Seller"],
              style: GoogleFonts.montserrat(
                fontSize: mediumTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              "Address of the Buyer: " + map["Address_Buyer"],
              style: GoogleFonts.montserrat(
                fontSize: mediumTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              "Quantity: " + map["Quantity"].toString(),
              style: GoogleFonts.montserrat(
                fontSize: mediumTextSize,
                fontWeight: FontWeight.normal,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  map["Distance"] + " estimated",
                  style: GoogleFonts.montserrat(
                    fontSize: mediumTextSize,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            CustomSimpleButton(
              onPress: onAccept ?? () {},
              child: Text(
                "Accept",
                style: GoogleFonts.montserrat(
                  color: Colors.white,
                  fontSize: mediumTextSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
