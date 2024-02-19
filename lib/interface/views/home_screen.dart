import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:monopoly_banker/config/utils/banker_images.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(BankerImages.topbar),
            ),
          ),
        ],
        body: Container(),
      ),
    );
  }
}
