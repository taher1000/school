import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../resources/color_manager.dart';

class ListShimmerLoadingWidget extends StatelessWidget {
  const ListShimmerLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .9,
      child: ListView.builder(
        itemBuilder: (c, i) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Card(
            elevation: 5,
            surfaceTintColor: ColorManager.greyTextColor,
            color: ColorManager.greyTextColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                              child: shimmerBuilder(
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: ColorManager.greyTextColor,
                            ),
                          )),
                          const SizedBox(
                            width: 20,
                          ),
                          Flexible(
                            child: shimmerBuilder(
                              Container(
                                height: 20,
                                width: 150,
                                color: Colors.black,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        itemCount: 4,
      ),
    );
  }

  Shimmer shimmerBuilder(child) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          Colors.grey.shade300,
          Colors.grey.shade100,
          Colors.grey.shade50,
        ],
      ),
      child: child,
    );
  }
}
