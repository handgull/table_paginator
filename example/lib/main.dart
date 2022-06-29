import 'package:flutter/material.dart';
import 'package:table_paginator/table_paginator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'table_paginator example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activePage = 0;
  int pageSize = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('table_paginator example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Text('Page ${activePage + 1}'),
                  Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: ListView(
                        children: List.generate(
                          pageSize,
                          (index) => ListTile(
                            title: Text('Item ${activePage + 1}.${index + 1}'),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TablePaginator(
              pageSize: pageSize,
              pageIndex: activePage,
              length: 95,
              onPageSizeChanged: (newValue) {
                setState(() {
                  activePage = 0;
                  pageSize = newValue;
                });
              },
              onSkipPreviousPressed: () {
                setState(() {
                  activePage = 0;
                });
              },
              onPreviousPressed: () {
                setState(() {
                  activePage = activePage - 1;
                });
              },
              onNextPressed: () {
                setState(() {
                  activePage = activePage + 1;
                });
              },
              onSkipNextPressed: (lastPage) {
                setState(() {
                  activePage = lastPage;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
