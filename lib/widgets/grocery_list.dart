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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: ListView.builder(
          itemCount: _groceoryList.length,
          itemBuilder: (ctx, index) => ListTile(
                title: Text(_groceoryList[index].name),
                leading: Container(
                  height: 24,
                  width: 24,
                  color: _groceoryList[index].category.color,
                ),
                trailing: Text(_groceoryList[index].quantity.toString()),
              )),
    );
  }
}
