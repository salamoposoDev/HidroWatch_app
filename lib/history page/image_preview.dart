import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:photo_view/photo_view.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({super.key, required this.imageUrl, required this.time});
  final String imageUrl;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          time,
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
      ),
      body: Center(
        child: Hero(
            tag: imageUrl,
            child: PhotoView(
              imageProvider: NetworkImage(imageUrl),
            )),
      ),
    );
  }
}
