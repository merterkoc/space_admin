import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:space_admin/core/router/space_router/space_router.dart';
import 'package:space_admin/src/home/pages/astronomic_event/model/astronomic_event_model.dart';

class AstronomicEventListCard extends StatelessWidget {
  const AstronomicEventListCard(
      {super.key, required this.astronomicEventModel});

  final AstronomicEventModel astronomicEventModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          context.goNamed(
            SpaceRoute.astronomicEventDetail.name,
          );
        },
        child: ListTile(
          title: Text(astronomicEventModel.name ?? ''),
          subtitle: Text(astronomicEventModel.description ?? ''),
          leading: astronomicEventModel.image != null &&
                  astronomicEventModel.image!.isNotEmpty
              ? Image.network(astronomicEventModel.image?.first ?? '')
              : const Icon(Icons.image),
        ),
      ),
    );
  }
}
