import 'package:flutter/material.dart';

 buildAppBar(String appTitle) {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        // const Icon(Icons.arrow_back, size: 30),
        Expanded(
          child: Center(
            child: Text(
              appTitle,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
            ),
          ),
        ),

        // const Icon(Icons.edit),
      ],
    ),
  );
}
