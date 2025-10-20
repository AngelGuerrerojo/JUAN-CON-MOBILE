import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class QuejasWidget extends StatelessWidget {
  void _openQuejas() async {
    const url = 'https://youtube.com/shorts/Ay8lynMZ4mE?si=pAy4rZ_oebKzZv_m';
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openQuejas,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://preview.redd.it/biu0i82gewtf1.jpeg?width=640&crop=smart&auto=webp&s=8a128dbd3e126004dc1a499a72460a37e94fb9bf',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 6),
            Text(
              'quejas',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Segoe UI',
              ),
            ),
          ],
        ),
      ),
    );
  }
}