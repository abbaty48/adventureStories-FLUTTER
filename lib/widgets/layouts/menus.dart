import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:adventure_stories/widgets/skeleton.dart';
import 'package:adventure_stories/models/event_model.dart';
import 'package:adventure_stories/recoils/atoms/recoil_atoms.dart';
import 'package:adventure_stories/commons/generic_scroll_behavior.dart';

class MenuBar extends RecoilWidget {
  const MenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    var selectedItem = useRecoilState(selectedMenuItemAtom);
    // get available genres from api-server
    return Query(
        options: QueryOptions(document: gql('''  
          query Events {
              events {
                name
            }
          } 
       ''')),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException) {
            // return a loading
            print('Error while getting genres: ${result.toString()}');
            return const MenuShimmerEffect();
          }

          if (result.isLoading) {
            // return a loader
            return const MenuShimmerEffect();
          }

          List? events = result.data?['events'];
          if (events == null) {
            // return a skimmer
            print('Empty Events');
            return const MenuShimmerEffect();
          }
          // set the first event as the selected menu-item
          selectedItem.setData(selectedItem.data ?? events[0]?['name']);
          //
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: ScrollConfiguration(
                      behavior: GenericScrollBehavior(),
                      child: ListView.builder(
                          itemCount: events.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            Event event = Event.toEvent(events[index]);
                            return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 4),
                                child: TextButton(
                                    onPressed: () =>
                                        selectedItem.setData(event.name),
                                    child: Text(event.name!,
                                        style: TextStyle(
                                            fontWeight:
                                                selectedItem.data == event.name
                                                    ? FontWeight.w700
                                                    : FontWeight.w300,
                                            decorationStyle:
                                                selectedItem.data == event.name
                                                    ? TextDecorationStyle.solid
                                                    : null,
                                            decoration:
                                                selectedItem.data == event.name
                                                    ? TextDecoration.underline
                                                    : null,
                                            decorationColor: Theme.of(context)
                                                .textTheme
                                                .overline!
                                                .decorationColor,
                                            color: selectedItem.data == event.name
                                                ? Theme.of(context)
                                                    .highlightColor
                                                : Theme.of(context)
                                                    .secondaryHeaderColor))));
                          }))));
        });
  }
}

class MenuShimmerEffect extends StatelessWidget {
  const MenuShimmerEffect({super.key});

  @override
  Widget build(BuildContext context) {
    double itemWidth = MediaQuery.of(context).size.width / 15;
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 10,
        child: ListView.builder(
            itemCount: 15,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Skeleton(
                    height: 10,
                    width: itemWidth,
                    color: Theme.of(context).hintColor))));
  }
}
