
import 'package:flutter/material.dart';

import 'package:wolf_pack/app/common%20widget/gradient.dart';

import '../../../common widget/custom_app_bar_widget.dart';
import '../widgets/about_section_widgets.dart';

class AboutUSView extends StatefulWidget {
  const AboutUSView({super.key});

  @override
  State<AboutUSView> createState() => _AboutUSViewState();
}

class _AboutUSViewState extends State<AboutUSView> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(
        title: 'About Us',
      ),
      body: Stack(
        children: [
          // Top gradient fading softly to white
          GradientContainer(

          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: screenHeight * 0.1),
                AboutUsSection(
                  content: '''
Lorem ipsum dolor sit amet consectetur. Ultrices id feugiat venenatis habitant mattis viverra elementum purus volutpat. Lacus eu molestie pulvinar rhoncus integer proin elementum. Pretium sit fringilla massa tristique aenean commodo leo. Aliquet viverra amet sit porta elementum et pellentesque posuere. Ullamcorper viverra tortor lobortis viverra auctor egestas. Nulla condimentum ac metus quam turpis gravida ut velit. Porta justo lacus consequat sed platea. Ut dui massa quam elit faucibus consectetur sapien aenean auctor. Felis ipsum amet justo in. Netus amet in egestas sed auctor lorem.
''',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
