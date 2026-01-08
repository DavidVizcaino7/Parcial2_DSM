import 'package:flutter/material.dart';

class ExitoView extends StatelessWidget {
  const ExitoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Éxito')),
      body: const Center(
        child: Text(
          'Cuenta creada correctamente 🎉',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
