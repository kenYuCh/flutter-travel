import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import 'package:myapp20220914/controller/travelController.dart';
import 'package:myapp20220914/model/travelModel.dart';
import 'package:myapp20220914/theme/theme.dart';
import 'package:myapp20220914/view/googleMapView.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TravelFavorite extends StatelessWidget {
  const TravelFavorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final travelProvider = Provider.of<TravelController>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0.0,
        titleSpacing: 15.0,
        title: Text("Favorite"),
        actions: [
          Consumer<TravelController>(
              // 取得最愛資料筆數
              builder: ((_, travelprovider, child) => Badge(
                    position: BadgePosition.topEnd(top: 4, end: 4),
                    badgeContent:
                        Text("${travelprovider.travelFavorite.length}"),
                    child: Icon(Icons.messenger),
                  ))),
          const SizedBox(
            width: 15.0,
            height: 5.0,
          ),
        ],
      ),
      // body: Body(),
      body: FavoriteListView(travelProvider),
    );
  }
}

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

Widget FavoriteListView(travelProviderB) {
  AppTheme apptheme = AppTheme();
  return CustomScrollView(
    slivers: [
      Consumer<TravelController>(
        builder: ((_, travelProvider, child) => SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: travelProvider.travelFavorite.length,
                (context, index) {
                  // print(index);
                  return Card(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () =>
                                        favoriteAdd(travelProvider, index),
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
                                    onBtnpressedSheet(
                                        context,
                                        travelProvider
                                            .travelSearchResult[index]);
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
      )
    ],
  );
}
