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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              elevation: 20,
              borderRadius: BorderRadius.circular(25),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.amber,
                          Colors.amberAccent.shade700,
                        ])),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(40),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                            'resources/images/me.png',
                          ),
                          radius: 40,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Mohaned Yossry Al-feqy',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              IconButton(
                                icon: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                onPressed: () {
                                  launch(
                                      'mailto:mohaned.y98@gmail.com?subject=Nile Gift App');
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  FontAwesome.getIconData('github'),
                                  color: Colors.white,
                                  size: 32,
                                ),
                                onPressed: () {
                                  launchURL(
                                      'https://github.com/Mohanedy98/Gift-of-The-Nile');
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Entypo.getIconData('facebook-with-circle'),
                                  color: Colors.white,
                                  size: 32,
                                ),
                                onPressed: () {
                                  launchURL(
                                      'https://www.facebook.com/mohanedy98');
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Entypo.getIconData('twitter-with-circle'),
                                  color: Colors.white,
                                  size: 32,
                                ),
                                onPressed: () {
                                  launchURL('https://twitter.com/mohanedy98');
                                },
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Image.asset(
                    'resources/images/uni_en.png',
                  ),
                ),
                Flexible(
                  child: Image.asset(
                    'resources/images/fci_en.png',
                  ),
                ),
              ],
            ),
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
