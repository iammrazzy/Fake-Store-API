import 'package:fake_store/controllers/delivery_controller.dart';
import 'package:fake_store/controllers/payment_controller.dart';
import 'package:fake_store/controllers/product_controller.dart';
import 'package:fake_store/views/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckOutScreen extends StatelessWidget {
  CheckOutScreen({super.key});

  final _productController = Get.put(ProductController());
  final _paymentController = Get.put(PaymentController());
  final _deliveryController = Get.put(DeliveryController());

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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Checkout',
              style: GoogleFonts.kantumruyPro(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Cart checkout proccess',
              style: GoogleFonts.kantumruyPro(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // shipping address
            const SizedBox(height: 20.0),
            Text(
              'Shipping address',
              style: GoogleFonts.kantumruyPro(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),

            // location
            const SizedBox(height: 15.0),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // row items
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Wat Ounalom Monastery',
                        style: GoogleFonts.kantumruyPro(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // do something
                        },
                        child: Text(
                          'Change',
                          style: GoogleFonts.kantumruyPro(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5.0),
                  Text(
                    'Cambodia Samdach Sothearos Boulevard Phnom Penh, Preah Ang Eng St. (13), Phnom Penh 12206',
                    style: GoogleFonts.kantumruyPro(
                      fontSize: 15.0,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // payment method
            const SizedBox(height: 15.0),
            GetBuilder<PaymentController>(
              builder: (_) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(_paymentController.paymentList.length, (index) {
                      final payment = _paymentController.paymentList[index];
                        return GestureDetector(
                          onTap: () {
                            _paymentController.selectPaymentMethod(index);
                          },
                          child: Row(
                            children: [
                          
                              // Check box
                              Checkbox(
                                value: payment.isSelected,
                                onChanged: (value) {
                                  _paymentController.selectPaymentMethod(index);
                                },
                                shape: CircleBorder(
                                  side: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                  )
                                ),
                              ),
                          
                              // logo
                              const SizedBox(width: 10.0),
                              CircleAvatar(
                                backgroundImage: AssetImage(payment.paymentLogo),
                              ),

                              // name
                              const SizedBox(width: 25.0),
                              Text(
                                payment.paymentName,
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
            ),

            // delivery method
            const SizedBox(height: 20.0),
            Text(
              'Delivery method',
              style: GoogleFonts.kantumruyPro(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),

            // delivery method
            const SizedBox(height: 15.0),
            GetBuilder<DeliveryController>(
              builder: (_) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(_deliveryController.deliveryList.length, (index) {
                      final delivery = _deliveryController.deliveryList[index];
                        return GestureDetector(
                          onTap: () {
                            _deliveryController.selectDeliveryMethod(index);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              right: 5.0,
                            ),
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: delivery.isSelected ? delivery.deliveryColor : Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(10.0),
                              color: delivery.deliveryColor.withOpacity(0.1),
                            ),
                            child: Column(
                              children: [
                                // image
                                Image.asset(
                                  delivery.deleveryLogo,
                                  height: 60.0,
                                  width: 120.0,
                                ),
                          
                                // duration
                                Text(
                                  delivery.duration,
                                  style: GoogleFonts.kantumruyPro(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold, 
                                    color: delivery.deliveryColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),

            // total all items
            const SizedBox(height: 15.0),
            GetBuilder<ProductController>(
              builder: (_) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // total cart items
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total cart items:',
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            '${_productController.cartList.length.toString()}x',
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 15.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),

                      // total quantities items
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total quantities:',
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            '${_productController.allTotalQty().toString()}x',
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 15.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),

                      // payment method that selected
                      GetBuilder<PaymentController>(
                        builder: (_) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Payment method:',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Text(
                                _paymentController.getSelectedPayment()?.paymentName ?? 'No selected!',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 15.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          );
                        }
                      ),

                      // delivery method that selected
                      GetBuilder<DeliveryController>(
                        builder: (_) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Delivery method:',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              Text(
                                _deliveryController.getSelectedDelivery()?.deliverName ?? 'No selected!',
                                style: GoogleFonts.kantumruyPro(
                                  fontSize: 15.0,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          );
                        }
                      ),

                      // discount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total discount:',
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            '\$${'0.0'}',
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 15.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ],
                      ),

                      // total prices
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total prices:',
                            style: GoogleFonts.kantumruyPro(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          Text(
                            '\$${_productController.allTotalPriceUSA().toString()}',
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
              },
            ),

            // continue button
            const SizedBox(height: 15.0),
            GestureDetector(
              onTap: () {
                Get.to(()=> PaymentScreen());
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Continue',
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
