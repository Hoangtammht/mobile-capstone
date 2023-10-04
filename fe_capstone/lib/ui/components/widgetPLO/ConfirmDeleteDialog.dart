import 'package:fe_capstone/main.dart';
import 'package:flutter/material.dart';

class ConfirmDeleteDialog extends StatefulWidget {
  @override
  _ConfirmDeleteDialogState createState() => _ConfirmDeleteDialogState();
}

class _ConfirmDeleteDialogState extends State<ConfirmDeleteDialog> {
  bool isConfirmed = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(23),
      ),
      backgroundColor: const Color(0xffffffff),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 15 * fem, vertical: 10 * fem),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Xóa bãi đỗ xe này khỏi tài khoản của bạn',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18 * fem),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8 * fem),
              child: Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: '*Lưu ý: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14 * fem)),
                  TextSpan(
                      text:
                      'Doanh thu vẫn chưa được rút ra khỏi tài khoản. Bạn sẽ mất nếu tiếp tục xóa.',
                      style: TextStyle(
                        fontSize: 14 * fem,
                      ))
                ]),
                textAlign: TextAlign.center,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Checkbox(
                    value: isConfirmed,
                    activeColor:
                    isConfirmed ? Colors.yellowAccent : Colors.grey[300],
                    overlayColor: MaterialStateProperty.all(Colors.grey),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                    ),
                    onChanged: (value) {
                      setState(() {
                        isConfirmed = !isConfirmed;
                      });
                    },
                  ),
                ),
                Text('Click vô ô bên nếu bạn muốn tiếp tục xóa')
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 1,
                        color: Color(0xffb3abab),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Hủy',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff5767f5),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 1,
                      height: 48,
                      color: Color(0xffb3abab),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        height: 1,
                        color: Color(0xffb3abab),
                      ),
                      TextButton(
                        onPressed: isConfirmed ? () {
                          Navigator.pop(context);
                        } : null,
                        child: Text(
                          'Xác nhận',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: isConfirmed ? Colors.red : Colors.redAccent[100],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }




}


// Sử dụng:

