import 'package:event_management_app/colors.dart';
import 'package:event_management_app/controllers/event_controller.dart';
import 'package:event_management_app/models/event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class EventDetailScreen extends StatefulWidget {
  const EventDetailScreen({super.key});

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  bool init = false;
  Event? event;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addTimingsCallback((timings) {
      if (mounted && !init) {
        Map<String, dynamic> param =
            ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        setState(() {
          init = true;
        });
        Provider.of<EventController>(context, listen: false)
            .getDetailEvent(param['id'])
            .then((value) {
          setState(() {
            event = value;
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> param =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Consumer<EventController>(builder: (context, eventController, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Opacity(
                opacity: 0.5,
                child: Image.asset('assets/images/event_detail_background.png'),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Image.asset(
                      'assets/images/event_illustration.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (param['qr'] != null)
                          Center(
                            child: QrImageView(
                              data: param['qr'],
                              size: 200,
                            ),
                          ),
                        Text(
                          event?.title ?? '',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                        if (event?.location != null)
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: primaryColor,
                                size: 16,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  event!.location,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        if (event?.date != null)
                          Row(
                            children: [
                              const Icon(
                                Icons.timer,
                                color: primaryColor,
                                size: 16,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  DateFormat('dd/MM/yyyy - HH:mm')
                                      .format(event!.date),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: 10),
                        Text(event?.description ?? ''),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: param['qr'] == null
            ? Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: MaterialButton(
                  onPressed: eventController.loading
                      ? null
                      : () {
                          if (event?.id != null) {
                            eventController
                                .registerForEvent(event!.id!)
                                .then((qrKey) {
                              if (qrKey != null) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Save this QR for later'),
                                      content: Container(
                                        width: 200,
                                        height: 200,
                                        alignment: Alignment.center,
                                        child: QrImageView(
                                          data: qrKey,
                                          version: QrVersions.auto,
                                          size: 200.0,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            });
                          }
                        },
                  height: 50,
                  disabledColor: primaryColorLight,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  textColor: Colors.white,
                  color: primaryColor,
                  child: eventController.loading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
                          'APPLY FOR THIS EVENT',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                ),
              )
            : null,
      );
    });
  }
}
