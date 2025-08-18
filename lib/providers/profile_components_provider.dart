import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firstnameController = StateProvider<TextEditingController>((ref) {
  TextEditingController controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
final lastnameController = StateProvider<TextEditingController>((ref) {
  TextEditingController controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
final emailController = StateProvider<TextEditingController>((ref) {
  TextEditingController controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
final genderController = StateProvider<String?>((ref) => null);
final maritalStatus = StateProvider<String?>((ref) => null);
final dobController = StateProvider<DateTime?>((ref) => null);


final pandCardNumber = StateProvider<TextEditingController>((ref) {
  TextEditingController controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
