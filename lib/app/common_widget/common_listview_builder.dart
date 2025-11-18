import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wolf_pack/app/common_widget/nodata_wisgets.dart';

class ReusableListView<T> extends StatelessWidget {
  final RxBool isLoading;
  final RxList<T> dataList;
  final Future<void> Function()? onRetry;
  final Widget Function(BuildContext, T) itemBuilder;
  final double height;
  final EdgeInsets? padding;
  final bool isFlex;

  const ReusableListView({
    Key? key,
    required this.isLoading,
    required this.dataList,
    required this.itemBuilder,
    this.onRetry,
    this.height = 300,
    this.isFlex = false, this.padding,














  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (dataList.isEmpty) {
        return Center(
          child: GestureDetector(
            onTap: onRetry,
            child:NoDataWidget(text: ''),
          ),
        );
      }

      if(isFlex){
        return ListView.builder(
          itemCount: dataList.length,
          shrinkWrap: true,
          primary: false,
          padding: padding,
          itemBuilder: (context, index) {
            return itemBuilder(context, dataList[index]);
          },
        );
      }

      return SizedBox(
        height: height,
        child: ListView.builder(
          itemCount: dataList.length,
          padding: padding,
          itemBuilder: (context, index) {
            return itemBuilder(context, dataList[index]);
          },
        ),
      );
    });
  }
}
