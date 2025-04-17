import 'package:url_launcher/url_launcher.dart';

Future<void> launchTheUrl(String? url) async {
  if (url == null) return;
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}
