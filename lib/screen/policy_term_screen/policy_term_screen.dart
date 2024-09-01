import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stiebel_etron_warranty/service/locale_keys.dart';
//  import '/config/icon.dart';
import '../../page/mainpage/hompage.dart';
import '/config/color.dart';

void main(List<String> args) {
  runApp(const MaterialApp(home: PolicyTermsScreen()));
}

class PolicyTermsScreen extends StatefulWidget {
  const PolicyTermsScreen({super.key});

  @override
  _PolicyTermsScreenState createState() => _PolicyTermsScreenState();
}

class _PolicyTermsScreenState extends State<PolicyTermsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: Text(
          LocaleKeys.policyandTerms.tr,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.backgroudWhite,
        foregroundColor: AppColors.textRed,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.black,
          indicatorColor: AppColors.primary,
          tabs: [
            Tab(text: LocaleKeys.policy.tr),
            Tab(text: LocaleKeys.term.tr),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PolicyTermsContent(contentType: 'policy'),
          PolicyTermsContent(contentType: 'terms'),
        ],
      ),
    );
  }
}

class PolicyTermsContent extends StatelessWidget {
  final String contentType;

  PolicyTermsContent({super.key, required this.contentType});

  final List<Map<String, String>> policyContent = [
    {
      'title': LocaleKeys.policy1.tr,
      'content': LocaleKeys.policyContent1.tr,
    },
    {
      'title': LocaleKeys.policy2.tr,
      'content': LocaleKeys.policyContent2.tr,
    },
    {
      'title': LocaleKeys.policy3.tr,
      'content': LocaleKeys.policyContent3.tr,
    },
    {
      'title': LocaleKeys.policy4.tr,
      'content': LocaleKeys.policyContent4.tr,
    },
    {
      'title': LocaleKeys.policy5.tr,
      'content': LocaleKeys.policyContent5.tr,
    },
    {
      'title': LocaleKeys.policy6.tr,
      'content': LocaleKeys.policyContent6.tr,
    },
    {
      'title': LocaleKeys.policy7.tr,
      'content': LocaleKeys.policyContent7.tr,
    }
  ];

  final List<Map<String, String>> termsContent = [
    {
      'title': LocaleKeys.term1.tr,
      'content': LocaleKeys.termContent1.tr,
    },
    {
      'title': LocaleKeys.term2.tr,
      'content': LocaleKeys.termContent2.tr,
    },
    {
      'title': LocaleKeys.term3.tr,
      'content': LocaleKeys.termContent3.tr,
    },
    {
      'title': LocaleKeys.term4.tr,
      'content': LocaleKeys.termContent4.tr,
    },
    {
      'title': LocaleKeys.term5.tr,
      'content': LocaleKeys.termContent5.tr,
    },
    {
      'title': LocaleKeys.term6.tr,
      'content': LocaleKeys.termContent6.tr,
    },
    {
      'title': LocaleKeys.term7.tr,
      'content': LocaleKeys.termContent7.tr,
    },
    {
      'title': LocaleKeys.term8.tr,
      'content': LocaleKeys.termContent8.tr,
    },
  ];
  @override
Widget build(BuildContext context) {
  List<Map<String, String>> content = contentType == 'policy' ? policyContent : termsContent;
  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: content.asMap().entries.map((entry) {
          int index = entry.key;
          Map<String, String> item = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: RichText(
              textAlign: TextAlign.justify, // Justify-align the text
              text: TextSpan(
                style: const TextStyle(color: AppColors.black, fontSize: 16),
                children: [
                  TextSpan(
                    text: '${index + 1}. ${item['title']}: ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: item['content']),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    ),
  );
}
}
