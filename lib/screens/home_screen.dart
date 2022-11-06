import 'package:black_n_brown/constants/constants.dart';
import 'package:black_n_brown/providers/Items.dart';
import 'package:black_n_brown/providers/categories.dart';
import 'package:black_n_brown/screens/user_profile_screen.dart';
import 'package:black_n_brown/widgets/item_widget.dart';
import 'package:black_n_brown/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user.dart' as userProvider;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategoryId = 'c1';
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<Categories>(context).getAllCategories;
    final categoryItems =
        Provider.of<Items>(context).getItemsByCategoryId(_selectedCategoryId);
    final user = Provider.of<userProvider.User>(context).getCurrentUser;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ' Welcome ${user.userName.trim()}',
                    style: kTitleMedium,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: kWhite,
                      border: Border.all(
                        color: kPrimaryColor,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: GestureDetector(
                      child: Image.asset(
                        'assets/images/default_user_icon.png',
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(UserProfileScreen.routeName);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.66,
                    height: MediaQuery.of(context).size.height * 0.1,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Form(
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon:
                              const Icon(Icons.search, color: kPrimaryColor),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          hintText: 'search for items here...',
                          hintStyle: kTitleSmall.copyWith(
                            fontWeight: FontWeight.w100,
                            color: kContainerBorderColor,
                          ),
                          fillColor: kSecondaryColor,
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: kPrimaryColor,
                              width: 1,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: kPrimaryColor,
                              width: 1,
                            ),
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: kPrimaryColor,
                        width: 2,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.sort,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              margin: const EdgeInsets.only(left: 26),
              child: const Text(
                'Categories',
                style: kTitleMedium,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              child: Row(
                children: [
                  Container(
                    width: 26,
                    color: Colors.transparent,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.13,
                    margin: const EdgeInsets.only(top: 20),
                    child: Row(
                      children: categories
                          .map((category) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedCategoryId = category.id;
                                  });
                                },
                                child: CategoryItem(
                                  category: category,
                                  selectedCategoryId: _selectedCategoryId,
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   alignment: Alignment.centerRight,
            //   padding: const EdgeInsets.only(right: 26),
            //   child: TextButton(
            //     child: Text(
            //       'View all',
            //       style: kTitleSmall.copyWith(color: kPrimaryColor),
            //     ),
            //     onPressed: () {},
            //   ),
            // ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.1 / 3.2,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 20,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: categoryItems.length,
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: categoryItems[index],
                  child: ItemWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
