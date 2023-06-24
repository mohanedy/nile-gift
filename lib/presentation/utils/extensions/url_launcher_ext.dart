import 'package:url_launcher/url_launcher_string.dart';

extension UrlLauncherExt on String {
  /// Launches the URL in a browser.
  Future<void> launchUrl() async {
    if (await canLaunchUrlString(this)) {
      await launchUrlString(this, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $this';
    }
  }
}
