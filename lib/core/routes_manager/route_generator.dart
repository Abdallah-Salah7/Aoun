import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/charity/login_screen.dart';
import 'package:aoun/feature/presentation/screens/charity/register_screen.dart';
import 'package:aoun/feature/presentation/screens/donor/forget_password.dart';
import 'package:aoun/feature/presentation/screens/donor/login_screen.dart';
import 'package:aoun/feature/presentation/screens/donor/register_screen.dart';
import 'package:aoun/feature/presentation/screens/login_choice_screen.dart';
import 'package:aoun/feature/presentation/screens/onboard_screens/onboard_screen1.dart';
import 'package:aoun/feature/presentation/screens/onboard_screens/onboard_screen2.dart';
import 'package:aoun/feature/presentation/screens/onboard_screens/onboard_screen3.dart';
import 'package:aoun/feature/presentation/screens/splash_screen.dart';
import 'package:aoun/feature/presentation/screens/user_type_screen.dart';
import 'package:flutter/material.dart';

import '../../feature/presentation/screens/campaign_details.dart';
import '../../feature/presentation/screens/current_campaigns_screen.dart';
import '../../feature/presentation/screens/Search_screen.dart';
import '../../feature/presentation/screens/case_details_screen.dart';
import '../../feature/presentation/screens/donation_field_screen.dart';
import '../../feature/presentation/screens/home_page.dart';
import '../../feature/presentation/screens/notification_screen.dart';
import '../../feature/presentation/screens/payment_screen.dart';
import '../../feature/presentation/screens/tabs/donation_tab.dart';
import '../../feature/presentation/screens/tabs/profile_tab.dart';
import '../../feature/presentation/screens/tabs/zakat_tab.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    final argument = settings.arguments;
    switch (settings.name) {
      case Routes.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case Routes.donationTab:
        return MaterialPageRoute(builder: (_) => const DonationTab());
      case Routes.zakatTab:
        return MaterialPageRoute(builder: (_) => const ZakatTab());
      case Routes.profileTab:
        return MaterialPageRoute(builder: (_) => const ProfileTab());
      case Routes.searchScreen:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case Routes.notificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());
      case Routes.currentCampaignsScreen:
        return MaterialPageRoute(
          builder: (_) => const CurrentCampaignsScreen(),
        );
      case Routes.caseDetailsScreen:
        return MaterialPageRoute(builder: (_) => const CaseDetailsScreen());
      case Routes.donationFieldScreen:
        return MaterialPageRoute(builder: (_) => const DonationFieldScreen());
      case Routes.campaignDetails:
        return MaterialPageRoute(builder: (_) => const CampaignDetails());
      case Routes.paymentScreen:
        return MaterialPageRoute(builder: (_) => const PaymentScreen());

      case Routes.signIn:
      // return MaterialPageRoute(builder: (_) => const SignInScreen());

      case Routes.onBoard1:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen1());
      case Routes.onBoard2:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen2());
      case Routes.onBoard3:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen3());
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.userTypeScreen:
        return MaterialPageRoute(
          builder: (_) => const GeneralLoginChoicePage(),
        );
      case Routes.loginChoiceScreen:
        return MaterialPageRoute(
          builder: (_) => LoginChoiceScreen(userType: argument as String),
        );
      case Routes.donorLoginScreen:
        return MaterialPageRoute(builder: (_) => const DonorLoginScreen());
      case Routes.donorRegisteScreen:
        return MaterialPageRoute(builder: (_) => const DonorRegisterScreen());
      case Routes.charityLoginScreen:
        return MaterialPageRoute(builder: (_) => const CharityLoginScreen());
      case Routes.charityRegisteScreen:
        return MaterialPageRoute(builder: (_) => const CharityRegisterScreen());
      case Routes.forgetPasswordScreen:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text('No Route Found')),
            body: const Center(child: Text('No Route Found')),
          ),
    );
  }
}
