import 'package:flutter/material.dart';

class NavTab {
  final int id;
  final String name;
  final IconData icon;
  final bool down;

  const NavTab({
    required this.name,
    required this.icon,
    required this.id,
    this.down = false,
  });
}
