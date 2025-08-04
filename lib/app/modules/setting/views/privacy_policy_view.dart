import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pet_donation/app/common%20widget/custom%20text/custom_text_widget.dart';
import 'package:pet_donation/app/common%20widget/custom_app_bar_widget.dart';
import 'package:pet_donation/app/modules/profile/widgets/about_section_widgets.dart';
import 'package:pet_donation/app/uitilies/app_colors.dart';

class SPPrivacyPolicyView extends StatelessWidget {
  const SPPrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBar(
        title: 'Privacy Policy',
      ),
      body:           Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [    CustomText(
            textAlign: TextAlign.start,
            text:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus pulvinar, nisi vel scelerisque tincidunt, sapien nibh tristique mi, et rhoncus ipsum erat sed enim. Pellentesque vel velit non sem porta vehicula. Aenean hendrerit, metus nec gravida fringilla, elit quam hendrerit urna, sed efficitur justo lacus in erat.\n\n'
                'Vestibulum vitae nulla non nisl convallis vestibulum. Sed vel justo dignissim, sollicitudin risus non, porttitor mauris. Quisque non sapien a nibh lacinia finibus. Duis posuere odio a elit fermentum, nec placerat nisl ultricies. Nullam in sem non mi tempor vulputate. Mauris eget lacinia lorem, in viverra augue.\n\n'
                'Phasellus ac lacus in lacus porttitor dapibus. Morbi condimentum, lacus eget posuere consectetur, lorem magna fringilla quam, at tristique massa erat vitae eros. Suspendisse interdum congue velit a hendrerit. Donec porttitor lectus non tellus vestibulum, in egestas leo ullamcorper.',
            fontSize: 12.sp,
            color: Colors.white.withOpacity(0.7),
          ),

          ],
        ),
      ),

    );
  }
}
