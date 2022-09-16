import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp20220914/controller/travelController.dart';
import 'package:myapp20220914/theme/theme.dart';
import 'package:myapp20220914/view/components/sliverList.dart';

import 'package:provider/provider.dart';

class Travel extends StatelessWidget {
  const Travel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        titleSpacing: 15.0,
        // Left of AppBar the Avatar and Titles.
        // listener to scroller is Top. if isn't Top that show AppTopAvatar
        title: Consumer<TravelController>(
          builder: ((context, controller, child) => controller.isTop == false
              ? InkWell(
                  onTap: () {
                    openBottomSheet(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      CircleAvatar(
                        child: Icon(Icons.people),
                      ),
                      SizedBox(
                        width: 5.0,
                        height: 5.0,
                      ),
                      Text("YuWay"),
                    ],
                  ),
                )
              : Container()),
        ),
        // Right of AppBar the IconButtons.
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
          const SizedBox(
            width: 15.0,
            height: 5.0,
          ),
        ],
      ),
      body: const ScrollListView(),
    );
  }
}

class ScrollListView extends StatefulWidget {
  const ScrollListView({Key? key}) : super(key: key);
  @override
  State<ScrollListView> createState() => _ScrollListViewState();
}

class _ScrollListViewState extends State<ScrollListView> {
  final _scrollController = ScrollController();
  final _controller = TextEditingController();
  final double listTitleHeight = 30.0;
  final double searchTextHeight = 60.0;
  final appTheme = AppTheme();
  String searchText = "";
  double offset = 0;
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      searchText = _controller.text;
    });

    // Listener scroller action
    _scrollController.addListener(
      () {
        offset = _scrollController.offset;
        offset > 120.0
            ? context.read<TravelController>().setIsTop(false)
            : context.read<TravelController>().setIsTop(true);
      },
    );
  }

  @override
  void dispose() {
    //避免内存泄露，需要調用controller.dispose
    _scrollController.dispose();
    _scrollController.removeListener(() {});
    _controller.dispose();
    _controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final travelProvier = Provider.of<TravelController>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    // RefreshIndicator 是列表置頂後向下拉動會執行Loading
    return RefreshIndicator(
      displacement: (size.height / 2) - (listTitleHeight + searchTextHeight),
      onRefresh: travelProvier.getTravelData,
      // ScrollView
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ListTitle
          SliverToBoxAdapter(
            child: InkWell(
              onTap: () => openBottomSheet(context),
              child: ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.people),
                ),
                tileColor: Theme.of(context).backgroundColor,
                title: Text(
                  "YuWay",
                  style: TextStyle(fontSize: 20.0, color: appTheme.colorWhite),
                ),
                subtitle: Text(
                  "keep",
                  style: TextStyle(fontSize: 15.0, color: appTheme.colorWhite),
                ),
              ),
            ),
          ),
          // SearchText
          SliverAppBar(
            floating: true,
            pinned: false,
            backgroundColor: Colors.black,
            expandedHeight: 60.0,
            // stretchTriggerOffset: 100.0,
            stretch: true,
            excludeHeaderSemantics: false,
            // onStretchTrigger: onStretchTriggerOffset,
            title: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              height: 34,
              decoration: BoxDecoration(
                color:
                    const Color.fromARGB(78, 82, 82, 82), // Box-BackgroundColor
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    // Search Text style
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.white), // font color
                      cursorColor: Colors.white,
                      // 觸發搜尋功能 邏輯在provider內。
                      onChanged: ((value) => travelProvier.onSearch(value)),
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Search",
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    splashColor: Colors.black,
                    highlightColor: Colors.black,
                    onPressed: (() {}),
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 24.0,
                    ),
                  )
                ],
              ),
            ),
            flexibleSpace: const FlexibleSpaceBar(),
          ),
          // ListView Build
          CustomSliverList(offset: offset),
        ],
      ),
    );
  }
}

// Avatar trigger BottomSheet
void openBottomSheet(context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return DraggableScrollableSheet(
        snap: true,
        initialChildSize: 0.9,
        minChildSize: 0.9,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) => SafeArea(
          child: Center(
              child: ElevatedButton.icon(
                  onPressed: (() => FirebaseAuth.instance.signOut()),
                  icon: const Icon(Icons.arrow_back),
                  label: const Text("Sign Out"))),
        ),
      );
    },
  );
}





// // 另一種列表搜尋方式
// class MySearchDelegate extends SearchDelegate {
//   @override
//   List<Widget>? buildActions(BuildContext context) {
//     return [
//       IconButton(
//         onPressed: (() {
//           query = '';
//         }),
//         icon: const Icon(Icons.clear),
//       ),
//     ];
//   }

//   @override
//   Widget? buildLeading(BuildContext context) {
//     return IconButton(
//       onPressed: (() => close(context, null)),
//       icon: const Icon(Icons.arrow_back),
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     final list = Provider.of<TravelController>(context).travelList;

//     return ListView();
//   }
// }
