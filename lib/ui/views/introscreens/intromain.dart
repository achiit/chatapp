import 'package:chatapp/constants/colors.dart';
import 'package:chatapp/constants/size.dart';
import 'package:chatapp/ui/views/auth%20screens/otp_screen.dart';
import 'package:chatapp/ui/views/auth%20screens/registration.dart';
import 'package:chatapp/ui/views/introscreens/intro1.dart';
import 'package:chatapp/ui/views/introscreens/intro2.dart';
import 'package:chatapp/ui/views/introscreens/intro3.dart';
import 'package:chatapp/ui/widgets/custombutton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final _controller = PageController();
  final pages = [
    OnboardingOne(),
    OnboardingTwo(),
    OnboardingThree(),
  ];

  int currentIndex = 0;
  AnimationController? _animationController;
  Animation<double>? _animation;
  bool showButton = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!);
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: PageView.builder(
              controller: _controller,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return pages[index];
              },
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                  if (currentIndex == 2) {
                    _animationController?.forward();
                    showButton = false;
                  } else {
                    _animationController?.reverse();
                    showButton = true;
                  }
                });
              },
            ),
          ),
          if (currentIndex <= 1)
            Container(
              width: double.infinity, // Occupy full available width
              height: double.infinity,
              alignment: Alignment(0, 0.55),
              child: SmoothPageIndicator(
                controller: _controller,
                count: pages.length,
                effect: SlideEffect(
                  dotColor: AppColors.textcolor,
                  activeDotColor: AppColors.buttonColor,
                  dotHeight: SizeConfig.screenHeight(context) * 0.01,
                  dotWidth: SizeConfig.screenWidth(context) * 0.07,
                ),
              ),
            )
          else
            Container(
              alignment: Alignment(0, 0.58),
              child: SmoothPageIndicator(
                controller: _controller,
                count: pages.length,
                effect: SlideEffect(
                  dotColor: AppColors.textcolor,
                  activeDotColor: AppColors.buttonColor,
                  dotHeight: SizeConfig.screenHeight(context) * 0.01,
                  dotWidth: SizeConfig.screenWidth(context) * 0.07,
                ),
              ),
            ),
          AnimatedBuilder(
            animation: _animationController!,
            builder: (context, child) {
              return Positioned(
                bottom: SizeConfig.screenHeight(context) * 0.1,
                right: showButton
                    ? SizeConfig.screenWidth(context) * 0.07
                    : SizeConfig.screenWidth(context) *
                        0.22, // Set different positions based on the condition
                child: Opacity(
                  opacity: showButton ? 1 : _animation!.value,
                  child: Transform.scale(
                    scale: showButton ? 1 : _animation!.value,
                    child: child,
                  ),
                ),
              );
            },
            child: currentIndex != 2
                ? CustomElevatedButton(
                    text: "Get Started!",
                    onPressed: () {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 1),
                        curve: Curves.decelerate,
                      );
                    },
                  )
                : Container(
                    width: SizeConfig.screenWidth(context) * 0.57,
                    height: SizeConfig.screenHeight(context) * 0.08,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          SizeConfig.screenHeight(context) * 0.04),
                    ),
                    child: CustomElevatedButton(
                      text: "Login",
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegistrationScreen()
                                  
                            ),
                            (route) => false);
                      },
                    )),
          ),
        ],
      ),
    );
  }
}
