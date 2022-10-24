import 'package:flutter/material.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({Key? key}) : super(key: key);

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          color: Colors.grey,
          height: height * 0.1,
          width: height * 0.1,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }
}
