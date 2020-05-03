import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

const String _markdownData = """
# 隐私政策

""";

class PrivacyPolicyRoute extends StatelessWidget {
  final controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('隐私政策'),
      ),
      body: SafeArea(
        child: Markdown(
          controller: controller,
          selectable: true,
          data: _markdownData,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_upward),
        onPressed: () => controller.animateTo(0,
            duration: Duration(seconds: 1), curve: Curves.easeOut),
      ),
    );
  }
}
