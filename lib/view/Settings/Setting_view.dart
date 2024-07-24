import 'package:flutter/material.dart';
import 'package:mmusic/common/color_extension.dart';
class SettingView extends StatelessWidget {
  const SettingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.bg,
      appBar: AppBar(
        backgroundColor: TColor.primary.withOpacity(0.5),
        title:const Text('Cài đặt'),
      ),
      body: ListView(
        children: [

          _buildListTile(
              context, Icons.data_saver_on, 'Trình tiết kiệm dữ liệu'),
          _buildListTile(context, Icons.language, 'Ngôn ngữ'),
          _buildListTile(context, Icons.block, 'Phát lại'),
          _buildListTile(context, Icons.tune, 'Lựa chọn ưu tiên về nội dung'),
          _buildListTile(context, Icons.tv, 'Thiết bị'),
          _buildListTile(context, Icons.car_rental, 'Ô tô'),
          _buildListTile(context, Icons.lock, 'Quyền riêng tư và mạng xã hội'),
          _buildListTile(
              context, Icons.headset_mic, 'Trợ lý thoại và ứng dụng'),
          _buildListTile(context, Icons.volume_up, 'Chất lượng âm thanh'),
          _buildListTile(context, Icons.video_call, 'Chất lượng video'),
          _buildListTile(context, Icons.storage, 'Không gian lưu trữ'),
          _buildListTile(context, Icons.notifications, 'Thông báo'),
          _buildListTile(context, Icons.ad_units, 'Quảng cáo'),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, IconData icon, String title,
      [String subtitle = '']) {
    return ListTile(
      leading: Icon(icon, color: TColor.primary),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: subtitle.isNotEmpty
          ? Text(subtitle, style: const TextStyle(color: Colors.white70))
          : null,
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
      onTap: () {
        // Handle on tap
      },
    );
  }
}