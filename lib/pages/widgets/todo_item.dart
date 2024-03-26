import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(
      {super.key,
      required this.title,
      required this.description,
      required this.id,
      required this.onDismissItem});

  final String title;
  final String id;
  final String description;
  final void Function(DismissDirection) onDismissItem;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      onDismissed: onDismissItem,
      background: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 16, 0),
        alignment: Alignment.centerRight,
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          size: 20,
          color: Colors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(32, 12, 32, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 2,
                  ),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      height: 1.6,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.more_vert,
              size: 16,
              color: Color.fromARGB(255, 181, 180, 180),
            )
          ],
        ),
      ),
    );
  }
}
