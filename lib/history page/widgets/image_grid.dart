import 'dart:async';

import 'package:cctv_iot/history%20page/image_preview.dart';
import 'package:cctv_iot/utils/format_timestamp.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:image_downloader/image_downloader.dart';

class ImageGrid extends StatefulWidget {
  const ImageGrid({super.key, required this.historyList});
  final List<Map<String, dynamic>> historyList;

  @override
  State<ImageGrid> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  bool isLoading = false;

  void _saveNetworkImage(String url, String name) async {
    isLoading = true;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blue[300],
        content: Row(
          children: [
            Text('Donwloading Image...'),
            Gap(10),
            Transform.scale(
              scale: 0.8,
              child: CircularProgressIndicator(
                color: Colors.blue.shade700,
              ),
            ),
          ],
        )));
    // print(isLoading);
    var response = await Dio()
        .get(url, options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 60,
        name: name);
    print(result);
    Future.delayed(Duration(seconds: 2));
    if (result['isSuccess'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blue[300],
        content: Text('Download Success'),
      ));
      isLoading = false;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Donwload Fail'),
        backgroundColor: Colors.red[300],
      ));
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: widget.historyList.length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.historyList.length < 3 ? 2 : 3),
        itemBuilder: (context, index) {
          int timestamp = widget.historyList[index]['time'];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 8),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImagePreview(
                              imageUrl: widget.historyList[index]["image"],
                              time: formatTimestamp(timestamp),
                            )));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: [
                    Image.network(
                      widget.historyList[index]['image'],
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 8.w, top: 4.h),
                            child: Text(
                              formatTimestamp(timestamp).toString(),
                              style: GoogleFonts.poppins(color: Colors.orange),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: InkWell(
                        onTap: () {
                          _saveNetworkImage(widget.historyList[index]['image'],
                              widget.historyList[index]['time'].toString());
                        },
                        child: Icon(
                          Icons.download,
                          color: Colors.orange,
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isLoading == true,
                      child: CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
