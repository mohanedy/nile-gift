import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'About',
          style: TextStyle(
            color: Colors.amber,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.amber,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'resources/images/nilegiftIcon.png',
                  width: 120,
                ),
                Flexible(
                  child: Text(
                      'Nile gift is a vertical timeline that allows you to navigate through ancient Egyptian characters (deity, pharaohs), learn more about them, their stories, images, and videos with fully animated and illustrated characters and also provide the ability to locate characters monuments and order uber to the monument directly'),
                ),
              ],
            ),
          ),
          RawMaterialButton(
            onPressed: () {
              launchURL('https://hyper-dev.github.io/');
            },
            child: Image.asset(
              'resources/images/logo-gray-wide.png',
              height: 80,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DeveloperCard(
              'resources/images/me.png',
              'Mohaned Yossry Al-Feqy',
              'Android & iOS Mobile Developer',
              email: 'mohaned.y98@gmail.com',
              github: 'https://github.com/Mohanedy98',
              facebook: 'https://www.facebook.com/mohanedy98',
              twitter: 'https://twitter.com/mohanedy98',
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class DeveloperCard extends StatelessWidget {
  final String imgURL;
  final String name;
  final String about;
  final String email;
  final String github;
  final String facebook;
  final String twitter;
  final Color color1;
  final Color color2;

  DeveloperCard(this.imgURL, this.name, this.about,
      {this.color1 = Colors.blue,
      this.color2 = Colors.lightBlueAccent,
      this.email,
      this.github,
      this.facebook,
      this.twitter});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(5, 0, 5, 30.0),
          padding: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                new BoxShadow(
                  color: color2,
                  blurRadius: 10.0,
                  offset: new Offset(0.0, 10.0),
                ),
                new BoxShadow(
                  color: color2,
                  blurRadius: 10.0,
                  offset: new Offset(5.0, 0),
                ),
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    color1,
                    color2,
                  ])),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Material(
                  elevation: 10,
                  borderRadius: BorderRadius.circular(40),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(imgURL),
                    radius: 35,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      about,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 6,
          right: 20,
          child: social(),
        ),
      ],
    );
  }

  Widget social() {
    return Material(
      borderRadius: BorderRadius.circular(50),
      color: Color(0xffF2F2F2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (email != null)
            IconButton(
              icon: Icon(
                Icons.email,
                color: color1,
                size: 32,
              ),
              onPressed: () {
                launch('mailto:$email?subject=Educate Me App');
              },
            ),
          if (github != null)
            IconButton(
              icon: Icon(
                FontAwesome.github,
                color: color1,
                size: 32,
              ),
              onPressed: () {
                launchURL(github);
              },
            ),
          if (facebook != null)
            IconButton(
              icon: Icon(
                Entypo.facebook_with_circle,
                color: color1,
                size: 32,
              ),
              onPressed: () {
                launchURL(facebook);
              },
            ),
          if (twitter != null)
            IconButton(
              icon: Icon(
                Entypo.twitter_with_circle,
                color: color1,
                size: 32,
              ),
              onPressed: () {
                launchURL(twitter);
              },
            ),
        ],
      ),
    );
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
