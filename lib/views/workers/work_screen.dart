import 'package:flutter/material.dart';
import 'package:frontend/common/jobs_card.dart';
import 'package:frontend/controllers/location_controller.dart';
import 'package:frontend/controllers/work_controller.dart';
import 'package:frontend/models/workmodel.dart';
import 'package:frontend/pallete.dart';
import 'package:frontend/theme.dart';
import 'package:get/get.dart';

class WorkerScreen extends StatefulWidget {
  const WorkerScreen({super.key});

  @override
  State<WorkerScreen> createState() => _WorkerScreenState();
}

class _WorkerScreenState extends State<WorkerScreen> {
  var location = Get.put(LocationController());
  var workController = Get.put(WorkController());
  @override
  void initState() {
    super.initState();
    workController.getWork(
        context, location.position.latitude, location.position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Obx(
      () => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Text(
            "Active Jobs",
            style: h1,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: (workController.isLoading.value)
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Container(
                    width: 396,
                    height: 427,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(0.00, -1.00),
                        end: Alignment(0, 1),
                        colors: [
                          Color(0xAD3BB368),
                          Color(0x5DFEFEFE),
                          Color(0x00F4FCF7)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: size.width * 0.2,
                        left: size.width * 0.05,
                        right: size.width * 0.05),
                    child: ListView.builder(
                      itemCount: workController.workList.length,
                      itemBuilder: (context, index) {
                        return JobsComponent(
                            size: size,
                            workModel: workController.workList[index]);
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
