import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider_with_shoppingcart/DbHelper.dart';
import 'package:provider/provider.dart';
import 'package:provider_with_shoppingcart/Utils.dart';

import 'Cart_Provider.dart';
import 'Cartmodel.dart';
class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  List<String> productName = [
    'Mango',
    'Orange',
    'Grapes',
    'Banana',
    'Chery',
    'Peach',
    'Mixed Fruit Basket',
  ];
  List<String> productUnit = [
    'KG',
    'Dozen',
    'KG',
    'Dozen',
    'KG',
    'KG',
    'KG',
  ];
  List<int> productPrice = [10, 20, 30, 40, 50, 60, 70];
  List<String> productImage = [
    'https://image.shutterstock.com/image-photo/mango-isolated-on-white-background-600w-610892249.jpg',
    'https://image.shutterstock.com/image-photo/orange-fruit-slices-leaves-isolated-600w-1386912362.jpg',
    'https://image.shutterstock.com/image-photo/green-grape-leaves-isolated-on-600w-533487490.jpg',
    'https://media.istockphoto.com/photos/banana-picture-id1184345169?s=612x612',
    'https://media.istockphoto.com/photos/cherry-trio-with-stem-and-leaf-picture-id157428769?s=612x612',
    'https://media.istockphoto.com/photos/single-whole-peach-fruit-with-leaf-and-slice-isolated-on-white-picture-id1151868959?s=612x612',
    'https://media.istockphoto.com/photos/fruit-background-picture-id529664572?s=612x612',
  ];

  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<Cartprovider>(context);

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
                    child: const Center(
                      child: Icon(
                        Icons.search,
                        size: 26.0,
                      ),
                    ),
                  )),
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: GestureDetector(
                      onTap: () {},
                      child: Center(
                        child: Badge(
                          badgeContent: Consumer<Cartprovider>(
                              builder: (context, value, child) {
                            return Text(
                              value.getcounter().toString(),
                              style: const TextStyle(color: Colors.cyan),
                            );
                          }),
                          badgeColor: Colors.white,
                          child: const Icon(Icons.shopping_bag),
                        ),
                      ))),
            ]),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: productImage.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(top: 10.h),
                        child: Card(
                          elevation: 0,
                          color: Colors.cyan[200],
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      height: 100.h,
                                      width: 100.w,
                                      child: Image(
                                          image: NetworkImage(
                                              productImage[index].toString())),
                                    ),
                                    SizedBox(
                                      width: 8.h,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          productName[index].toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        Text(
                                          "${productUnit[index]}  \$${productPrice[index]}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        SizedBox(
                                          height: 8.h,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            dbHelper!
                                                .insertData(Cart(
                                                    id: index,
                                                    productId:
                                                        (index + 1).toString(),
                                                    productName:
                                                        productName[index]
                                                            .toString(),
                                                    initialPrice:
                                                        productPrice[index],
                                                    productPrice:
                                                        productPrice[index],
                                                    quantity: 1,
                                                    unitTag: productUnit[index]
                                                        .toString(),
                                                    image: productImage[index]
                                                        .toString()))
                                                .then((value) => {
                                                      cart.addTotalprice(
                                                          double.parse(
                                                              productPrice[
                                                                      index]
                                                                  .toString())),
                                                      cart.addCounter(),
                                                      Utils.Toasts(
                                                          "Cart added successfull")
                                                    })
                                                .onError((error, stackTrace) =>
                                                    {
                                                      print(error),
                                                      Utils.Toasts(
                                                          "Cart Did not added !")
                                                    });
                                          },
                                          child: Container(
                                            height: 30.h,
                                            width: 100.w,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.r)),
                                                color: Colors.cyan[700]),
                                            child: const Text("Add To Cart"),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
