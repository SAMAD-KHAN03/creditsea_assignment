//this will proivder screen on the steeper dashboard after authentication
import 'package:creditsea_assignment/screens/detail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

final screenProvider = StateProvider<Widget>((ref) => Detail());
