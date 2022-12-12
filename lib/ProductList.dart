import 'package:flutter/material.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _key, // Assign the key to Scaffold.
        drawer: const Drawer(),
        backgroundColor: Colors.cyan,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.cyan,
            title: const Text("Product List"),
            leading: IconButton(
                onPressed: () {
                  _key.currentState!.openDrawer(); // <-- Opens drawer
                },
                icon: const Icon(Icons.menu)),
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.search,
                      size: 26.0,
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(Icons.more_vert),
                  )),
            ]),
      ),
    );
  }
}
