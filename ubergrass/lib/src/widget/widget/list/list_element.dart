import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListElement extends StatelessWidget {
  const ListElement({
    Key? key,
    required this.map,
    required this.maxChar,
    required this.position,
    required this.onPressDelete,
    required this.onPressCard,
    required this.scrollController,
  }) : super(key: key);

  final dynamic map;
  final int maxChar;
  final int position;
  final VoidCallback onPressDelete;
  final VoidCallback onPressCard;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (map["Name"] == null || map["Name"]!.isEmpty) {
      return Container();
    }
    return Card(
      child: InkWell(
        onTap: onPressCard,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          map["Name"] ?? "Empty Title",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: onPressDelete,
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          map["Quantity"].toString(),
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    map["Price"].toString() + "€ pour " + map["Weight"].toString() + "g",
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
