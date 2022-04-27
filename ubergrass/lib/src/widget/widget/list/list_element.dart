import 'package:flutter/material.dart';

class ListElement extends StatelessWidget {
  const ListElement({
    Key? key,
    required this.list,
    required this.maxChar,
    required this.position,
    required this.onPressDelete,
    required this.onPressCard,
    required this.scrollController,
  }) : super(key: key);
  
  final Map<String, List<String?>?> list;
  final int maxChar;
  final int position;
  final VoidCallback onPressDelete;
  final VoidCallback onPressCard;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    if (list["titles"] == null) {
      return Container();
    }
    return Card(
      child: InkWell(
        onTap: onPressCard,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      list["titles"]?[position] ?? "Empty Title",
                      style: const TextStyle(
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
        ),
      ),
    );
  }
}
