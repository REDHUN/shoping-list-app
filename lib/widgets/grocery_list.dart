import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopinglist/data/categories.dart';

import 'package:shopinglist/models/grocery_item.dart';

import 'package:http/http.dart' as http;
import 'package:shopinglist/widgets/new%20_item.dart';

class GrocesoryList extends StatefulWidget {
  const GrocesoryList({super.key});

  @override
  State<GrocesoryList> createState() => _GrocesoryListState();
}

class _GrocesoryListState extends State<GrocesoryList> {
  List<GroceryItem> _groceoryList = [];
  @override
  void initState() {
    _loadItem();
    super.initState();
  }

  void _loadItem() async {
    final url =
        Uri.https('download-e903e.firebaseio.com', 'shopping-list.json');
    final response = await http.get(url);
    final Map<String, dynamic> listData = jsonDecode(response.body);

    List<GroceryItem> loadedItems = [];
    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value["category"]!)
          .value;

      loadedItems.add(GroceryItem(
          id: item.key,
          name: item.value["name"],
          quantity: item.value["quantity"],
          category: category));
      // print(loadedItems.length);
      // print(item.value[" name "]);
    }

    setState(() {
      _groceoryList = loadedItems;
    });
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push(
      MaterialPageRoute(builder: (ctx) => const NewItem()),
    );
    // _loadItem();
    if (newItem == null) {
      return;
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
