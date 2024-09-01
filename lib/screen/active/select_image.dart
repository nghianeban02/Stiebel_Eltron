import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:stiebel_etron_warranty/bloc/account/account_cubit.dart';
import 'package:stiebel_etron_warranty/bloc/activate/activate_cubit.dart';
import 'package:stiebel_etron_warranty/config/utils.dart';
import 'package:stiebel_etron_warranty/screen/widget/custom_text.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
import '../../config/color.dart';
import '../widget/custom_button.dart';

class SelectImage extends StatefulWidget {
  final String title;
   const SelectImage({super.key,required this.title});

  @override
  State<SelectImage> createState() => _SelectImageState();
}
  final _picker = ImagePicker();
class _SelectImageState extends State<SelectImage> {
  XFile? image;
  late ActivateCubit acitvateCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    acitvateCubit = BlocProvider.of<ActivateCubit>(context);
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
     _buildUploadImage(widget.title,LocaleKeys.cameraOrGallery.tr, image, takeModelSerial),
        // _buildUploadImage('Hình ','Chụp hoặc / chọn ảnh ', image, takeModelSerial),


      ],
    );
  }
  
  _buildUploadImage(String? title,String? text,XFile? fileImage, final voidCallBack) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),  
        Row(
          children: [
            CustomText().textSize20(title: title, color: AppColors.primary, fontWeight:FontWeight.bold),
          ],
        ),
      CustomText().textSize12(text: text).paddingSymmetric(vertical: 10),
      InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: (() {
              showModalBottomSheet(backgroundColor: Colors.white.withOpacity(0), context: context, builder: ((context) => bottomSheet(voidCallBack)));
            }),
            child: Container(
              height: fileImage == null ? 145.h : 200.h,
              decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.all(Radius.circular(15))),
              child: Center(
                child: fileImage != null
                    ? Image(
                        image: FileImage(
                          File(fileImage.path),
                        ),
                        fit: BoxFit.fitWidth,
                      )
                    :  const Icon(
                        Icons.camera_alt,
                        color: AppColors.grey,
                        size: 30,
                      ),
              ),
            ))
      ],
    );
  }
  Widget bottomSheet(final voidCallback) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              color: AppColors.grey,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    LocaleKeys.selectFrom.tr,
                    style: TextStyle(fontSize: 14.sp, color:AppColors.primary, fontWeight: FontWeight.w700, height: 1.5),
                  ),
                ),
                const Divider(height: 1, thickness: 0.5, color: AppColors.grey),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: (() {
                        Utils.checkPermission(context);
                        // isFont ? takePhotoFont(ImageSource.camera) : takePhotoBack(ImageSource.camera);
                        voidCallback(ImageSource.camera);
                      }),
                      icon: const Icon(Icons.camera_alt_rounded),
                      style: const ButtonStyle(),
                      label:  Text(
                        LocaleKeys.camera.tr,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const Divider(height: 1, thickness: 0.5, color: AppColors.grey),
                    TextButton.icon(
                      onPressed: (() {
                        Utils.checkPermission(context);
                        voidCallback(ImageSource.gallery);
                      }),
                      icon: const Icon(Icons.image),
                      label:  Text(
                        LocaleKeys.gallery.tr,
                        style: const TextStyle(fontSize: 16),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: BaseButton(
              width: double.infinity,
              text: LocaleKeys.cancel.tr,
              onTap: () => Navigator.pop(context),
              textColor: AppColors.white,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  void takeModelSerial(ImageSource imageSource) async {
    final pickFile = await _picker.pickImage(source: imageSource, imageQuality: 25);
    if (pickFile != null) {
      image = pickFile;

      acitvateCubit.selectImage = image;
    }

    setState(() {
      acitvateCubit.uploadImage();
    });
    Navigator.of(context).pop();
  }

  String convertToBase64(XFile file) {
    final imageBytes = File(file.path).readAsBytesSync();

    String base64Image = base64Encode(imageBytes);
    print(base64Image);
    return base64Image;
  }
}