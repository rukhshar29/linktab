import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
class ImageTabScreen extends StatelessWidget {
  final VoidCallback onShare;

  const ImageTabScreen({super.key, required this.onShare});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.width * 0.5,
              width: MediaQuery.of(context).size.width * 0.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  'assets/moonsign.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                String link = 'https://linktab-3f36d.web.app';

                final directory = await getTemporaryDirectory();
                final file = File('${directory.path}/moonsign.png');
                final bytes = await rootBundle.load('assets/moonsign.jpg');
                await file.writeAsBytes(bytes.buffer.asUint8List());
                await Share.shareXFiles([XFile(file.path)], text: 'Check out this image: $link');
                onShare(); // Call this to switch back to the Image tab
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.share, color: Colors.white),
                  SizedBox(width: 10),
                  Text('Share', style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
