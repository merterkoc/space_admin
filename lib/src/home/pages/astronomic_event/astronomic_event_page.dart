import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:space_admin/src/home/pages/astronomic_event/bloc/astronomic_event_bloc.dart';
import 'package:space_admin/src/home/pages/astronomic_event/listener/astronomic_event_page_listener.dart';
import 'package:space_admin/src/home/pages/astronomic_event/widget/astronomic_event_list_card.dart';

class AstronomicEventPage extends StatefulWidget {
  const AstronomicEventPage({super.key});

  @override
  State<AstronomicEventPage> createState() => _AstronomicEventPageState();
}

class _AstronomicEventPageState extends State<AstronomicEventPage> {
  @override
  void initState() {
    context.read<AstronomicEventBloc>().add(const GetAstronomicEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AstronomicEventPageListener.listener(
      child: Scaffold(
        body: Column(
          children: [
            const Menu(),
            Expanded(
              child: BlocBuilder<AstronomicEventBloc, AstronomicEventState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      itemCount: state.astronomicEventList.length,
                      itemBuilder: (context, index) {
                        return BlocBuilder<AstronomicEventBloc,
                            AstronomicEventState>(
                          builder: (context, state) {
                            return AstronomicEventListCard(
                              astronomicEventModel:
                                  state.astronomicEventList[index],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          onPressed: () => context.read<AstronomicEventBloc>().add(
                const GetAstronomicEvent(),
              ),
          child: const Text(
            'Refresh',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 20),
        TextButton(
          onPressed: () => context.go('/astronomic-event/add'),
          child: const Text(
            'Create Astronomic Event',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
