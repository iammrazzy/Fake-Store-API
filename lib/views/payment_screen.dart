import 'package:fake_store/controllers/payment_controller.dart';
import 'package:fake_store/controllers/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentScreen extends StatelessWidget {
  PaymentScreen({super.key});

  final _paymentController = Get.put(PaymentController());
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
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payment',
              style: GoogleFonts.kantumruyPro(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              'Payment proccess',
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

            // payment & change
            const SizedBox(height: 15.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Payment',
                  style: GoogleFonts.kantumruyPro(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                Text(
                  'Change',
                  style: GoogleFonts.kantumruyPro(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                )
              ],
            ),

            // selected payment method
            const SizedBox(height: 15.0),
            Row(
              children: [

                // paymentLogo
                Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: 110.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Image.asset(
                    _paymentController.getSelectedPayment()?.paymentLogo ?? '',
                    height: 60.0,
                    width: 60.0,
                  ),
                ),
                const SizedBox(width: 25.0),
                Text(
                  _paymentController.getSelectedPayment()?.paymentNumber ?? '',
                  style: GoogleFonts.kantumruyPro(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),

            // location name
            const SizedBox(height: 50.0),
            Container(
              alignment: Alignment.centerLeft,
              height: 60.0,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'Wat Ounalom Monastery',
                style: GoogleFonts.kantumruyPro(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),

            // card number
            const SizedBox(height: 20.0),
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Card number',
                    style: GoogleFonts.kantumruyPro(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                    ),
                  ),
                  Text(
                    _paymentController.getSelectedPayment()?.paymentNumber ?? '',
                    style: GoogleFonts.kantumruyPro(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),

            // expire date & cvv
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                // expire date
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Expire Date',
                          style: GoogleFonts.kantumruyPro(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor.withOpacity(0.5),
                          ),
                        ),
                        Text(
                          '05/25',
                          style: GoogleFonts.kantumruyPro(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10.0),

                // cvv
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CVV',
                          style: GoogleFonts.kantumruyPro(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor.withOpacity(0.5),
                          ),
                        ),
                        Text(
                          '567',
                          style: GoogleFonts.kantumruyPro(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // pay button
            const SizedBox(height: 120.0),
            GestureDetector(
              onTap: () {
                _productController.paymentProduct();
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Text(
                  'Pay \$${_productController.allTotalPriceUSA().toString()}',
                  style: GoogleFonts.kantumruyPro(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}