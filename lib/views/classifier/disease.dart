import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/controllers/disease_controller.dart';
import 'package:frontend/controllers/location_controller.dart';
import 'package:frontend/pallete.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:image_picker/image_picker.dart';
import '../../theme.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';

XFile? image;

class DiseaseView extends StatefulWidget {
  const DiseaseView({
    Key? key,
  }) : super(key: key);

  @override
  State<DiseaseView> createState() => _DiseaseViewState();
}

class _DiseaseViewState extends State<DiseaseView> {
  late ValueNotifier<double> valueNotifier;

  @override
  void initState() {
    super.initState();
    valueNotifier = ValueNotifier(0.0);
  }

  File? selectedImage;
  var disease = Get.put(DiseaseController());
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    valueNotifier.value = 64;
    var size = MediaQuery.of(context).size;
    var auth = Get.put(AuthController());
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Plant Disease Detector",
                        style: h1.copyWith(fontSize: 34, color: Colors.black),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        "Please use only\nleaf images",
                        style: sub1,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        "Upload Image",
                        style: sub1.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Pallete.greenColor),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () async {
                      await chooseImage(disease);
                    },
                    child: selectedImage != null
                        ? Container(
                            width: size.width * 0.84,
                            height: size.height * 0.2,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF4FCF7),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x28000000),
                                  blurRadius: 43,
                                  offset: Offset(-2, 11),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                            child: Image.file(
                                selectedImage!)) // Show the picked image
                        : Container(
                            child: Center(
                              child: IconButton(
                                iconSize: 44,
                                icon: Icon(
                                  LineIcons.camera,
                                  color: Pallete.greenColor,
                                ),
                                onPressed: () {},
                              ),
                            ),
                            width: size.width * 0.84,
                            height: size.height * 0.2,
                            decoration: ShapeDecoration(
                              color: Color(0xFFF4FCF7),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7)),
                              shadows: [
                                BoxShadow(
                                  color: Color(0x28000000),
                                  blurRadius: 43,
                                  offset: Offset(-2, 11),
                                  spreadRadius: 0,
                                )
                              ],
                            ),
                          ),
                  ),
                ),
                selectedImage != null
                    ? Obx(
                        () => (disease.isLoading.value)
                            ? Center(child: CircularProgressIndicator())
                            : Padding(
                                padding: const EdgeInsets.all(28.0),
                                child: SizedBox(
                                  height: size.height * 0.5,
                                  width: size.width,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Disease Name",
                                        style: h1.copyWith(
                                            fontSize: 28,
                                            color: Pallete.greenColor),
                                      ),
                                      Text(
                                        disease.disease.value.name ?? "",
                                        style: h1.copyWith(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Row(
                                        children: [
                                          Text("Accuracy : ",
                                              style: h1.copyWith(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
                                          SizedBox(
                                            width: size.width * 0.12,
                                          ),
                                          SimpleCircularProgressBar(
                                            animationDuration: 2,
                                            valueNotifier: valueNotifier,
                                            maxValue: 100,
                                            mergeMode: false,
                                            onGetText: (double value) {
                                              return Text('${value.toInt()}%');
                                            },
                                          ),
                                        ],
                                      ),
                                      Text("Solution:",
                                          style: h1.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600)),
                                      Container(
                                        width: size.width * 0.8,
                                        height: size.height * 0.6,
                                        child: Text(
                                            disease.disease.value.soln ??
                                                ""),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Uploading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> chooseImage(DiseaseController diseaseController) async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Column(
                children: const [
                  Text(
                    'No File choosen',
                  ),
                ],
              ),
            ),
          );
        },
      );
      return false;
    } else {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
      File file = File(pickedFile.path);
      await diseaseController.getDisease(file, context);
      valueNotifier.value = diseaseController.disease.value.accuracy!;
      return true;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}
