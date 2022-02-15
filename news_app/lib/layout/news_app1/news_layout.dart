import 'package:flutter/material.dart';
import 'package:news_app/components/components.dart';
import 'package:news_app/cubit/cubit.dart';

import 'package:news_app/cubit/states_newsapp.dart';
import 'package:news_app/cubit/cubit_newsapp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/modules/search/search_screen.dart';

class NewsLayoutss extends StatelessWidget {
  const NewsLayoutss({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                onPressed: () {
                  navigateTo(
                    context,
                    SearchScreen(),
                  );
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
                icon: Icon(Icons.brightness_4_outlined),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            items: cubit.bottomItems,
            currentIndex: cubit.currentindex,
            onTap: (index) {
              cubit.changeNavBar(index);
            },
          ),
        );
      },
    );
  }
}
