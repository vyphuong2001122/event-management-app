import 'package:easy_localization/easy_localization.dart';
import 'package:event_management_app/controllers/home_controller.dart';
import 'package:event_management_app/controllers/speaker_controller.dart';
import 'package:event_management_app/models/speaker.dart';
import 'package:event_management_app/view/widgets/speaker_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpeakerListScreen extends StatefulWidget {
  const SpeakerListScreen({Key? key}) : super(key: key);

  @override
  State<SpeakerListScreen> createState() => _SpeakerListScreenState();
}

class _SpeakerListScreenState extends State<SpeakerListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<SpeakerController>(context, listen: false).getSpeakerList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SpeakerController, HomeController>(
      builder: (context, speakerController, homeController, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('speaker_list_screen.all_speakers'.tr()),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Wrap(
                children: <Widget>[
                  if (speakerController.loading)
                    const CircularProgressIndicator()
                  else if (speakerController.speakers.isNotEmpty)
                    for (Speaker speaker in speakerController.speakers)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SpeakerItem(
                          speaker: speaker,
                          canEdit: homeController.currentUser?.role ==
                                  'admin' ||
                              homeController.currentUser?.role == 'organizer',
                        ),
                      )
                  else
                    Container(
                      alignment: Alignment.center,
                      height: 500,
                      child: Text('home_screen.list_empty'.tr()),
                    )
                ],
              ),
            ),
          ),
          floatingActionButton: homeController.currentUser?.role == 'admin'
              ? FloatingActionButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add-new-speaker');
                  },
                  child: Icon(Icons.add),
                )
              : null,
        );
      },
    );
  }
}
