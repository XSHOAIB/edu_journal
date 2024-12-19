import 'package:flutter/material.dart';

class VignetteEffectPage extends StatefulWidget {
  @override
  State<VignetteEffectPage> createState() => _VignetteEffectPageState();
}

class _VignetteEffectPageState extends State<VignetteEffectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Image.asset('assets/imgs/img_1.png')),
    );
  }
}
