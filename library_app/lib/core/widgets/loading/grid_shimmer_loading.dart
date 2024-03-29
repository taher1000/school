import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../resources/color_manager.dart';

class GridShimmerLoadingWidget extends StatelessWidget {
  const GridShimmerLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (c, i) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Card(
          elevation: 5,
          surfaceTintColor: ColorManager.greyTextColor,
          color: ColorManager.greyTextColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                            child: shimmerBuilder(
                          const CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.grey,
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        shimmerBuilder(
                          const Icon(
                            Icons.favorite_border,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        shimmerBuilder(
                          Container(
                            height: 10,
                            width: 100,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Positioned(
                    right: 0,
                    bottom: 0,
                    child: shimmerBuilder(
                      Container(
                        width: 125,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: ColorManager.darkPrimary),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              color: ColorManager.greyTextColor,
                            ),
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
      itemCount: 5,
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
