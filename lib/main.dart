import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Dock(
            items: [
              Icons.person,
              Icons.message,
              Icons.call,
              Icons.camera,
              Icons.photo,
              Icons.music_note,
              Icons.alarm,
              Icons.map,
              Icons.email,
              Icons.settings,
              Icons.shopping_cart,
              Icons.favorite,
            ],
          ),
        ),
      ),
    );
  }
}

class Dock extends StatefulWidget {
  const Dock({super.key, required this.items});

  final List<IconData> items;

  @override
  State<Dock> createState() => _DockState();
}

class _DockState extends State<Dock> {
  late final List<IconData> _items = widget.items.toList();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.black12,
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _items
            .asMap()
            .entries
            .map(
              (entry) => Draggable<IconData>(
                data: entry.value,
                feedback: Material(
                  color: Colors.transparent,
                  child: _buildDockItem(entry.value),
                ),
                childWhenDragging: const SizedBox.shrink(),
                onDragCompleted: () {},
                child: DragTarget<IconData>(
                  onAccept: (receivedItem) {
                    setState(() {
                      final draggedIndex = _items.indexOf(receivedItem);
                      final targetIndex = entry.key;
                      _items.removeAt(draggedIndex);
                      _items.insert(targetIndex, receivedItem);
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return _buildDockItem(entry.value);
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildDockItem(IconData icon) {
    return Container(
      constraints: const BoxConstraints(minWidth: 48),
      height: 48,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.primaries[icon.hashCode % Colors.primaries.length],
      ),
      child: Center(child: Icon(icon, color: Colors.white)),
    );
  }
}
