
import 'package:flutter/material.dart';
import 'package:blog_todoapp/custom/ConstantColor.dart';
import 'package:uuid/uuid.dart';


void showTaskInputBottomSheet({
  required BuildContext context,
  required String title,
  required String actionLabel,
  String? initialText,
  required Function(String) onSubmit,
}) {
  final TextEditingController controller = TextEditingController(text: initialText);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,  
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                maxLines: null,
                maxLength: 150,
                cursorColor: primarycolor,
                decoration: InputDecoration(
                  hintText: 'Task Title',
                  border: OutlineInputBorder(),
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  counterText: '',
                  filled: true,
                  fillColor: secondarycolor,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text('Cancel', style: TextStyle(color: primarycolor)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  TextButton(
                    child: Text(actionLabel, style: TextStyle(color: primarycolor)),
                    onPressed: () {
                      final updatedTitle = controller.text.trim();
                      if (updatedTitle.isNotEmpty) {
                        onSubmit(updatedTitle);
                      }
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
