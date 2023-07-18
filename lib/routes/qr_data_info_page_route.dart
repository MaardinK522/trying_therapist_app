import 'package:flutter/material.dart';

class QRDataPageRoute extends StatelessWidget {
  final String data;

  const QRDataPageRoute({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(data),
      ),
    );
  }
}
