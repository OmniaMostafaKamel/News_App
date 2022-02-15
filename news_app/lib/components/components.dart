import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:news_app/cubit/cubit.dart';

import 'package:news_app/cubit/cubit_newsapp.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

void navigateTo(context, Widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Widget,
      ),
    );
Widget buildArticle(context, list, {isSearch = false}) => Conditional.single(
    context: context,
    conditionBuilder: (context) => list.length > 0,
    widgetBuilder: (context) => ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              buildArticleItem(list[index], context),
          separatorBuilder: (context, index) => MyDivider(),
          itemCount: list.length,
        ),
    fallbackBuilder: (context) => isSearch
        ? Container()
        : Center(
            child: CircularProgressIndicator(),
          ));

Widget defaultFormFild({
  required TextEditingController? controller,
  required TextInputType? type,
  final String? Function(String?)? validate,
  Function()? onTap,
  Function(String)? onChange,
  required String? label,
  bool isClickable = true,
  required IconData? prefix,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validate,
      onChanged: onChange,
      onTap: onTap,
      enabled: isClickable,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(),
      ),
    );

Widget MyDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        navigateTo(
          context,
          WebViewScreen(article['url']),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            //  the container is for Image only

            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(
              width: 20.0,
            ),

            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
