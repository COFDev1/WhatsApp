import 'package:flutter/foundation.dart';

class Contact {
  final String id;
  final String name;
  final String phone;
  final Category category;

  Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.category,
  });
}
