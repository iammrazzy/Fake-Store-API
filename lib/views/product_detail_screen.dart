import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_store/controllers/product_controller.dart';
import 'package:fake_store/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:readmore/readmore.dart';

class ProductDetailScreen extends StatelessWidget {
  ProductDetailScreen({super.key, required this.pro});

  final ProductModel pro;
  final _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: 70.0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          pro.title ?? '',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: GoogleFonts.kantumruyPro(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          GetBuilder<ProductController>(builder: (_) {
            return CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                onPressed: () {
                  _productController.toggleLove(pro.id!.toInt());
                },
                icon: Icon(
                  pro.isLoved ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            );
          }),
          const SizedBox(width: 15.0),
        ],
      ),
      body: GetBuilder<ProductController>(
        builder: (_) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // pro image
                const SizedBox(height: 20.0),
                Stack(
                  children: [
                    Hero(
                      tag: pro.title ?? '',
                      child: Container(
                        height: 250.0,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: CachedNetworkImageProvider(pro.image ?? ''),
                          ),
                        ),
                      ),
                    ),

                    // add to cart
                    GestureDetector(
                      onTap: () {
                        _productController.toggleCart(pro);
                      },
                      child: Container(
                        height: 250.0,
                        width: 50.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Icon(
                          pro.isInCart
                            ? Icons.shopping_cart_rounded
                            : Icons.shopping_cart_outlined,
                            color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),

                // category & rating count
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Type: ${pro.category}',
                      style: GoogleFonts.kantumruyPro(
                        fontSize: 15.0,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_border_rounded,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 5.0),
                          Text(
                            pro.rating!.count.toString(),
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 15.0,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // group product items
                const SizedBox(height: 15.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 20.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // pro title
                      const SizedBox(height: 15.0),
                      Shimmer.fromColors(
                        baseColor: Theme.of(context).primaryColor,
                        highlightColor: Colors.red,
                        child: Text(
                          pro.title ?? '',
                          style: GoogleFonts.kantumruyPro(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // qty & total price
                      const SizedBox(height: 25.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  backgroundColor: Theme.of(context).primaryColor.withOpacity(.1),
                                  child: Icon(
                                    Icons.remove,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Text(
                                '${_productController.totalEachItemQty(pro.id!.toInt()).toString()}x',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 18.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              GestureDetector(
                                onTap: () {
                                  _productController.increaseQty(pro.id!.toInt());
                                },
                                child: CircleAvatar(
                                  radius: 15.0,
                                  backgroundColor: Theme.of(context).primaryColor.withOpacity(.1),
                                  child: Icon(
                                    Icons.add,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // right
                          Text(
                            'Total: \$${_productController.totalEachItemPrice(pro.id!.toInt())}',
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                        ],
                      ),

                      // description
                      const SizedBox(height: 30.0),
                      Text(
                        'Description',
                        style: GoogleFonts.kantumruyPro(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),


                      const SizedBox(height: 5.0),
                      Divider(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                      ),
                      const SizedBox(height: 5.0),

                      ReadMoreText(
                        pro.description ?? '',
                        trimLines: 5,
                        colorClickableText: Colors.red,
                        trimMode: TrimMode.Line,
                        trimCollapsedText: 'More',
                        trimExpandedText: ' Less',
                        style: GoogleFonts.kantumruyPro(
                          fontSize: 15.0,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
