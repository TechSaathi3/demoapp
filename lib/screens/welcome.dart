import 'package:flutter/material.dart';
import 'package:taxi/authentication/login_screen.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  late PageController _pageController;
  int _pageIndex = 0;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: demoData.length,
                onPageChanged: (index) {
                  setState(() {
                    _pageIndex = index;
                    isLastPage = index == demoData.length - 1;
                  });
                },
                itemBuilder: (context, index) => OnboardContent(
                  image: demoData[index].image,
                  title: demoData[index].title,
                  description: demoData[index].description,
                ),
              ),
            ),
            Row(
              children: [
                ...List.generate(
                  demoData.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(right: 4),
                    child: DotIndicator(isActive: index == _pageIndex),
                  ),
                ),
                Spacer(),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      if (isLastPage) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (c) => LoginScreen()),
                        );
                      } else {
                        _pageController.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                    ),
                    child: isLastPage ? Icon(Icons.check) : Icon(Icons.arrow_right_alt_rounded),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    Key? key,
    this.isActive = false,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: isActive ? 12 : 4,
      width: 12,
      decoration: BoxDecoration(
        color: isActive ? Colors.grey : Colors.grey.withOpacity(0.4),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      duration: Duration(milliseconds: 300),
    );
  }
}

class Onboard {
  final String image, title, description;
  Onboard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<Onboard> demoData = [
  Onboard(
    image: 'images/Rectangle 1.png',
    title: 'No Surge Pricing',
    description: 'Ensuring clear and equitable fares for all rides, promoting transparency and trust in our pricing system.',
  ),
  Onboard(
    image: 'images/Rectangle 1 (1).png',
    title: 'Easy availability',
    description: 'Dependable and swift four-vehicle services available ensuring efficient and timely transportation.',
  ),
  Onboard(
    image: 'images/Rectangle 1 (2).png',
    title: 'Drive more, earn more',
    description: 'Embark on longer journeys, maximize your earnings. Drive more, earn more with our rewarding and expansive opportunities in the world of transportation.',
  ),
];

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Image.asset(image),
        Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 16),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
        Spacer(),
      ],
    );
  }
}
