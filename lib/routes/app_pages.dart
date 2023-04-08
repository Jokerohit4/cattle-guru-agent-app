import 'package:cattle_guru_agent_app/screens/Auth/OTP_screen.dart';
import 'package:cattle_guru_agent_app/screens/Auth/phone_screen.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.PHONE;

  static final routes = [
    GetPage(
      name: Paths.PHONE,
      page: () => const PhoneScreen(),
    ),
    GetPage(name: Paths.OTP, page: () => OTPScreen()),
   ];
}