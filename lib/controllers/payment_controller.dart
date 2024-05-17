import 'package:fake_store/models/payment_model.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  // payment list
  List<PaymentModel> paymentList = paymentData;

  // @override
  // void onInit() {
  //   super.onInit();
  //   // Select the first payment method by default
  //   if (paymentList.isNotEmpty) {
  //     paymentList[0].isSelected = true;
  //   }
  // }

  // select payment
  void selectPaymentMethod(int index) {
    // Unselect all payment methods
    for (var payment in paymentList) {
      payment.isSelected = false;
    }
    
    // Select the chosen payment method
    paymentList[index].isSelected = true;

    // Update the UI
    update();
  }

  // Get the selected payment method
  PaymentModel? getSelectedPayment() {
    return paymentList.firstWhereOrNull((payment) => payment.isSelected);
  }
}
