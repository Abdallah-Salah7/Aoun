import 'package:aoun/core/routes_manager/routes.dart';
import 'package:aoun/feature/presentation/screens/charity_system/charity_reports.dart';
import 'package:aoun/feature/presentation/screens/charity_system/chatbot/ask_screen.dart';
import 'package:aoun/feature/presentation/screens/charity_system/chatbot/welcome_screen.dart';
import 'package:aoun/feature/presentation/screens/donor_system/charity/login_screen.dart';
import 'package:aoun/feature/presentation/screens/donor_system/charity/register_screen.dart';
import 'package:aoun/feature/presentation/screens/donor_system/donor/forget_password.dart';
import 'package:aoun/feature/presentation/screens/donor_system/donor/login_screen.dart';
import 'package:aoun/feature/presentation/screens/donor_system/donor/register_screen.dart';
import 'package:aoun/feature/presentation/screens/donor_system/fataws_on_zakat.dart';
import 'package:aoun/feature/presentation/screens/donor_system/onboard_screens/onboard_screen1.dart';
import 'package:aoun/feature/presentation/screens/donor_system/onboard_screens/onboard_screen2.dart';
import 'package:aoun/feature/presentation/screens/donor_system/onboard_screens/onboard_screen3.dart';
import 'package:aoun/feature/presentation/screens/donor_system/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../feature/domain/entities/campaign_entity.dart';
import '../../feature/domain/entities/case_entity.dart';
import '../../feature/presentation/screens/charity_system/add_campaign.dart';
import '../../feature/presentation/screens/charity_system/add_case.dart';
import '../../feature/presentation/screens/charity_system/campaign_management.dart';
import '../../feature/presentation/screens/charity_system/case_management.dart';
import '../../feature/presentation/screens/charity_system/charity_campaign_details.dart';
import '../../feature/presentation/screens/charity_system/charity_case_details.dart';
import '../../feature/presentation/screens/charity_system/edit_campaign.dart';
import '../../feature/presentation/screens/charity_system/edit_case.dart';
import '../../feature/presentation/screens/charity_system/home_charity.dart';
import '../../feature/presentation/screens/donor_system/Search_screen.dart';
import '../../feature/presentation/screens/donor_system/calc_zakat.dart';
import '../../feature/presentation/screens/donor_system/campaign_details.dart';
import '../../feature/presentation/screens/donor_system/charity/account_state.dart';
import '../../feature/presentation/screens/donor_system/charity/charity_data.dart';
import '../../feature/presentation/screens/donor_system/charity/charity_files.dart';
import '../../feature/presentation/screens/donor_system/case_details_screen.dart';
import '../../feature/presentation/screens/donor_system/donor/change_password.dart';
import '../../feature/presentation/screens/donor_system/donor/email_verfication.dart';
import '../../feature/presentation/screens/donor_system/charity_profile_screen.dart';
import '../../feature/presentation/screens/donor_system/credit_details.dart';
import '../../feature/presentation/screens/donor_system/current_campaigns_screen.dart';
import '../../feature/presentation/screens/donor_system/customer_service.dart';
import '../../feature/presentation/screens/donor_system/donation_field_screen.dart';
import '../../feature/presentation/screens/donor_system/donation_record.dart';
import '../../feature/presentation/screens/donor_system/edit_email.dart';
import '../../feature/presentation/screens/donor_system/edit_password.dart';
import '../../feature/presentation/screens/donor_system/home_page.dart';
import '../../feature/presentation/screens/donor_system/login_choice_screen.dart';
import '../../feature/presentation/screens/donor_system/notification_screen.dart';
import '../../feature/presentation/screens/donor_system/payment_screen.dart';
import '../../feature/presentation/screens/donor_system/personal_information.dart';
import '../../feature/presentation/screens/donor_system/privacy_and_security.dart';
import '../../feature/presentation/screens/donor_system/saved_cases.dart';
import '../../feature/presentation/screens/donor_system/settings.dart';
import '../../feature/presentation/screens/donor_system/user_type_screen.dart';
import '../../feature/presentation/screens/donor_system/zakat_gold.dart';
import '../../feature/presentation/screens/donor_system/zakat_money.dart';
import '../../feature/presentation/screens/donor_system/zakat_sliver.dart';
import '../../feature/presentation/screens/tabs/donation_tab.dart';
import '../../feature/presentation/screens/tabs/profile_tab.dart';
import '../../feature/presentation/screens/tabs/zakat_tab.dart';
import '../../feature/presentation/screens/widget/charity_campaign_item.dart';
import '../../feature/presentation/state_management/cubit/campaign_cubit.dart';
import '../../feature/presentation/state_management/cubit/case_cubit.dart';
import '../resources/assets_manager.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    final argument = settings.arguments;

    switch (settings.name) {
      /// HOME
      case Routes.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case Routes.donationTab:
        return MaterialPageRoute(builder: (_) => const DonationTab());

      case Routes.zakatTab:
        return MaterialPageRoute(builder: (_) => const ZakatTab());

      case Routes.profileTab:
        return MaterialPageRoute(builder: (_) => const ProfileTab());

      case Routes.searchScreen:
        return MaterialPageRoute(builder: (_) => SearchScreen());

      case Routes.notificationScreen:
        return MaterialPageRoute(builder: (_) => const NotificationScreen());

      /// CAMPAIGNS
      case Routes.currentCampaignsScreen:
        final fieldName = argument as String;
        return MaterialPageRoute(
          builder: (_) => CurrentCampaignsScreen(fieldName: fieldName),
        );

      case Routes.caseDetailsScreen:
        final args = argument as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => CaseDetailsScreen(args: args));

      case Routes.donationFieldScreen:
        final fieldName = argument as String;
        return MaterialPageRoute(
          builder: (_) => DonationFieldScreen(fieldName: fieldName),
        );

      case Routes.campaignDetails:
        final args = argument as Map<String, dynamic>;
        return MaterialPageRoute(builder: (_) => CampaignDetails(args: args));

      case Routes.paymentScreen:
        return MaterialPageRoute(builder: (_) => const PaymentScreen());

      /// CHARITY
      case Routes.charityProfileScreen:
        return MaterialPageRoute(builder: (_) => const CharityProfileScreen());

      case Routes.charityDataScreen:
        return MaterialPageRoute(builder: (_) => const CharityData());

      case Routes.charityFilesScreen:
        return MaterialPageRoute(builder: (_) => const CharityFiles());

      case Routes.accountStateScreen:
        return MaterialPageRoute(builder: (_) => const AccountState());
      case Routes.homeCharity:
        return MaterialPageRoute(builder: (_) => const HomeCharity());
      case Routes.charityCaseDetails:
        final caseData = argument as CaseEntity;

        return MaterialPageRoute(
          builder: (_) => CharityCaseDetails(caseData: caseData),
        );
      case Routes.addCase:
        return MaterialPageRoute(builder: (_) => const AddCase());
      case Routes.editCase:
        final caseItem = argument as CaseEntity;

        return MaterialPageRoute(
          builder: (_) => EditCase(caseEntity: caseItem),
        );
      case Routes.campaignManagement:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CampaignCubit(),
            child: const CampaignManagement(),
          ),
        );
      case Routes.addCampaign:
        return MaterialPageRoute(builder: (_) => const AddCampaign());
      case Routes.editCampaign:
        return MaterialPageRoute(builder: (_) => const EditCampaign());
      case Routes.charityCampaignDetails:
        final campaignData = argument as CampaignEntity;
        return MaterialPageRoute(
          builder: (_) =>  CharityCampaignDetails(campaignData:campaignData),
        );
      case Routes.charityReportsScreen:
        return MaterialPageRoute(builder: (_) => const CharityReports());
      case Routes.chatbotWelcomeScreen:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case Routes.chatbotAskScreen:
      final question=argument as String;
        return MaterialPageRoute(builder: (_) =>  AskScreen(question: question,));
      /// SETTINGS
      case Routes.settings:
        return MaterialPageRoute(builder: (_) => const Settings());

      case Routes.savedCases:
        return MaterialPageRoute(builder: (_) => const SavedCases());

      case Routes.privacyAndSecurity:
        return MaterialPageRoute(builder: (_) => const PrivacyAndSecurity());

      case Routes.customerService:
        return MaterialPageRoute(builder: (_) => const CustomerService());

      case Routes.donationRecord:
        return MaterialPageRoute(builder: (_) => const DonationRecord());
      case Routes.editEmail:
        return MaterialPageRoute(builder: (_) => const EditEmail());
      case Routes.editPassword:
        return MaterialPageRoute(builder: (_) => const EditPassword());
      case Routes.personalInformation:
        return MaterialPageRoute(builder: (_) => const PersonalInformation());
      case Routes.creditDetailsScreen:
        return MaterialPageRoute(builder: (_) => const CreditDetails());
      case Routes.calcZakat:
        return MaterialPageRoute(builder: (_) => const CalcZakat());
      case Routes.zakatGold:
        return MaterialPageRoute(builder: (_) => const ZakatGold());
      case Routes.zakatSliver:
        return MaterialPageRoute(builder: (_) => const ZakatSliver());
      case Routes.zakatMoney:
        return MaterialPageRoute(builder: (_) => const ZakatMoney());
      case Routes.caseManagement:
        return MaterialPageRoute(builder: (_) => const CaseManagement());

      /// AUTH
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

      case Routes.emailVerficationScreen:
        return MaterialPageRoute(
          builder: (_) => EmailVerfication(email: argument as String),
        );

      case Routes.changePasswordScreen:
        return MaterialPageRoute(builder: (_) => const ChangePassword());

      /// ONBOARDING
      case Routes.onBoard1:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen1());

      case Routes.onBoard2:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen2());

      case Routes.onBoard3:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen3());

      /// SPLASH
      case Routes.splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      /// Services
      case Routes.fatwasOnZakatScreen:
        return MaterialPageRoute(builder: (_) => const FatawsOnZakat());

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
