import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/post.dart';
import '../services/mock_posts.dart';

class ForumScreen extends StatelessWidget {
  const ForumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1000,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Forum Społeczności",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            "Przeglądaj wpisy, dziel się analizami i uczestnicz w dyskusjach.",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          sortMenu(),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add_circle),
            label: const Text("Nowy post"),
          ),
          const SizedBox(height: 24),
          postsList(posts),
        ],
      ),
    );
  }

  Row sortMenu() {
    return Row(
      children: [
        const Text("Sortuj: "),
        const SizedBox(width: 8),
        DropdownButton<String>(
          items: const [
            DropdownMenuItem(value: "recent", child: Text("Najnowsze")),
            DropdownMenuItem(
                value: "popular", child: Text("Najpopularniejsze")),
          ],
          value: "recent",
          onChanged: (_) {},
        ),
      ],
    );
  }

  ListView postsList(List<Post> posts) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final post = posts[index];
        final formattedDate = DateFormat('yyyy-MM-dd').format(post.date);

        return GestureDetector(
          onTap: () => showPostCard(context, post, formattedDate),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "Autor: ${post.author}",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "${post.comments} komentarzy",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        formattedDate,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post.summary,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> showPostCard(
      BuildContext context, Post post, String formattedDate) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(post.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Autor: ${post.author}"),
              const SizedBox(height: 8),
              Text("Data: $formattedDate "),
              const SizedBox(height: 12),
              Text(post.content),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Zamknij"),
          ),
        ],
      ),
    );
  }
}
