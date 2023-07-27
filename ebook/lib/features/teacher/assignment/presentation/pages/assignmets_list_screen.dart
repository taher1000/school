import 'package:ebook/core/resources/color_manager.dart';
import 'package:ebook/core/resources/font_manager.dart';
import 'package:ebook/core/resources/styles_manager.dart';
import 'package:ebook/core/widgets/scaffolds/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../../core/resources/app_localization.dart';

class AssignmentsListScreen extends StatelessWidget {
  const AssignmentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localize = AppLocalization.of(context).getTranslatedValues;

    return CustomScaffold(
      screenTitle: localize("قائمة الواجبات"),
      body: Expanded(
        child: ListView.builder(
          itemCount: 9,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(
                  'Assignment ',
                  style: TextStyleManager.getMediumStyle(
                      color: ColorManager.black, fontSize: FontSize.s18),
                ),
                subtitle: Text(
                  'Due Date: 12/12/2021',
                  style: TextStyleManager.getLightStyle(
                      color: ColorManager.darkGrey, fontSize: FontSize.s12),
                ),
                leading: CircleAvatar(
                  backgroundColor: ColorManager.secondry,
                  child: Text(
                    'class $index',
                    style: TextStyleManager.getMediumStyle(
                        color: ColorManager.white, fontSize: FontSize.s11),
                  ),
                ),
                trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.delete, color: ColorManager.error)),
              ),
            );
          },
        ),
      ),
    );
  }
}
