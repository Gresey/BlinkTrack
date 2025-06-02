import 'package:blinktrack/theme.dart';
import 'package:flutter/material.dart';

class Bottomnavigationbar extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const Bottomnavigationbar({
    super.key,
    this.currentIndex = 0,
    required this.onTap,
  });

  @override
  State<Bottomnavigationbar> createState() => _BottomnavigationbarState();
}

class _BottomnavigationbarState extends State<Bottomnavigationbar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BottomNavigationBar(
          selectedItemColor: AppColors.primary,
          backgroundColor: AppColors.background,
          currentIndex: widget.currentIndex,
          onTap: widget.onTap,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                backgroundColor: AppColors.background,
                icon: SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset('assets/map.png')),
                label: 'Map'),
            BottomNavigationBarItem(icon: Icon(Icons.group), label: 'Circle'),
            BottomNavigationBarItem(
                icon: SizedBox(
                    height: 24,
                    width: 24,
                    child: Image.asset('assets/sos.png')),
                label: 'Sos'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings')
          ]),
    );
  }
}
