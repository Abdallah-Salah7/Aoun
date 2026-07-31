import 'package:url_launcher/url_launcher.dart';

Future<void> openWebsite() async {
  final Uri url = Uri.parse('http://www.dar-alifta.org');

  await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  );
}