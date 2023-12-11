import 'package:flutter/material.dart';
import 'package:shopinglist/data/dummy_items.dart';
import 'package:shopinglist/widgets/new%20_item.dart';

class GrocesoryList extends StatefulWidget {
  const GrocesoryList({super.key});

  @override
  State<GrocesoryList> createState() => _GrocesoryListState();
}

class _GrocesoryListState extends State<GrocesoryList> {
  void _addItem() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (ctx) => const NewItem()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      body: ListView.builder(
          itemCount: groceryItems.length,
          itemBuilder: (ctx, index) => ListTile(
                title: Text(groceryItems[index].name),
                leading: Container(
                  height: 24,
                  width: 24,
                  color: groceryItems[index].category.color,
                ),
                trailing: Text(groceryItems[index].quantity.toString()),
              )),
    );
  }
}
