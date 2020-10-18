import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:videoPlayer/constants/themes.dart';
import 'package:videoPlayer/screens/authenticate/user.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

final width = 360;
final height = 772;

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ratio = size.width / width;
    Widget rmContainers({width, heightt}) {
      return Container(
        height: size.height * (heightt / height),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 6,
          itemBuilder: (context, i) {
            return Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                height: heightt,
                width: width,
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(color: ThemeConstants.BGCOLOR_DARK),
        child: Column(
          children: [
            SizedBox(
              height: size.height * (120 / height),
            ),
            Container(
              height: size.height * (137 / height),
              width: size.width,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 9),
                    child: Container(
                      height: size.height * (134 / height),
                      width: size.width * (135 / width),
                      child: Provider.of<UserManage>(context, listen: false)
                                  .user
                                  .image !=
                              ''
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              child: Image.network(
                                Provider.of<UserManage>(context, listen: false)
                                    .user
                                    .image,
                                fit: BoxFit.contain,
                              ),
                            )
                          : ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100)),
                              child: Image.asset(
                                'assets/images/omkar.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                    ),
                  ),
                  Container(
                    height: size.height * (134 / height),
                    width: size.width * 0.94 - size.width * (135 / width),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: size.width * (120 / width),
                          height: size.width * (80 / height),
                          child: Text(
                            Provider.of<UserManage>(context, listen: false)
                                .user
                                .name,
                            style: TextStyle(
                                fontSize: 17 * ratio,
                                fontFamily: "PS",
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  "Uploads",
                                  style: TextStyle(
                                      fontSize: 13 * ratio,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(width: size.width * (20 / width)),
                              Container(
                                child: Text(
                                  "Downloads",
                                  style: TextStyle(
                                      fontSize: 13 * ratio,
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: size.height * (200 / height),
            ),
            Container(
              height: size.height * (50 / height),
              child: Text(
                "Uploads",
                style: TextStyle(
                    fontFamily: "PS",
                    fontSize: 20 * ratio,
                    color: Colors.white),
              ),
            ),
            rmContainers(
                width: size.width * (137 / width),
                heightt: size.height * (127 / height))
          ],
        ),
      ),
    );
  }
}
