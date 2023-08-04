import 'package:get/get.dart';

import '../../../../common/ui.dart';
import '../../../models/appointment_model.dart';
import '../../../models/payment_model.dart';
import '../../../models/wallet_model.dart';
import '../../../repositories/payment_repository.dart';
import '../../appointments/controllers/appointments_controller.dart';
import '../../global_widgets/tab_bar_widget.dart';

class WalletController extends GetxController {
  late PaymentRepository _paymentRepository;
  Rx<Payment?> payment = new Payment().obs;
  final appointment = new Appointment().obs;
  final wallet = new Wallet().obs;

  WalletController() {
    _paymentRepository = new PaymentRepository();
  }

  @override
  void onInit() {
    appointment.value = Get.arguments['appointment'] as Appointment;
    wallet.value = Get.arguments['wallet'] as Wallet;
    payAppointment();
    super.onInit();
  }

  Future payAppointment() async {
    try {
      payment.value = await _paymentRepository.createWalletPayment(
        Appointment(id: appointment.value.id, payment: appointment.value.payment),
        wallet.value,
      );
      if (payment.value?.hasData ?? false) {
        refreshAppointments();
      }
    } catch (e) {
      Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  bool isLoading() {
    if (!(payment.value?.hasData ?? false)) {
      return true;
    }
    return false;
  }

  bool isDone() {
    if (payment.value?.hasData ?? false) {
      return true;
    }
    return false;
  }

  bool isFailed() {
    if (payment.value == null) {
      return true;
    }
    return false;
  }

  void refreshAppointments() {
    Get.find<AppointmentsController>().currentStatus.value = Get.find<AppointmentsController>().getStatusByOrder(50).id ?? '';
    if (Get.isRegistered<TabBarController>(tag: 'appointments')) {
      Get.find<TabBarController>(tag: 'appointments').selectedId.value = Get.find<AppointmentsController>().getStatusByOrder(50).id ?? '';
    }
/*    Get.toNamed(Routes.CONFIRMATION, arguments: {
      'title': "Payment Confirmation".tr,
      'long_message': "Your payment is pending confirmation from the Doctor".tr,
    });*/
  }
}
