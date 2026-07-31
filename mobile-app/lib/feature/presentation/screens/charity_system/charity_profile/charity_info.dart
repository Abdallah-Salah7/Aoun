import 'package:flutter/material.dart';

class CharityInformationScreen extends StatefulWidget {
  const CharityInformationScreen({super.key});

  @override
  State<CharityInformationScreen> createState() =>
      _CharityInformationScreenState();
}

class _CharityInformationScreenState extends State<CharityInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void saveChanges() {
    print("Name: ${nameController.text}");
    print("Email: ${emailController.text}");
    print("Address: ${addressController.text}");
    print("Description: ${descriptionController.text}");

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("تم حفظ التغييرات")));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color(0xFFD9DDDA),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * .05,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Header(),

                  SizedBox(height: size.height * .03),

                  const LogoUploadCard(),

                  const SizedBox(height: 12),

                  CharityTextField(
                    title: "اسم الجمعية",
                    controller: nameController,
                  ),

                  const SizedBox(height: 12),

                  CharityTextField(
                    title: "البريد الإلكتروني",
                    controller: emailController,
                  ),

                  const SizedBox(height: 12),

                  CharityTextField(
                    title: "العنوان",
                    controller: addressController,
                  ),

                  const SizedBox(height: 12),

                  CharityCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "نبذة عن الجمعية",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: descriptionController,
                          maxLines: 7,
                          minLines: 5,
                          textAlign: TextAlign.right,
                          textDirection: TextDirection.rtl,
                          decoration: InputDecoration(
                            hintText: "أدخل نبذة عن الجمعية",
                            hintStyle: TextStyle(color: Colors.grey.shade500),
                            filled: true,
                            fillColor: const Color(0xffE5E7EB),
                            // contentPadding: EdgeInsets.symmetric(
                            //   horizontal: 18,
                            //   vertical: 1 > 1 ? 18 : 14,
                            // ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: const BorderSide(
                                color: Color(0xff2E6B50),
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  SaveButton(onPressed: saveChanges),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 40),
        const Text(
          "معلومات الجمعية",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Spacer(),

        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}

class CharityCard extends StatelessWidget {
  final Widget child;

  const CharityCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(padding: const EdgeInsets.all(18), child: child),
    );
  }
}

class CharityTextField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final int maxLines;

  const CharityTextField({
    super.key,
    required this.title,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return CharityCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 40,
            child: TextFormField(
              controller: controller,
              maxLines: maxLines,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              decoration: InputDecoration(
                hintText: "أدخل $title",
                hintStyle: TextStyle(color: Colors.grey.shade500),
                filled: true,
                fillColor: const Color(0xffE5E7EB),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: maxLines > 1 ? 18 : 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xff2E6B50),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LogoUploadCard extends StatelessWidget {
  const LogoUploadCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CharityCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            "شعار الجمعية",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.upload_file),
                iconAlignment: IconAlignment.end,
                label: const Text(
                  "تحميل شعار جديد",
                  style: TextStyle(fontSize: 12),
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xffECFDF5),
                  foregroundColor: const Color(0xff007A55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),

              const SizedBox(width: 1),

              const CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage("assets/images/غيث 1.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.save),
        iconAlignment: IconAlignment.end,
        label: const Text(
          "حفظ التغييرات",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: const Color(0xff2E6B50),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
    );
  }
}
