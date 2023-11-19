import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simplenewsapp/di/di.dart';
import 'package:simplenewsapp/presentations/dashboard/provider/dashboard_provider.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  late final DashboardProvider provider = di();

  @override
  void initState() {
    provider.getCategories().then((value) {
      if (provider.categories.isNotEmpty) {
        provider.getNews(provider.categories.first);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
        ),
        body: Consumer<DashboardProvider>(
          builder: (context, provider, child) => Column(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...provider.categories.map((e) => Padding(
                          padding: const EdgeInsets.all(4),
                          child: ElevatedButton(
                              onPressed: () {
                                provider.getNews(e);
                              },
                              child: Text(
                                  '${e.characters.firstOrNull?.toUpperCase()}${e.length > 1 ? e.substring(1) : e}')),
                        ))
                  ],
                ),
              ),
              Expanded(
                child: provider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : provider.message != null
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text('Gagal memuat data'),
                                Text(
                                  provider.message!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if (provider.selectedCategory == null) {
                                        provider.getCategories();
                                      } else {
                                        provider.getNews(
                                            provider.selectedCategory ?? '');
                                      }
                                    },
                                    child: const Text('Reload')),
                              ],
                            ),
                          )
                        : ListView.builder(
                            itemCount: provider
                                .newsByCategory(provider.selectedCategory)
                                .length,
                            itemBuilder: (context, index) {
                              final item = provider.newsByCategory(
                                  provider.selectedCategory)[index];
                              return Column(
                                children: [
                                  if (index != 0) const Divider(),
                                  ListTile(
                                    onTap: () {
                                      context.push(Uri(
                                          path: '/browse',
                                          queryParameters: {
                                            'uri': item.link
                                          }).toString());
                                    },
                                    leading: Image.network(item.thumbnail,
                                        fit: BoxFit.cover),
                                    title: Text(
                                      item.title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                                Icons.date_range_rounded),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(DateFormat(
                                                    'HH:mm EEE, dd MM yyyy')
                                                .format(item.pubDate)),
                                          ],
                                        ),
                                        Text(item.description),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
