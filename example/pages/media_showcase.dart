import 'package:flartdart/flartdart.dart';
import '../widgets/showcase_card.dart';

class MediaShowcase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FDColumn(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FDText(
          'Media Widgets',
          style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: FlartColor('#1e293b')),
        ),
        FDSizedBox(height: 8),
        FDText(
          'Widgets for displaying images, videos, and embedded content.',
          style: TextStyle(fontSize: 16, color: FlartColor('#64748b')),
        ),
        FDSizedBox(height: 32),
        ShowcaseCard(
          title: 'FDImage',
          description: 'A widget to display images from a URL.',
          child: FDImage.network(
            'https://images.unsplash.com/photo-1579546929518-9e396f3cc809?w=400&q=80',
            width: 300,
            height: 200,
            fit: BoxFit.cover,
            cssStyle: {'border-radius': '12px'},
          ),
        ),
        ShowcaseCard(
          title: 'VideoPlayer',
          description: 'A native HTML5 video player.',
          child: VideoPlayer(
            src: 'https://www.w3schools.com/html/mov_bbb.mp4',
            width: 300,
            controls: true,
          ),
        ),
        ShowcaseCard(
          title: 'YouTubePlayer',
          description: 'Embed a YouTube video directly.',
          child: YouTubePlayer(
            videoId: 'dQw4w9WgXcQ',
            width: 400,
            height: 225,
            controls: true,
          ),
        ),
      ],
    );
  }
}
