

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gic_client/core/widgets/Custom_Text.dart';
import 'package:gic_client/core/widgets/custom_appbar.dart';

class MsgsView extends StatefulWidget {
  const MsgsView({super.key});

  @override
  State<MsgsView> createState() => _MsgsViewState();
}

class _MsgsViewState extends State<MsgsView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar('', true, 50),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: const [
          SizedBox(height: 6,),
          Custom_Text(text: 'Your Messages',fontSize: 22)
        ],),
      ),
    );
  }
}