import 'package:flutter/material.dart';

class FloatingActionMenu extends StatefulWidget {
  const FloatingActionMenu({super.key});

  @override
  FloatingActionMenuState createState() => FloatingActionMenuState();
}

class FloatingActionMenuState extends State<FloatingActionMenu>
    with SingleTickerProviderStateMixin {
  bool isOpen = false;

  void toggleMenu() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  Widget buildMenuItem(String text, IconData icon, VoidCallback onTap) {
    return AnimatedOpacity(
      opacity: isOpen ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(text),
          ),
          FloatingActionButton(
            mini: true,
            onPressed: onTap,
            child: Icon(icon),
            backgroundColor: Colors.black,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(title: Text("Floating Action Menu")),
      body: Center(child: Text("Press the button")),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isOpen)
            buildMenuItem("Attachment", Icons.attach_file, () {
              // Handle attachment action
            }),
          if (isOpen)
            buildMenuItem("Camera", Icons.camera_alt, () {
              // Handle camera action
            }),
          if (isOpen)
            buildMenuItem("Create Note", Icons.note_add, () {
              // Handle create note action
            }),
          FloatingActionButton(
            onPressed: toggleMenu,
            backgroundColor: Colors.brown,
            child: Icon(isOpen ? Icons.close : Icons.add),
          ),
        ],
      ),
    );
  }
}