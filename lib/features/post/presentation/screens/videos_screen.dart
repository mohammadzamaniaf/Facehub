import 'package:facehub/core/screens/empty_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/core/screens/error_screen.dart';
import '/core/screens/loader.dart';
import '/features/post/presentation/widgets/post_tile.dart';
import '/features/post/providers/get_all_videos_provider.dart';

class VideosScreen extends ConsumerWidget {
  const VideosScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videos = ref.watch(getAllVideosProvider);

    return videos.when(
      data: (Iterable videos) {
        if (videos.isEmpty) {
          return const EmptyScreen(text: 'No video found.');
        }

        return ListView.separated(
          itemCount: videos.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final video = videos.elementAt(index);
            return PostTile(
              post: video,
            );
          },
        );
      },
      error: (error, stackTrace) {
        return ErrorScreen(
          error: error.toString(),
        );
      },
      loading: () {
        return const Loader();
      },
    );
  }
}
