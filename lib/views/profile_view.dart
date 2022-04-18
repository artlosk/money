import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:money_tracker/main.dart';
import 'package:money_tracker/observables/auth_observable.dart';
import 'package:money_tracker/observables/charges_observable.dart';
import 'package:money_tracker/observables/storage_observable.dart';
import 'package:money_tracker/views/init_view.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../components/bottom_bar.dart';
import '../observables/tab_observable.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthState stateAuth = Provider.of<AuthState>(context);
    final StorageState stateStorage = Provider.of<StorageState>(context);
    final TabState stateTab = Provider.of<TabState>(context);
    final ChargesState stateCharges = Provider.of<ChargesState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Align(
          child: Text('Профиль'),
          alignment: Alignment.center,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Observer(
              builder: (_) {
                return Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFFD0D0D0),
                      radius: 50,
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              stateStorage.getImageFromGallery();
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: stateStorage.isLoading ? const CircularProgressIndicator() : stateStorage.image != null
                                  ? ClipOval(
                                      child: Image.file(
                                        File(stateStorage.image!.path),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : stateAuth.getAvatar() != null
                                      ? ClipOval(
                                          // child: Image.network(
                                          //   stateAuth.getAvatar()!,
                                          //   width: 100,
                                          //   height: 100,
                                          //   fit: BoxFit.cover,
                                          // ),
                                          child: CachedNetworkImage(
                                            placeholder: (context, url) => const CircularProgressIndicator(),
                                            imageUrl: stateAuth.getAvatar()!,
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : const Icon(
                                          Icons.camera_alt,
                                          color: Color(0xFFABABAB),
                                          size: 32,
                                        ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      child: TextButton(
                        onPressed: () => stateStorage.uploadImage(),
                        child: const Text('Сохранить'),
                      ),
                      visible: stateStorage.isPicked,
                    ),
                  ],
                );
              },
            ),
            Flexible(
              child: Container(
                padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stateAuth.getEmail()!,
                      style: const TextStyle(fontSize: 17),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    TextButton(
                      onPressed: () {
                        stateCharges.deleteAllData();
                      },
                      child: const Text('Очистить данные'),

                    ),
                    ElevatedButton(
                      onPressed: () {
                        stateAuth.signOut();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => const MyApp()),
                            (route) => false);
                      },
                      child: const Text('Выйти'),
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(180, 50)),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(const Color(0xFF9053EB)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Observer(
        builder: (context) => BottomBar(
          activeTabIndex: stateTab.activeTabIndex,
          onClicked: stateTab.updateTab,
        ),
      ),
    );
  }
}
