import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
class TextTabScreen extends StatelessWidget {
  final VoidCallback onShare;

  const TextTabScreen({super.key, required this.onShare});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "\"I'm reading a book about anti-gravity. It's impossible to put down.\"",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue[800]),
              textAlign: TextAlign.center,
            ),
            Text(
              "- Steven Wright",
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () async {
                String textToShare = "\"I'm reading a book about anti-gravity. It's impossible to put down.\" - Steven Wright";
                String link = 'https://linktab-3f36d.web.app';
                await Share.share('Check out this text: $textToShare $link');
                onShare(); 
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
