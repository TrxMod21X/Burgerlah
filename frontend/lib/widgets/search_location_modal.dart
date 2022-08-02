part of 'widgets.dart';

class SearchLocationModal extends StatelessWidget {
  final GoogleMapController mapController;
  const SearchLocationModal({Key? key, required this.mapController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController _textController = TextEditingController();
    return Container(
      padding: EdgeInsets.all(Dimensions.width15),
      alignment: Alignment.topCenter,
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Dimensions.radius20 / 2),
        ),
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: TypeAheadField(
            textFieldConfiguration: TextFieldConfiguration(
              controller: _textController,
              textInputAction: TextInputAction.search,
              autofocus: true,
              textCapitalization: TextCapitalization.words,
              keyboardType: TextInputType.streetAddress,
              decoration: InputDecoration(
                hintText: 'Search Location',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius10),
                  borderSide: const BorderSide(
                    style: BorderStyle.none,
                    width: 0,
                  ),
                ),
                hintStyle: Theme.of(context).textTheme.headline2?.copyWith(
                      color: Theme.of(context).disabledColor,
                      fontSize: Dimensions.font16,
                    ),
              ),
            ),
            onSuggestionSelected: (suggestion) {},
            suggestionsCallback: (pattern) async {
              return await Get.find<LocationController>()
                  .searchLocation(context, pattern);
            },
            itemBuilder: (BuildContext context, SuggestionModel suggestion) {
              return Padding(
                padding: EdgeInsets.all(Dimensions.width10),
                child: Row(
                  children: [
                    const Icon(Icons.location_on),
                    Expanded(
                      child: Text(
                        suggestion.label ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline2?.copyWith(
                              color:
                                  Theme.of(context).textTheme.bodyText1?.color,
                              fontSize: Dimensions.font16,
                            ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
