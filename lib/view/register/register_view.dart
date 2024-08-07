import 'package:flutter/material.dart';
import 'package:mmusic/api/api.dart';
import 'package:mmusic/common/color_extension.dart';
import 'package:mmusic/services/song_handler.dart';
import 'package:mmusic/view/login/login_view.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
  final SongHandler songHandler;
  const RegisterView({super.key, required this.songHandler});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController= TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;
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
                "assets/img/logo_app.png",
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              "Đăng ký",
              style: TextStyle(color: TColor.primaryText, fontSize: 32),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _buildTextField("Họ và tên", Icons.person_outline,_nameController),
                    const SizedBox(height: 16),
                    _buildTextField("Email", Icons.email_outlined,_emailController),
                    const SizedBox(height: 16),
                    _buildPasswordTextField("Mật khẩu", _isObscurePassword, Icons.lock_outline,_passwordController),
                    const SizedBox(height: 16),
                    _buildPasswordTextField("Xác nhận mật khẩu", _isObscureConfirmPassword, Icons.key_outlined,_confirmPasswordController),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0,20,0,5),
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
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                             await API().register(
                                _emailController.text,
                                _passwordController.text,
                                _nameController.text)
                                ? Get.off(()=>  LoginView(songHandler: widget.songHandler,))
                                : ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Center(
                                      child: Text('Email đã tồn tại', style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: TColor.primaryText,
                                        fontSize: 20
                                      ),),
                                    ),
                                    duration: const Duration(seconds: 2),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: TColor.primary,
                                    padding:const EdgeInsets.all(20),
                                    margin:const EdgeInsets.only(bottom: 400,left: 20,right: 20),
                               ),
                             );

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
                          'Đăng ký',
                          style: TextStyle(color: Colors.white, fontSize: 16), // Màu chữ của button
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Bạn đã có tài khoản? ",
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
                            onTap:(){
                              Get.off(()=> LoginView(songHandler: widget.songHandler,));
                            },
                            child: Text(" Đăng nhập ngay",style: TextStyle(color:TColor.primary ),),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTextField(String labelText, IconData icon,TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10,0,10,0),
      decoration: BoxDecoration(
        color: TColor.darkGray,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: TColor.darkGray),
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          labelText: labelText,
          labelStyle: TextStyle(color: TColor.unfocused),
          icon: Icon(icon, color: TColor.lightGray.withOpacity(0.5)),
          errorStyle: TextStyle(color: Color(0xfff64040).withOpacity(0.3), fontSize: 12), // Tùy chỉnh style của error text
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

  Widget _buildPasswordTextField(String labelText, bool obscureText, IconData icon,TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: TColor.darkGray,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: TColor.darkGray),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          labelText: labelText,
          labelStyle: TextStyle(color: TColor.unfocused),
          icon: Icon(icon, color: TColor.lightGray.withOpacity(0.5)),
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
              color: TColor.lightGray.withOpacity(0.5),
              size: 17,
            ),
            onPressed: () {
              setState(() {
                if (labelText == "Mật khẩu") {
                  _isObscurePassword = !_isObscurePassword;
                } else if (labelText == "Xác nhận mật khẩu") {
                  _isObscureConfirmPassword = !_isObscureConfirmPassword;
                }
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
