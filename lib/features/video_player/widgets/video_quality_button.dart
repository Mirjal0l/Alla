import 'dart:ui';

import 'package:flutter/material.dart';

class VideoQualityButton extends StatefulWidget {
  const VideoQualityButton({super.key});

  @override
  State<VideoQualityButton> createState() => _VideoQualityButtonState();
}

class _VideoQualityButtonState extends State<VideoQualityButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: () {
          _showVideoQualityDialog(context);

          // DropdownButton(
          //   items: [
          //     DropdownMenuItem(child: Text('1080p', style: TextStyle(
          //         fontSize: 12,
          //         color: Colors.white,
          //         fontWeight: FontWeight.w500),
          //     )),
          //
          //     DropdownMenuItem(child: Text('720p', style: TextStyle(
          //         fontSize: 12,
          //         color: Colors.white,
          //         fontWeight: FontWeight.w500),
          //     )),
          //
          //     DropdownMenuItem(child: Text('480p', style: TextStyle(
          //         fontSize: 12,
          //         color: Colors.white,
          //         fontWeight: FontWeight.w500),
          //     )),
          //
          //     DropdownMenuItem(child: Text('360p', style: TextStyle(
          //         fontSize: 12,
          //         color: Colors.white,
          //         fontWeight: FontWeight.w500),
          //     )),
          //
          //     DropdownMenuItem(child: Text('240p', style: TextStyle(
          //         fontSize: 12,
          //         color: Colors.white,
          //         fontWeight: FontWeight.w500),
          //     )),
          //
          //     DropdownMenuItem(child: Text('144p', style: TextStyle(
          //         fontSize: 12,
          //         color: Colors.white,
          //         fontWeight: FontWeight.w500),
          //     )),
          //
          //     DropdownMenuItem(child: Text('Auto', style: TextStyle(
          //         fontSize: 12,
          //         color: Colors.white,
          //         fontWeight: FontWeight.w500),
          //     )),
          //   ],
          //   onChanged: (value) {
          //
          //   },
          //
          // );
        },
        icon: Icon(
          Icons.high_quality_outlined,
          size: 24,
          color: Colors.white,
        ),
      ),
    );
  }
}

void _showVideoQualityDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Stack(
          children: [
            Positioned(
              bottom: 16,
              right: 16,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  width: 100,
                  height: MediaQuery.of(context).size.height * 4 / 5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.1),
                  ),

                  child: Center(
                    child: ListView(
                      children: <Widget>[
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(0),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                '1080p',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(0),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                '720p',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(0),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                '480p',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(0),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                '360p',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(0),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                '240p',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(0),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                '144p',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            padding: EdgeInsets.all(0),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Auto',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
  );
}
