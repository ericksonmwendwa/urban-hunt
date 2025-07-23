import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileLink extends StatelessWidget {
  const ProfileLink({
    super.key,
    this.outlink = false,
    required this.link,
    required this.label,
    required this.icon,
  });

  final bool outlink;
  final String link;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (outlink) {
          Uri url = Uri.parse('https://www.urbanhunt.com/$link');

          _launchUrl(url);

          return;
        }

        Navigator.pushNamed(context, '/$link');
      },
      child: Container(
        color: Theme.of(context).colorScheme.surface,
        child: Row(
          children: <Widget>[
            Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: Theme.of(context).disabledColor.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Center(child: Icon(icon, size: 21.0)),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontSize: 17.0),
              ),
            ),
            Icon(
              outlink
                  ? Icons.north_east_rounded
                  : Icons.arrow_forward_ios_rounded,
              size: 21.0,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
