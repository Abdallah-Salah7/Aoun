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
import '../../feature/presentation/screens/charity/account_state.dart';
import '../../feature/presentation/screens/charity/charity_data.dart';
import '../../feature/presentation/screens/charity/charity_files.dart';
import '../../feature/presentation/screens/charity_profile_screen.dart';
import '../../feature/presentation/screens/current_campaigns_screen.dart';
import '../../feature/presentation/screens/Search_screen.dart';
import '../../feature/presentation/screens/case_details_screen.dart';
import '../../feature/presentation/screens/customer_service.dart';
import '../../feature/presentation/screens/donation_field_screen.dart';
import '../../feature/presentation/screens/donation_record.dart';
import '../../feature/presentation/screens/donor/change_password.dart';
import '../../feature/presentation/screens/donor/email_verfication.dart';
import '../../feature/presentation/screens/home_page.dart';
import '../../feature/presentation/screens/notification_screen.dart';
import '../../feature/presentation/screens/payment_screen.dart';
import '../../feature/presentation/screens/privacy_and_security.dart';
import '../../feature/presentation/screens/saved_cases.dart';
import '../../feature/presentation/screens/settings.dart';
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
        final fieldName = settings.arguments as String;

        return MaterialPageRoute(
          builder: (_) => CurrentCampaignsScreen(fieldName: fieldName),
        );

      case Routes.caseDetailsScreen:
        final args = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(builder: (_) => CaseDetailsScreen(args: args));
      case Routes.donationFieldScreen:
        final fieldName = settings.arguments as String;

        return MaterialPageRoute(
          builder: (_) => DonationFieldScreen(fieldName: fieldName),
        );
      case Routes.campaignDetails:
        final args = settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(builder: (_) => CampaignDetails(args: args));
      case Routes.paymentScreen:
        return MaterialPageRoute(builder: (_) => const PaymentScreen());
      case Routes.charityProfileScreen:
        return MaterialPageRoute(builder: (_) => const CharityProfileScreen());

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
      case Routes.donationRecord:
        return MaterialPageRoute(builder: (_) => const DonationRecord());
      case Routes.privacyAndSecurity:
        return MaterialPageRoute(builder: (_) => const PrivacyAndSecurity());
      case Routes.settings:
        return MaterialPageRoute(builder: (_) => const Settings());
      case Routes.savedCases:
        return MaterialPageRoute(builder: (_) => const SavedCases());
      case Routes.customerService:
        return MaterialPageRoute(builder: (_) => const CustomerService());
      case Routes.emailVerficationScreen:
        return MaterialPageRoute(
          builder: (_) => EmailVerfication(email: argument as String),
        );
      case Routes.changePasswordScreen:
        return MaterialPageRoute(builder: (_) => const ChangePassword());
      case Routes.charityDataScreen:
        return MaterialPageRoute(builder: (_) => const CharityData());
      case Routes.charityFilesScreen:
        return MaterialPageRoute(builder: (_) => const CharityFiles());
      case Routes.accountStateScreen:
        return MaterialPageRoute(builder: (_) => const AccountState());
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
