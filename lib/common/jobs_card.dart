import 'package:flutter/material.dart';
import 'package:frontend/models/workmodel.dart';
import 'package:frontend/pallete.dart';
import 'package:frontend/theme.dart';

class JobsComponent extends StatelessWidget {
  const JobsComponent({
    super.key,
    required this.size,
    required this.workModel,
  });

  final Size size;
  final WorkModel workModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: size.width * 0.85,
        height: size.height * 0.14,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3FACACAC),
              blurRadius: 26,
              offset: Offset(0, 19),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: size.width * 0.5,
                  child: Text(
                    workModel.title ?? "",
                    overflow: TextOverflow.ellipsis,
                    style:
                        h1.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Text(
                  'Phone Number: ${workModel.phone ?? ""}',
                  style: sub1.copyWith(fontSize: 12),
                ),
                const Spacer(),
                Text(
                  workModel.district ?? "",
                  style: sub1.copyWith(fontSize: 12),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Price:",
                  style: sub1.copyWith(fontSize: 12),
                ),
                const Spacer(),
                Text(
                  workModel.price ?? "",
                  style: h1.copyWith(color: Pallete.greenColor),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
