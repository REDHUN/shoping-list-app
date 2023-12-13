import 'package:flutter/material.dart';

import 'package:shopinglist/models/grocery_item.dart';
import 'package:shopinglist/widgets/new%20_item.dart';

class GrocesoryList extends StatefulWidget {
  const GrocesoryList({super.key});

  @override
  State<GrocesoryList> createState() => _GrocesoryListState();
}

class _GrocesoryListState extends State<GrocesoryList> {
  final List<GroceryItem> _groceoryList = [];

  void _addItem() async {
    final newItem = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewItem()));
    if (newItem == null) {
      return null;
    }
    setState(() {
      _groceoryList.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceoryList.remove(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(child: Text('Nop!!! Please Add Grocessory'));
    if (_groceoryList.isNotEmpty) {
      setState(() {
        content = ListView.builder(
            itemCount: _groceoryList.length,
            itemBuilder: (ctx, index) => Dismissible(
                  key: ValueKey(_groceoryList[index].id),
                  onDismissed: (dirction) {
                    _removeItem(_groceoryList[index]);
                  },
                  child: ListTile(
                    title: Text(_groceoryList[index].name),
                    leading: Container(
                      height: 24,
                      width: 24,
                      color: _groceoryList[index].category.color,
                    ),
                    trailing: Text(_groceoryList[index].quantity.toString()),
                  ),
                ));
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: content,
    );
  }
}
