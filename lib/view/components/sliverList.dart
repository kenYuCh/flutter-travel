import 'package:flutter/material.dart';
import 'package:myapp20220914/controller/travelController.dart';
import 'package:myapp20220914/model/travelModel.dart';
import 'package:myapp20220914/theme/theme.dart';
import 'package:myapp20220914/view/googleMapView.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

// ScrollView List
class CustomSliverList extends StatelessWidget {
  const CustomSliverList({Key? key, required this.offset}) : super(key: key);
  final double offset;
  // call phone
  void callPhone(String phone) async {
    final String url = 'tel:+${phone}';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  void favoriteAdd(TravelController travelProvider, index) {
    final jsonData = travelProvider.travelList[index].toJson();
    TravelModel itemId = TravelModel.fromJson(jsonData);
    travelProvider.setAdd(itemId);
  }

// bottom Sheet on GoogleMapView
  void onBtnpressedSheet(context, TravelModel items) {
    print("sheet.");
    showModalBottomSheet(
      enableDrag: false,
      // isDismissible: false,
      isScrollControlled: true,
      context: context,
      builder: ((context) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          child: GoogleMapView(items: items),
        );
      }),
    );
  }

  // final List<int> items;
  @override
  Widget build(BuildContext context) {
    AppTheme apptheme = AppTheme();
    return Consumer<TravelController>(
      builder: ((_, travelProvider, child) => SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: travelProvider.travelSearchResult.length,
              addAutomaticKeepAlives: true,
              // semanticIndexOffset: 0,
              // findChildIndexCallback: (Key key) {
              //   final valueKey = key as ValueKey;
              //   final index =
              //       items.indexWhere((item) => item == valueKey.value);
              //   if (index == -1) return null;
              //   return index;
              // },
              (context, index) {
                // print(offset);
                // print(index);
                // final item = items[index];
                return Card(
                  // key: Key('UniqueString'),
                  child: Column(
                    children: [
                      // Card of Top Leading Icons
                      ListTile(
                        leading: CircleAvatar(
                          child: Text(
                            "${index}",
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          // minRadius: 15.0,
                          // maxRadius: 15.0,
                        ),
                        trailing: const Icon(Icons.menu_book_sharp),
                        title: Text(
                          "${travelProvider.travelSearchResult[index].scenicSpotName}",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      // Card Image
                      Container(
                        height: 250.0,
                        child: Image.network(
                          "${travelProvider.travelSearchResult[index].picture!.pictureUrl1}",
                          scale: 1.8,
                        ),
                      ),
                      // Card Favorite Icons
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    final jsonData = travelProvider
                                        .travelList[index]
                                        .toJson();
                                    TravelModel itemId =
                                        TravelModel.fromJson(jsonData);
                                    Provider.of<TravelController>(context,
                                            listen: false)
                                        .setAdd(itemId);
                                  },
                                  icon: const Icon(Icons.favorite_border),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.location_on),
                                  onPressed: (() => onBtnpressedSheet(
                                        context,
                                        travelProvider
                                            .travelSearchResult[index],
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Card Detail
                      ExpansionTile(
                        collapsedTextColor: apptheme.colorWhite,
                        textColor: apptheme.colorWhite,
                        iconColor: apptheme.colorWhite, // open state
                        collapsedIconColor: apptheme.colorWhite,
                        collapsedBackgroundColor: apptheme.colorBlack,
                        leading: const Icon(Icons.menu_book_sharp),
                        title: Text(
                            '${travelProvider.travelSearchResult[index].scenicSpotName}'),
                        subtitle: Text(
                          '${travelProvider.travelSearchResult[index].city}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        // trailing: const Text("21km"),
                        children: [
                          ListTile(
                            title: const Text("｜描述："),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                '${travelProvider.travelSearchResult[index].descriptionDetail}',
                              ),
                            ),
                          ),
                          ListTile(
                            title: Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  size: apptheme.iconsSize15,
                                ),
                                const Text(
                                  "｜電話：",
                                )
                              ],
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: InkWell(
                                onTap: () => callPhone(
                                    "${travelProvider.travelSearchResult[index].phone}"),
                                child: Text(
                                  '${travelProvider.travelSearchResult[index].phone}',
                                ),
                              ),
                            ),
                          ),
                          ListTile(
                            title: const Text(
                              "｜開放時間：",
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                  "${travelProvider.travelSearchResult[index].openTime}"),
                            ),
                          ),
                          ListTile(
                            title: const Text(
                              "｜GoogleMap：",
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: InkWell(
                                onTap: () {
                                  onBtnpressedSheet(context,
                                      travelProvider.travelSearchResult[index]);
                                },
                                child: Text(
                                  '${travelProvider.travelSearchResult[index].city}',
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          )),
    );
  }
}

// class MyWidget extends StatelessWidget {
//   const MyWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       slivers: [
//         SliverList(
//           delegate: SliverChildBuilderDelegate(
//             findChildIndexCallback: (Key key) {
//               final valueKey = key as ValueKey;
//               final index = items.indexWhere((item) => item == valueKey.value);
//               if (index == -1) return null;
//               return index;
//             },
//             childCount: 20,
//             (context, index) {
//               return Container();
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
