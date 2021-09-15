import 'package:flutter/material.dart';
import 'package:gift_of_the_nile/screens/home_screen.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    slides = [];
    slides.add(
      Slide(
        title: "Egyptian History",
        styleTitle: TextStyle(
            color: Color(0xffD02090),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'),
        description:
            "Ye indulgence unreserved connection alteration appearance",
        styleDescription: TextStyle(
          color: Color(0xffD02090),
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
        ),
        pathImage: "resources/images/king_tut.png",
        colorBegin: Color(0xffFFFACD),
        colorEnd: Colors.amber,
        directionColorBegin: Alignment.topRight,
        directionColorEnd: Alignment.bottomLeft,
      ),
    );
  }

  void onDonePress() {
    // Do what you want
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.white,
      size: 35.0,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Colors.white,
    );
  }

  Widget renderSkipBtn() {
    return Icon(
      Icons.skip_next,
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      // List slides
      slides: [
        Slide(
          title: "Ancient Egyptian History",
          styleTitle: TextStyle(
            color: Colors.black,
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
          ),
          description:
              "Gives you the opportunity to know more about the ancient egyptian history. Pharaohs, Gods and their ancient monuments with lots of videos and pictures",
          styleDescription: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.normal,
          ),
          pathImage: "resources/images/king_tut.png",
          colorBegin: Color(0xffFFFACD),
          colorEnd: Colors.amber,
          directionColorBegin: Alignment.topRight,
          directionColorEnd: Alignment.bottomLeft,
        ),
        Slide(
          title: "Locate Your Favorite Character",
          styleTitle: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
          description:
              "You can locate where the pharaoh appeared in and his/her monuments and also you can order Uber or any Cap App to the monument location directly",
          styleDescription: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
          ),
          pathImage: "resources/images/king_tut.png",
          colorBegin: Color(0xffFFFACD),
          colorEnd: Color(0xffFF6347),
          directionColorBegin: Alignment.topRight,
          directionColorEnd: Alignment.bottomLeft,
        ),
        Slide(
          title: "Read More Know More",
          styleTitle: TextStyle(
              color: Color(0xffD02090),
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono'),
          description:
              "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
          styleDescription: TextStyle(
            color: Color(0xffD02090),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
          ),
          pathImage: "resources/images/king_tut.png",
          colorBegin: Color(0xffFFA500),
          colorEnd: Color(0xff7FFFD4),
          directionColorBegin: Alignment.topCenter,
          directionColorEnd: Alignment.bottomCenter,
          maxLineTextDescription: 3,
        ),
      ],

      // Skip button
      renderSkipBtn: this.renderSkipBtn(),

      // Next button
      renderNextBtn: this.renderNextBtn(),

      // Done button
      renderDoneBtn: this.renderDoneBtn(),
      onDonePress: this.onDonePress,

      doneButtonStyle: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0x33000000)),
      ),
      // Dot indicator
      colorDot: Color(0x33D02090),
      colorActiveDot: Color(0xffD02090),
      sizeDot: 13.0,

      // Show or hide status bar
      hideStatusBar: true,
      backgroundColorAllSlides: Colors.grey,
    );
  }
}
