import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_store/controllers/product_controller.dart';
import 'package:fake_store/views/all_product_screen.dart';
import 'package:fake_store/views/check_out_screen.dart';
import 'package:fake_store/views/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});

  final _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 70.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Carts',
              style: GoogleFonts.kantumruyPro(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'All added products',
              style: GoogleFonts.kantumruyPro(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              onPressed: () {
                Get.to(()=> AllProductScreen());
              },
              icon: Icon(
                Icons.add,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(width: 15.0),
        ],
      ),
      body: GetBuilder<ProductController>(
        builder: (_) {
          return Column(
            children: [

              // cart items
              Expanded(
                child: GetBuilder<ProductController>(
                  builder: (_) {
                    if (_productController.cartList.isEmpty) {
                      return Center(
                        child: Text(
                          'No cart yet!',
                          style: GoogleFonts.kantumruyPro(
                            fontSize: 18.0,
                            color: Colors.pink,
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _productController.cartList.length,
                        itemBuilder: (context, index) {
                          final pro = _productController.cartList[index];
                          return Hero(
                            tag: pro.title ?? '',
                            child: GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => ProductDetailScreen(pro: pro)
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                margin: const EdgeInsets.all(5.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(5.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Row(
                                    children: [
                            
                                      // image
                                      SizedBox(
                                        height: 170.0,
                                        width: 110.0,
                                        child: CachedNetworkImage(
                                          imageUrl: pro.image ?? '',
                                        ),
                                      ),
                            
                                      // pro info
                                      const SizedBox(width: 20.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:CrossAxisAlignment.start,
                                          mainAxisAlignment:MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              pro.title ?? '',
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: GoogleFonts.kantumruyPro(
                                                fontSize: 17.0,
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context).primaryColor,
                                              ),
                                            ),
                                            Text(
                                              'Type: ${pro.category}',
                                              style: GoogleFonts.kantumruyPro(
                                                fontSize: 15.0,
                                                color: Theme.of(context).primaryColor,
                                              ),
                                            ),
                            
                                            // group button
                                            const SizedBox(height: 20.0),
                                            Row(
                                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                              children: [
                                                // left
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        _productController.decreaseQty(pro.id!.toInt());
                                                      },
                                                      child: CircleAvatar(
                                                        radius: 15.0,
                                                        backgroundColor:Colors.pink.withOpacity(.1),
                                                        child: const Icon(
                                                          Icons.remove,
                                                          color: Colors.pink,
                                                        ),
                                                      ),
                                                    ),
                            
                                                    // total QTY each item
                                                    const SizedBox(width: 5.0),
                                                    Text(
                                                     '${ _productController.totalEachItemQty(pro.id!.toInt()).toString()}x',
                                                      style: GoogleFonts.kantumruyPro(
                                                        fontSize: 18.0,
                                                        color: Colors.pink,
                                                      ),
                                                    ),
                            
                                                    // increase QTY
                                                    const SizedBox(width: 5.0),
                                                    GestureDetector(
                                                      onTap: () {
                                                        _productController.increaseQty(pro.id!.toInt());
                                                      },
                                                      child: CircleAvatar(
                                                        radius: 15.0,
                                                        backgroundColor:Colors.pink.withOpacity(.1),
                                                        child: const Icon(
                                                          Icons.add,
                                                          color: Colors.pink,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            
                                                // right
                                                Row(
                                                  children: [
                                                    Text(
                                                      '\$${_productController.totalEachItemPrice(pro.id!.toInt())}',
                                                      style: GoogleFonts.kantumruyPro(
                                                        fontSize: 18.0,
                                                        fontWeight:FontWeight.bold,
                                                        color: Colors.pink,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 15.0),
                                                    GestureDetector(
                                                      onTap: () {
                                                        _productController.deleteCart(pro.id!.toInt());
                                                      },
                                                      child: CircleAvatar(
                                                        radius: 15.0,
                                                        backgroundColor:Colors.pink.withOpacity(.1),
                                                        child: const Icon(
                                                          Icons.delete,
                                                          size: 20.0,
                                                          color: Colors.pink,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                            
                                      const SizedBox(width: 25.0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),

              // total
              const SizedBox(height: 10.0),
              GetBuilder<ProductController>(
                builder: (_) {
                  if (_productController.cartList.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        children: [
                          // total items
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Total Carts: ${_productController.cartList.length}',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              Text(
                                '────────',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 15.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                          // total qty
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Total Quantities: ${_productController.allTotalQty().toString()}x',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              Text(
                                '─────────',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 15.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),

                          // total price & discount
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Text(
                                  'Total Prices: \$${_productController.allTotalPriceUSA().toString()}',
                                  style: GoogleFonts.kantumruyPro(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              Text(
                                'Discount: \$${'0.0'}',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 15.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),

              // check out
              GetBuilder<ProductController>(
                builder: (_) {
                  if (_productController.cartList.isNotEmpty) {
                    return Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GestureDetector(
                        onTap: () {
                          // _productController.checkout();
                          Get.to(()=> CheckOutScreen());
                        },
                        child: Container(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color:Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Check out',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              Icon(
                                Icons.arrow_forward,
                                size: 20.0,
                                color: Theme.of(context).primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          );
        },
      ),
    );
  }
}