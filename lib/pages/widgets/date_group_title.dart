import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class DateGroupTitle extends StatelessWidget {
  const DateGroupTitle({super.key, required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    String formatDate(String dateString) {
      Jiffy jiffyDate = Jiffy(dateString, "yyyy-MM-dd'T'HH:mm:ssZ'");

      return jiffyDate.format("dd MMMM yyyy");
    }

    bool isToday(String dateToCheck) {
      Jiffy jiffyDate = Jiffy(dateToCheck, "yyyy-MM-dd");
      return jiffyDate.isSame(Jiffy(), Units.DAY);
    }

    bool isTomorrow(String dateToCheck) {
      Jiffy jiffyDate = Jiffy(dateToCheck, "yyyy-MM-dd");
      Jiffy tomorrow = Jiffy().add(days: 1);
      return jiffyDate.isSame(tomorrow, Units.DAY);
    }

    String getTheDate(String dateToCheck) {
      if (isToday(dateToCheck)) {
        return 'Today';
      } else if (isTomorrow(dateToCheck)) {
        return 'Tomorrow';
      } else {
        return formatDate(dateToCheck);
      }
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 20, 32, 8),
      child: Text(
        getTheDate(date),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
    );
  }
}
