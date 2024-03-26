import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StatusButton extends HookWidget {
  const StatusButton(
      {super.key,
      required this.isSelected,
      required this.status,
      required this.onSelectedButton});

  final String status;
  final bool isSelected;
  final void Function() onSelectedButton;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: isSelected ? const Color.fromARGB(255, 173, 180, 255) : null,
      borderRadius: BorderRadius.circular(20),
      minSize: 0,
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
      onPressed: onSelectedButton,
      child: Text(
        status,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isSelected
              ? Colors.white
              : const Color.fromARGB(255, 204, 203, 203),
        ),
      ),
    );
  }
}
