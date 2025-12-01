import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:wolf_pack/app/uitilies/app_colors.dart';
import 'package:wolf_pack/app/uitilies/custom_loader.dart';

import '../../../common_widget/custom_app_bar_widget.dart';
import '../../home/controllers/ny_clients_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../open_deal/views/make_deal.dart';

class AllClientsScreen extends StatelessWidget {
  AllClientsScreen({super.key});

  final controller = Get.put(MyAllClientsGetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'All Clients',
        showBackButton: false,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return  Center(child: CustomLoader());
        }

        final clients = controller.myAllClientData.value.data?.data ?? [];

        if (clients.isEmpty) {
          return const Center(
            child: Text(
              "No Clients Found",
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: clients.length,
          itemBuilder: (context, index) {
            final item = clients[index];

            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF).withOpacity(0.09),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ------------------------
                  //  CLOSER IMAGE
                  // ------------------------
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: CachedNetworkImage(
                      imageUrl: (item.userClients.isNotEmpty &&
                          item.userClients.first.closers.isNotEmpty &&
                          item.userClients.first.closers.first
                              .closerDocuments.isNotEmpty)
                          ? (item.userClients.first.closers.first
                          .closerDocuments.first.document ??
                          "")
                          : "",
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => const CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      errorWidget: (_, __, ___) =>  CircleAvatar(
                        radius: 28,
                        backgroundColor:AppColors.orangeColor,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // ------------------------
                  //  TEXT SECTION
                  // ------------------------
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name
                        Text(
                          item.name ?? "No Name",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 4),

                        // Rates
                        Text(
                          "Agency Rate: ${item.agencyRate}",
                          style:
                          const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          "Commission Rate: ${item.commissionRate}",
                          style:
                          const TextStyle(fontSize: 14, color: Colors.grey),
                        ),

                        const SizedBox(height: 6),
                      ],
                    ),
                  ),

                  // ------------------------
                  //  BUTTON
                  // ------------------------
                  ElevatedButton(
                    onPressed: () {
                      final userClientId = item.userClients.isNotEmpty
                          ? item.userClients.first.id
                          : null;

                      if (userClientId != null) {
                        Get.to(() => NewAddDealsForm(
                          clientId: userClientId, clientName: item.name ?? "N/A",
                        ));
                      } else {
                        Get.snackbar("Error", "UserClient ID not found!");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.orangeColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      "Create Deal",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
