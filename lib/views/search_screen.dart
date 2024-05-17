import 'package:cached_network_image/cached_network_image.dart';
import 'package:fake_store/controllers/product_controller.dart';
import 'package:fake_store/views/product_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:photo_view/photo_view.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final _productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70.0,
        backgroundColor: Colors.white,
        title: TextField(
          controller: _productController.searchController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide.none,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            hintText: 'Search product...',
            hintStyle: GoogleFonts.kantumruyPro(
              fontSize: 15.0,
              color: Theme.of(context).primaryColor,
            ),
            fillColor: Theme.of(context).primaryColor.withOpacity(0.1),
            filled: true,
          ),
          onChanged: (query) {
            _productController.searchProduct(query);
          },
        ),
      ),
      body: GetBuilder<ProductController>(
        builder: (_) {
          if (_productController.isLoading) {
            return Center(
              child: LoadingAnimationWidget.prograssiveDots(
                  color: Theme.of(context).primaryColor, size: 25.0),
            );
          } else if (_productController.searchedList.isEmpty) {
            return Center(
              child: Text(
                'No data!',
                style: GoogleFonts.kantumruyPro(
                  fontSize: 15.0,
                  color: Colors.red,
                ),
              ),
            );
          } else {
            return MasonryGridView.count(
              padding: const EdgeInsets.all(15.0),
              physics: const BouncingScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              itemCount: _productController.searchedList.length,
              itemBuilder: (context, index) {
                final pro = _productController.searchedList[index];
                return Card(
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => ProductDetailScreen(pro: pro));
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // image
                        Hero(
                          tag: pro.title ?? '',
                          child: GestureDetector(
                            onTap: () {
                              Get.to(
                                () => Stack(
                                  alignment: Alignment.topRight,
                                  children: [
                                    // image
                                    Hero(
                                      tag: pro.title ?? '',
                                      child: PhotoView(
                                        loadingBuilder: (context, event) {
                                          return Center(
                                              child: LoadingAnimationWidget.prograssiveDots(
                                              color: Colors.white,
                                              size: 30.0,
                                            ),
                                          );
                                        },
                                        imageProvider: CachedNetworkImageProvider(
                                          pro.image ?? '',
                                        ),
                                      ),
                                    ),
                                            
                                    // group icon
                                    SafeArea(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            // back button
                                            CircleAvatar(
                                              backgroundColor: Colors.white,
                                              child: IconButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                icon: Icon(
                                                  Icons.close,
                                                  size: 25.0,
                                                  color: Theme.of(context).primaryColor,
                                                ),
                                              ),
                                            ),
                                            
                                            // save image button
                                            const SizedBox(width: 10.0),
                                            GetBuilder<ProductController>(
                                              builder: (_) {
                                                return CircleAvatar(
                                                  backgroundColor: Colors.white,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      _productController.saveImage(pro.image ?? '');
                                                    },
                                                    icon: Center(
                                                        child: _productController.isLoading
                                                            ? LoadingAnimationWidget.prograssiveDots(
                                                                color: Theme.of(context).primaryColor,
                                                                size: 20.0,
                                                              )
                                                            : Icon(
                                                                Icons.save_alt,
                                                                color: Theme.of(context).primaryColor,
                                                              )
                                                            ),
                                                  ),
                                                );
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: CachedNetworkImage(
                                imageUrl: pro.image ?? '',
                                errorWidget: (context, url, error) {
                                  return const Center(
                                    child: Icon(
                                      Icons.error_outline,
                                      color: Colors.red,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                  
                        // description
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // pro title
                              const SizedBox(height: 5.0),
                              Text(
                                pro.title ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                  
                              // price & toggle love
                              const SizedBox(height: 5.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // pro price
                                  Text(
                                    '\$ ${pro.price}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: GoogleFonts.kantumruyPro(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                  
                                  // toggle love
                                  CircleAvatar(
                                    backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                                    child: IconButton(
                                      onPressed: () {
                                        _productController.toggleLove(pro.id!.toInt());
                                      },
                                      icon: Icon(
                                        pro.isLoved ? Icons.favorite : Icons.favorite_border,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                  
                              // add to cart
                              const SizedBox(height: 10.0),
                              GestureDetector(
                                onTap: () {
                                  _productController.addToCart(pro);
                                },
                                child: Container(
                                    height: 45.0,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: pro.isInCart
                                          ? Theme.of(context).primaryColor
                                          : Theme.of(context).primaryColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Icon(
                                      pro.isInCart
                                          ? Icons.shopping_cart_rounded
                                          : Icons.shopping_cart_outlined,
                                      color: pro.isInCart
                                          ? Colors.white
                                          : Theme.of(context).primaryColor,
                                    )
                                  ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}