import 'package:fresh2_arrive/screens/SearchScreenData..dart';
import 'package:fresh2_arrive/screens/add_money.dart';
import 'package:fresh2_arrive/screens/custum_bottom_bar.dart';
import 'package:fresh2_arrive/screens/coupons_screen.dart';
import 'package:fresh2_arrive/screens/driver_screen/assigned_order.dart';
import 'package:fresh2_arrive/screens/driver_screen/delivered_successfully.dart';
import 'package:fresh2_arrive/screens/driver_screen/delivery_dashboard.dart';
import 'package:fresh2_arrive/screens/driver_screen/driver_banking_details.dart';
import 'package:fresh2_arrive/screens/driver_screen/driver_information_screen.dart';
import 'package:fresh2_arrive/screens/driver_screen/driver_registration.dart';
import 'package:fresh2_arrive/screens/driver_screen/order_decline_screen.dart';
import 'package:fresh2_arrive/screens/driver_screen/verify_delivery_otp_screen.dart';
import 'package:fresh2_arrive/screens/driver_screen/withdraw_moeny.dart';
import 'package:fresh2_arrive/screens/edit_profile.dart';
import 'package:fresh2_arrive/screens/help_center.dart';
import 'package:fresh2_arrive/screens/homepage.dart';
import 'package:fresh2_arrive/screens/loginScreen.dart';
import 'package:fresh2_arrive/screens/my_address.dart';
import 'package:fresh2_arrive/screens/order/choose_address.dart';
import 'package:fresh2_arrive/screens/order/myorder_screen.dart';
import 'package:fresh2_arrive/screens/order/orderDetails.dart';
import 'package:fresh2_arrive/screens/otpscreen.dart';
import 'package:fresh2_arrive/screens/privacy_policy.dart';
import 'package:fresh2_arrive/screens/single_store.dart';
import 'package:fresh2_arrive/screens/splash_screen.dart';
import 'package:fresh2_arrive/screens/thankyou_screen.dart';
import 'package:fresh2_arrive/screens/vendor_screen/bank_details.dart';
import 'package:fresh2_arrive/screens/vendor_screen/delivery_details.dart';
import 'package:fresh2_arrive/screens/vendor_screen/edit_product.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vender_dashboard.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vender_orderList.dart';
import 'package:fresh2_arrive/screens/vendor_screen/vendor_information_screen.dart';
import 'package:fresh2_arrive/screens/vendor_screen/withdraw_money.dart';
import 'package:get/get.dart';
import '../screens/driver_screen/driver_delivery_details.dart';
import '../screens/my_cart_screen.dart';
import '../screens/notification_screen.dart';
import '../screens/onboardingScreen.dart';
import '../screens/payment_method.dart';
import '../screens/refer_and_earn.dart';
import '../screens/vendor_screen/Add_vendor_product.dart';
import '../screens/vendor_screen/store_open_time_screen.dart';
import '../screens/vendor_screen/thank_you.dart';
import '../screens/vendor_screen/vendor_products.dart';
import '../screens/vendor_screen/vendor_registration.dart';
import '../screens/wallet_screen.dart';

