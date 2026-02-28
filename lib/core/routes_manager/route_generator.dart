import 'package:aoun/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';

import '../../feature/presentation/screens/campaign_details.dart';
import '../../feature/presentation/screens/charity_profile_screen.dart';
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
        final args = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(

          builder: (_) => CaseDetailsScreen(args: args),
        );
      case Routes.donationFieldScreen:
        return MaterialPageRoute(builder: (_) => const DonationFieldScreen());
      case Routes.campaignDetails:
        return MaterialPageRoute(builder: (_) => const CampaignDetails());
      case Routes.paymentScreen:
        return MaterialPageRoute(builder: (_) => const PaymentScreen());
      case Routes.charityProfileScreen:

        return MaterialPageRoute(builder: (_) => const CharityProfileScreen());

      case Routes.signIn:
      // return MaterialPageRoute(builder: (_) => const SignInScreen());
      case Routes.onBoard:
      // return MaterialPageRoute(builder: (_) => const OnBoardScreen());
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
