import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey _introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd() {
    Navigator.pushNamed(context, 'login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false),
      body: IntroductionScreen(
        key: _introKey,
        isProgressTap: true,
        pages: <PageViewModel>[
          _pageView(
            1,
            'Welcome to Urban Hunt',
            'From Nairobi apartments to coastal villas, browse home listings in every corner of the country.',
          ),
          _pageView(
            2,
            'Buy or Rent with Ease',
            'Find your perfect space or make your next big move, secure, and right from your phone.',
          ),
          _pageView(
            3,
            'Trusted Agents',
            'We ensure all listings are verified to provide you the support you need to make confident property decisions.',
          ),
        ],
        showSkipButton: true,
        onDone: _onIntroEnd,
        onSkip: _onIntroEnd,
        skip: Text('Skip', style: Theme.of(context).textTheme.bodyMedium),
        next: Text('Next', style: Theme.of(context).textTheme.bodyMedium),
        done: Text('Done', style: Theme.of(context).textTheme.bodyMedium),
        dotsDecorator: DotsDecorator(
          size: const Size.square(12.0),
          activeSize: const Size(28.0, 12.0),
          activeColor: Theme.of(context).primaryColor,
          color: Theme.of(context).disabledColor,
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }

  PageViewModel _pageView(int index, String title, String body) {
    return PageViewModel(
      titleWidget: Text(
        title,
        style: Theme.of(context).textTheme.displayMedium,
      ),
      bodyWidget: Column(
        children: <Widget>[
          const SizedBox(height: 24.0),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              image: DecorationImage(
                image: AssetImage('assets/images/splash_$index.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 60.0),
          Text(
            body,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