class MyRouter {
  static var splashScreen = "/splashScreen";
  static var route = [
    GetPage(name: '/', page: () => const SplashScreen()),
    GetPage(
        name: OnBoardingScreen.onBoardingScreen,
        page: () => const OnBoardingScreen()),
    GetPage(name: LoginScreen.loginScreen, page: () => const LoginScreen()),
    GetPage(name: OtpScreen.otpScreen, page: () => const OtpScreen()),
    GetPage(name: HomePage.homePage, page: () => const HomePage()),
    GetPage(name: SearchScreenData.searchScreen, page: () => const SearchScreenData()),
    GetPage(
        name: CustomNavigationBar.customNavigationBar,
        page: () => const CustomNavigationBar()),
    GetPage(
        name: StoreScreen.singleStoreScreen, page: () => const StoreScreen()),
    GetPage(name: MyCartScreen.myCartScreen, page: () => const MyCartScreen()),
    GetPage(
        name: EditProfileScreen.editProfileScreen,
        page: () => const EditProfileScreen()),
    GetPage(
        name: CouponsScreen.couponsScreen, page: () => const CouponsScreen()),
    GetPage(
        name: MyOrderScreen.myOrderScreen, page: () => const MyOrderScreen()),
    GetPage(
        name: OrderDetails.orderDetailsScreen,
        page: () => const OrderDetails()),
    GetPage(name: MyAddress.myAddressScreen, page: () => const MyAddress()),
    GetPage(
        name: NotificationScreen.notificationScreen,
        page: () => const NotificationScreen()),
    GetPage(
        name: ReferAndEarn.referAndEarnScreen,
        page: () => const ReferAndEarn()),
    GetPage(
        name: PaymentMethod.paymentScreen, page: () => const PaymentMethod()),
    GetPage(
        name: ThankYouScreen.thankYouScreen,
        page: () => const ThankYouScreen()),
    GetPage(
        name: WalletScreen.myWalletScreen, page: () => const WalletScreen()),
    GetPage(
        name: AddMoneyScreen.addMoneyScreen,
        page: () => const AddMoneyScreen()),
    GetPage(
        name: PrivacyPolicy.privacyPolicyScreen,
        page: () => const PrivacyPolicy()),
    GetPage(name: HelpCenter.helpCenterScreen, page: () => const HelpCenter()),
    GetPage(
        name: ChooseAddress.chooseAddressScreen,
        page: () => const ChooseAddress()),
    GetPage(
        name: VenderDashboard.vendorDashboard,
        page: () => const VenderDashboard()),
    GetPage(
        name: VendorRegistrationForm.vendorRegistrationForm,
        page: () => const VendorRegistrationForm()),
    GetPage(
        name: ThankYouVendorScreen.thankYouVendorScreen,
        page: () => const ThankYouVendorScreen()),
    GetPage(
        name: VendorProductScreen.vendorProductScreen,
        page: () => const VendorProductScreen()),
    GetPage(
        name: AddVendorProduct.addVendorProduct,
        page: () => const AddVendorProduct()),
    GetPage(
        name: VendorOrderList.vendorOrderList,
        page: () => const VendorOrderList()),
    GetPage(
        name: WithDrawMoney.withDrawMoney, page: () => const WithDrawMoney()),
    GetPage(
        name: DeliveryOrderDetails.deliveryOrderDetails,
        page: () => const DeliveryOrderDetails()),
    GetPage(
        name: SetTimeScreen.setTimeScreen, page: () => const SetTimeScreen()),
    GetPage(
        name: BankDetailsScreen.bankDetailsScreen,
        page: () => const BankDetailsScreen()),
    GetPage(
        name: DriverRegistrationScreen.driverRegistrationScreen,
        page: () => const DriverRegistrationScreen()),
    GetPage(
        name: DeliveryDashboard.deliveryDashboard,
        page: () => const DeliveryDashboard()),
    GetPage(
        name: AssignedOrder.assignedOrder, page: () => const AssignedOrder()),
    GetPage(
        name: DriverDeliveryOrderDetails.driverDeliveryOrderDetails,
        page: () => const DriverDeliveryOrderDetails()),
    GetPage(
        name: DriverBankDetails.driverBankDetails,
        page: () => const DriverBankDetails()),
    GetPage(
        name: DriverWithdrawMoney.driverWithdrawMoney,
        page: () => const DriverWithdrawMoney()),
    GetPage(
        name: VerifyOtpDeliveryScreen.verifyOtpDeliveryScreen,
        page: () => const VerifyOtpDeliveryScreen()),
    GetPage(
        name: DeliveredSuccessfullyScreen.deliveredSuccessfullyScreen,
        page: () => const DeliveredSuccessfullyScreen()),
    GetPage(
        name: VendorInformation.vendorInformation,
        page: () => const VendorInformation()),
    GetPage(
        name: DriverInformation.driverInformation,
        page: () => const DriverInformation()),
    GetPage(
        name: OrderDeclineScreen.orderDeclineScreen,
        page: () => const OrderDeclineScreen()),
    GetPage(
        name: EditProductScreen.editProductScreen,
        page: () => const EditProductScreen()),
  ];
}
