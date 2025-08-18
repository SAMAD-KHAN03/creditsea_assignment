import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mobScreeController = StateProvider<TextEditingController>((ref) {
  TextEditingController controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});

final passwordController = StateProvider<TextEditingController>((ref) {
  TextEditingController controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
final otpDigitsProvider = StateProvider<List<TextEditingController>>((ref) {
  late List<TextEditingController> _controllers;
  _controllers = List.generate(6, (index) => TextEditingController());
  ref.onDispose(() {
    for (var controller in _controllers) {
      controller.dispose();
    }
  });
  return _controllers;
});

final refpasswordController = StateProvider<TextEditingController>((ref) {
  TextEditingController controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});

final verificationId = StateProvider<String>((ref) {
  return "";
});

final emailOtpController = StateProvider<List<TextEditingController>>((ref) {
  late List<TextEditingController> _controllers;
  _controllers = List.generate(6, (index) => TextEditingController());
  ref.onDispose(() {
    for (var controller in _controllers) {
      controller.dispose();
    }
  });
  return _controllers;
});
