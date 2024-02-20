import 'package:flutter/material.dart';

class ImageSelectorTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(bool?) onTap;
  const ImageSelectorTextField({
    super.key,
    required this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: TextField(
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 250, 250, 250),
              focusColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
            ),
            controller: controller,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48),
          child: OutlinedButton(
            onPressed: () => onTap(true),
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
            ),
            child: const Center(
              child: Text(
                'Выбрать',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
