
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_svg/svg.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:track_expenses/consts/colors/app_colors.dart';
import 'package:track_expenses/gen/assets.gen.dart';
import 'package:track_expenses/models/expense_model.dart';
import 'package:track_expenses/providers/new_entry.dart';
import 'package:track_expenses/screens/full_sccreen_image.dart';
import 'package:track_expenses/widgets/category.dart';
import 'package:track_expenses/widgets/expense_income.dart';
import 'package:track_expenses/widgets/new_entry_text_field.dart';

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({super.key});

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  final TextEditingController _notecontroller = TextEditingController();
  final TextEditingController _valuecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NewEntry(),
      child: Builder(
        builder: (context) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                title: Padding(
                  padding: const EdgeInsets.only(left: 5, right: 15),
                  child: FadeInDown(
                    delay: Duration(milliseconds: 00),
                    duration: Duration(milliseconds: 800),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Hero(
                            tag: 'plus1',
                            child: SvgPicture.asset(Assets.icons.close),
                          ),
                        ),
                        Spacer(),
                        SizedBox(width: 25),
                        Text(
                          'New Entry',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            final newEntry = context.read<NewEntry>();
                            final isIncome = newEntry.selectedindex2 == 1;
                            final rawValue =
                                double.tryParse(_valuecontroller.text) ?? 0;
                            final signedValue = isIncome ? rawValue : -rawValue;

                            newEntry.sendincome(
                              expense: ExpenseModel(
                                image: newEntry.photo?.path,
                                id: 0,
                                value: signedValue,
                                income: isIncome,
                                type: ExpenseCategory
                                    .values[newEntry.selectedindex],
                                note: _notecontroller.text,
                              ),
                              onError: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Error')),
                                );
                              },
                              onSuccess: () {
                                Navigator.pop(context);
                              },
                            );
                          },
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(height: 48),
                        FadeIn(
                          delay: Duration(milliseconds: 200),
                          duration: Duration(milliseconds: 800),
                          child: Text(
                            'TOTAL BALANCE',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.grey,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: FadeIn(
                            delay: Duration(milliseconds: 400),
                            duration: Duration(milliseconds: 800),
                            child: ZoomIn(
                              delay: Duration(milliseconds: 400),
                              duration: Duration(milliseconds: 800),
                              child: NewEntryTextField(
                                controller: _valuecontroller,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 48),
                        FadeIn(
                          delay: Duration(milliseconds: 600),
                          duration: Duration(milliseconds: 800),
                          child: ZoomIn(
                            delay: Duration(milliseconds: 600),
                            duration: Duration(milliseconds: 800),
                            child: ExpenseIncome(),
                          ),
                        ),
                        SizedBox(height: 25),
                        FadeIn(
                          delay: Duration(milliseconds: 600),
                          duration: Duration(milliseconds: 800),
                          child: ZoomIn(
                            delay: Duration(milliseconds: 600),
                            duration: Duration(milliseconds: 800),
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text('Insert file from:'),
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            context
                                                .read<NewEntry>()
                                                .pickImageFromCamera(
                                                  onSuccess: () {
                                                    Navigator.pop(context);
                                                  },
                                                );
                                          },
                                          child: Text('Camera'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context
                                                .read<NewEntry>()
                                                .pickFileFromFolder(
                                                  onSuccess: () =>
                                                      Navigator.pop(context),
                                                );
                                          },
                                          child: Text('Files'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            context
                                                .read<NewEntry>()
                                                .pickImageFromGallery(
                                                  onSuccess: () =>
                                                      Navigator.pop(context),
                                                );
                                          },
                                          child: Text('Gallery'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.lgrey,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Insert File',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Builder(
                          builder: (context) {
                            final photo = context.watch<NewEntry>().photo;
                            final isImage = context
                                .watch<NewEntry>()
                                .isPhotoImage;
                            final isMusic = context
                                .watch<NewEntry>()
                                .isPhotoMusic;
                            if (photo == null) {
                              return SizedBox();
                            }

                            if (isImage) {
                              return SizedBox(
                                height: 150,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FullSccreenImage(rasm: photo),
                                        ),
                                      );
                                    },
                                    child: Hero(
                                      tag: 'rasm1',
                                      child: Image.file(
                                        photo,
                                        height: 150,
                                        width: 200,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            } else if (isMusic) {
                              return InkWell(
                                onTap: () {
                                  OpenFile.open(photo.path);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: ListTile(
                                      leading: const Icon(Icons.music_note),
                                      title: Text(path.basename(photo.path)),
                                      subtitle: const Text('Audio file'),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return InkWell(
                                onTap: () {
                                  OpenFile.open(photo.path);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Card(
                                    child: ListTile(
                                      leading: Icon(Icons.insert_drive_file),
                                      title: Text(path.basename(photo.path)),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 28),
                        Row(
                          children: [
                            FadeIn(
                              delay: Duration(milliseconds: 600),
                              duration: Duration(milliseconds: 800),
                              child: Text(
                                'CATEGORY',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        FadeIn(
                          delay: Duration(milliseconds: 600),
                          duration: Duration(milliseconds: 800),
                          child: Divider(color: AppColors.lgrey),
                        ),
                        SizedBox(height: 16),
                        Category(),
                        SizedBox(height: 52),
                        FadeIn(
                          delay: Duration(milliseconds: 1300),
                          duration: Duration(milliseconds: 800),
                          child: ZoomInDown(
                            delay: Duration(milliseconds: 1500),
                            duration: Duration(milliseconds: 800),
                            child: TextField(
                              controller: _notecontroller,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                              decoration: InputDecoration(
                                hintText: 'ADD NOTE...',
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.grey,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        FadeIn(
                          delay: Duration(milliseconds: 1500),
                          duration: Duration(milliseconds: 800),
                          child: Divider(color: AppColors.lgrey),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
