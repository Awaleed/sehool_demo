import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validators/validators.dart';

class AvatarSection extends FormField<File> {
  AvatarSection({
    Key key,
    @required FormFieldSetter<File> onSaved,
    @required ValueChanged<File> onChanged,
    File initialValue,
    VoidCallback onTap,
    String remoteImageUrl,
  }) : super(
            key: key,
            onSaved: onSaved,
            initialValue: initialValue,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            builder: (FormFieldState<File> state) {
              return InputDecorator(
                decoration: InputDecoration(
                  errorText: state.errorText,
                  border: InputBorder.none,
                ),
                child: Center(
                  child: InkWell(
                    onTap: () async {
                      if (onTap != null) onTap();
                      final imageFile = await _imagePick();
                      if (imageFile == null) return;
                      final croppedImage = await _imageCrop(imageFile);
                      state.didChange(croppedImage);
                      onChanged(croppedImage);
                    },
                    child: Transform.scale(
                      scale: .75,
                      child: Container(
                        decoration: state.hasError
                            ? BoxDecoration(
                                borderRadius: BorderRadius.circular(10000),
                                border: Border.all(
                                  color: Colors.red,
                                  width: 4,
                                ),
                              )
                            : null,
                        child: CircleAvatar(
                          radius: 95,
                          backgroundImage: () {
                            if (state.value == null && (remoteImageUrl == null || remoteImageUrl.isEmpty)) {
                              return const AssetImage('assets/img/user.png');
                            } else if (state.value == null && remoteImageUrl != null && remoteImageUrl.isNotEmpty) {
                              if (isURL(remoteImageUrl)) {
                                return CachedNetworkImageProvider(
                                  remoteImageUrl,
                                );
                              } else {
                                return const AssetImage('assets/img/user.png');
                              }
                            }
                            return FileImage(state.value);
                          }() as ImageProvider,
                          onBackgroundImageError: (exception, stackTrace) => const Center(
                            child: Icon(Icons.not_interested),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                bottom: 0,
                                left: 16,
                                child: FloatingActionButton(
                                  onPressed: () {},
                                  child: const Icon(
                                    Icons.camera,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });

  static Future<PickedFile> _imagePick() => ImagePicker().getImage(
        source: ImageSource.gallery,
      );

  static Future<File> _imageCrop(PickedFile imageFile) => ImageCropper.cropImage(
        sourcePath: imageFile.path,
        cropStyle: CropStyle.circle,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        androidUiSettings: const AndroidUiSettings(
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.square,
          backgroundColor: Colors.amber,
          toolbarColor: Colors.amber,
          lockAspectRatio: true,
        ),
        iosUiSettings: const IOSUiSettings(minimumAspectRatio: 1.0),
      );
}
