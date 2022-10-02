import 'package:flutter/material.dart';

import '../widgets/custom_action_bar.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomActionBar(
          text: 'Saved',
        ),
        Center(
          child: Text(
            'Saved',
          ),
        ),
      ],
    );
  }
}
