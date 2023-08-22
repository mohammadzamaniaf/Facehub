import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 100,
      height: 100,
      child: Card(
        color: Colors.black54,
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20, width: double.infinity),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
