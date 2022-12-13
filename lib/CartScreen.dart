import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_with_shoppingcart/DbHelper.dart';

import 'Cart_Provider.dart';
import 'Cartmodel.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  DBHelper? dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<Cartprovider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.cyan,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: const Text(
            "Cart List",
          ),
        ),
        body: Column(
          children: [
            FutureBuilder(
                future: cartProvider.getData(),
                builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text('Your cart is empty 😌',
                                style:
                                    Theme.of(context).textTheme.headlineSmall),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                                'Explore products and shop your\nfavourite items',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.titleSmall)
                          ],
                        ),
                      );
                    } else {
                      return Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 0,
                                  color: Colors.cyan[200],
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Image(
                                                width: 100,
                                                height: 100,
                                                image: NetworkImage(snapshot
                                                    .data![index].image
                                                    .toString())),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        snapshot.data![index]
                                                            .productName
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            dbHelper!.delete(
                                                                snapshot
                                                                    .data![
                                                                        index]
                                                                    .id!);
                                                            cartProvider
                                                                .removeCounter();
                                                            cartProvider.removeTotalprice(
                                                                double.parse(snapshot
                                                                    .data![
                                                                        index]
                                                                    .productPrice
                                                                    .toString()));
                                                          },
                                                          child: const Icon(
                                                              Icons.delete)),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                      "${snapshot.data![index].unitTag} \$${snapshot.data![index].initialPrice}",
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.bottomRight,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      child: Container(
                                                          height: 35,
                                                          width: 100,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                  onTap: () {
                                                                    int quentity = snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity!;
                                                                    int price = snapshot
                                                                        .data![
                                                                            index]
                                                                        .productPrice!;
                                                                    if (quentity !=
                                                                        1) {
                                                                      quentity--;
                                                                    } else {
                                                                      quentity;
                                                                    }
                                                                    int?
                                                                        newprice =
                                                                        price *
                                                                            quentity;
                                                                    dbHelper
                                                                        ?.updatedQuentity(Cart(
                                                                            id: snapshot.data![index].id!,
                                                                            productId: snapshot.data![index].id.toString(),
                                                                            productName: snapshot.data![index].productName!,
                                                                            initialPrice: snapshot.data![index].productPrice!,
                                                                            productPrice: newprice,
                                                                            quantity: quentity,
                                                                            unitTag: snapshot.data![index].unitTag.toString(),
                                                                            image: snapshot.data![index].image.toString()))
                                                                        .then((value) {
                                                                      print(
                                                                          "updated successfully");
                                                                    }).onError((error, stackTrace) {
                                                                      print(
                                                                          error);
                                                                      print(
                                                                          "updated failed");
                                                                    });
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons
                                                                        .remove,
                                                                    color: Colors
                                                                        .white,
                                                                  )),
                                                              Text(
                                                                  snapshot
                                                                      .data![
                                                                          index]
                                                                      .quantity
                                                                      .toString(),
                                                                  style: const TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                              InkWell(
                                                                  onTap: () {
                                                                    int quentity = snapshot
                                                                        .data![
                                                                            index]
                                                                        .quantity!;
                                                                    int price = snapshot
                                                                        .data![
                                                                            index]
                                                                        .productPrice!;
                                                                    quentity++;
                                                                    int?
                                                                        newprice =
                                                                        price *
                                                                            quentity;
                                                                    dbHelper
                                                                        ?.updatedQuentity(Cart(
                                                                            id: snapshot.data![index].id!,
                                                                            productId: snapshot.data![index].id.toString(),
                                                                            productName: snapshot.data![index].productName!,
                                                                            initialPrice: snapshot.data![index].productPrice!,
                                                                            productPrice: newprice,
                                                                            quantity: quentity,
                                                                            unitTag: snapshot.data![index].unitTag.toString(),
                                                                            image: snapshot.data![index].image.toString()))
                                                                        .then((value) {
                                                                      print(
                                                                          "updated successfully");
                                                                    }).onError((error, stackTrace) {
                                                                      print(
                                                                          error);
                                                                      print(
                                                                          "updated failed");
                                                                    });
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons.add,
                                                                    color: Colors
                                                                        .white,
                                                                  )),
                                                            ],
                                                          )),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }));
                    }
                  } else {
                    return const Text('');
                  }
                })
            
          ],
        ),
      ),
    );
  }
}
