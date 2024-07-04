import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/view/register/register_view.dart';
class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isObscurePassword = true;
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.bg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 50),
            SizedBox(
              height: 215,
              width: 275,
              child: Image.asset(
                "assets/img/logo.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              "Đăng nhập",
              style: TextStyle(color: TColor.primaryText, fontSize: 32),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField("Email", Icons.email_outlined),
                    const SizedBox(height: 16),
                    _buildPasswordTextField("Mật khẩu", _isObscurePassword, Icons.lock_outline),
                    Row(
                      children: [
                        Container(
                          height: 25,
                          width: 20,
                          margin:  const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: const [
                              BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: Checkbox(
                            fillColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                              if (states.contains(WidgetState.selected)) {
                                return TColor.primary; // Màu của checkbox khi được chọn
                              }
                              return TColor.primary.withOpacity(0.7); // Màu của checkbox khi không được chọn
                            }),
                            value: isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                        ),
                        Text(
                          "Nhớ mật khẩu",
                          style: TextStyle(
                              color: TColor.lightGray.withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                              fontSize: 12),
                        ),
                        Expanded(
                          child: Text(
                            "Quên mật khẩu?",
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 12, color: TColor.primary.withOpacity(0.5)),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0), // Độ cong của góc
                        border: Border.all(
                          color: TColor.primary.withOpacity(0.5), // Màu viền và độ mờ của nó
                          width: 0, // Độ dày của viền
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: TColor.primary.withOpacity(0.8), // Màu của shadow
                            spreadRadius: 1, // Bán kính lan rộng của shadow
                            blurRadius: 10, // Độ mờ của shadow
                            offset: const Offset(0, 2), // Độ dịch chuyển của shadow theo chiều dọc và ngang
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            // Xử lý khi form hợp lệ và button được nhấn
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColor.primary, // Màu chữ của button khi được nhấn
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0), // Độ cong của góc
                          ),
                          elevation: 5,
                          fixedSize: const Size(200, 50), // Kích thước cố định của button
                        ),
                        child: const Text(
                          'Đăng nhập',
                          style: TextStyle(color: Colors.white, fontSize: 16), // Màu chữ của button
                        ),
                      ),
                    ), //button dnhap
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Bạn chưa có tài khoản? ",
                          style: TextStyle(fontSize: 12, color: TColor.lightGray.withOpacity(0.7)),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: [
                              BoxShadow(
                                color: TColor.primary.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 8,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Get.off(const RegisterView());
                            },
                            child: Text(
                              " Đăng ký ngay",
                              style: TextStyle(color: TColor.primary),
                            ),
                          ),
                        )
                      ],
                    ) // bạn chưa có tai khoan
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String labelText, IconData icon) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: TColor.darkGray,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: TColor.darkGray),
      ),
      child: TextFormField(
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          labelText: labelText,
          labelStyle: TextStyle(color: TColor.unfocused),
          icon: Icon(icon, color: TColor.lightGray.withOpacity(0.5)),
          errorStyle: TextStyle(color: TColor.primaryTopIcon, fontSize: 12), // Tùy chỉnh style của error text
          errorBorder: InputBorder.none,// Tùy chỉnh style của error border
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Vui lòng nhập $labelText';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordTextField(String labelText, bool obscureText, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: TColor.darkGray,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: TColor.darkGray),
      ),
      child: TextFormField(
        obscureText: obscureText,
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          labelText: labelText,
          labelStyle: TextStyle(color: TColor.unfocused),
          icon: Icon(icon, color: TColor.lightGray.withOpacity(0.5)),
          errorStyle: TextStyle(color: TColor.primaryTopIcon, fontSize: 12), // Tùy chỉnh style của error text
          errorBorder: InputBorder.none,// Tùy chỉnh style của error border
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: TColor.lightGray.withOpacity(0.5),
              size: 17,
            ),
            onPressed: () {
              setState(() {
                _isObscurePassword = !_isObscurePassword;
              });
            },
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Vui lòng nhập $labelText';
          }
          return null;
        },
      ),
    );
  }
}
