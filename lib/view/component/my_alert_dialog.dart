import 'package:flutter/material.dart';

myAlertDialog({required BuildContext context, required String message}) {
  return showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) => AlertDialog(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.warning_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 30,
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Text(
                    message,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ));
}
