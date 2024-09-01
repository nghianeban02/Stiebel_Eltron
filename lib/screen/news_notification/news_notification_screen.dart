import 'package:flutter/material.dart';
import '../../page/mainpage/hompage.dart';
import '/config/icon.dart';
import '/config/color.dart';
void main(List<String> args) {
  runApp(const MaterialApp(home:NewsandNotificationScreen()));

}
class NewsandNotificationScreen extends StatefulWidget {
  const NewsandNotificationScreen({super.key});

  @override
  _NewsandNotificationScreenState createState() =>
      _NewsandNotificationScreenState();
}

class _NewsandNotificationScreenState extends State<NewsandNotificationScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
             Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const homePage()));
          },
        ),
        title: const Text('Tra cứu bảo hành', style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
        backgroundColor: AppColors.backgroudWhite,
        foregroundColor: AppColors.textRed,
        
        bottom: TabBar(
          controller: _tabController,
          indicator: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
          ),
          tabs: const [
            Tab(
              child: Text(
                'Thông báo',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
            Tab(
              child: Text(
                'Tin tức',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationTab(),
          _buildNewsTab(),
        ],
      ),
    );
  }

  Widget _buildNotificationTab() {
    return ListView(
      children: [
        _buildNotificationItem("22.05.2024; 09:30","Tên sản phẩm","Số serial","Đã được kích hoạt bảo hành thành công"),
        _buildNotificationItem("21.05.2024; 18:30","Tên sản phẩm","Số serial","Đã được kích hoạt bảo hành thành công"),
        _buildNotificationItem("21.05.2024; 10:30","Tên sản phẩm","Số serial","Đã được kích hoạt bảo hành thành công"),
        _buildNotificationItem("21.05.2024; 09:30","Tên sản phẩm","Số serial","Đã được kích hoạt bảo hành thành công"),
      ],
    );
  }

  Widget _buildNotificationItem(String dateTime,String name,String serial,String status ) {
  return ListTile(
    contentPadding: const EdgeInsets.only(left: 10.0), // Add this line
    leading:  Container(
        decoration:BoxDecoration(
        border: Border.all(color: AppColors.primary,width: 3),
        borderRadius: BorderRadius.circular(20),
      ),
      child:  const CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.primary,
        backgroundImage:
            AssetImage(AppIcon.logotron) 
             // Update with your asset image path
      ),
    ),
    subtitle: Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      padding:const EdgeInsets.only(left: 10.0), // Add padding here
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(dateTime),
            Text(name),
            Text(serial),
            Text(status),
        ],
      ),
    ),
    isThreeLine: true,
  );
}
  Widget _buildNewsTab() {
    return ListView(
      children: [
        _buildNewsItem(
          "Máy nước nóng",
          "Nước nóng cho bồn rửa tay, vòi hoa sen hoặc bồn tắm  nhanh chóng và hiệu quả với các giải pháp nước nóng sinh hoạt của chúng tôi. Nâng niu những phút giây thư giãn.",
          'assets/images/poster3.jpg', // Update with your asset image path
        ),
        _buildNewsItem(
          "Máy bơm nhiệt",
          "Các hệ thống thiết bị sử dụng năng lượng tái tạo của STIEBEL ELTRON đang hoạt động rất hiệu quả. Cùng tìm hiểu thêm về máy bơm nhiệt tạo nước nóng của chúng tôi.",
          'assets/images/poster1.jpg', // Update with your asset image path
        ),
        _buildNewsItem(
          "Máy lọc nước",
          "Thưởng thức nước uống tinh khiết tại nhà. Hệ thống lọc đa tầng của chúng tôi giúp làm sạch nước máy, đảm bảo độ an toàn để uống.",
          'assets/images/poster2.jpg', // Update with your asset image path
        ),
      ],
    );
  }

  Widget _buildNewsItem(String title, String description, String imagePath) {
    return ListTile(
      leading: 
      Image.asset(imagePath, width: 100, height: 200),
      title: Text(title),
      subtitle: Text(description,textAlign: TextAlign.justify),
      isThreeLine: true,
      
    );
    
  }
}
