import 'package:belah_duren/api/api_autocomplete_places.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class AddressSearch extends SearchDelegate<String> {
  final sessionToken;

  AddressSearch(this.sessionToken);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        tooltip: 'Clear',
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      // We will put the api call here
      future: futureApiAutocompletePlace(query, sessionToken),
      builder: (context, snapshot) =>
      query == '' ?
      Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Masukkan Alamat'),
      ) : snapshot.hasData ?
      ListView.builder(
        itemBuilder: (context, index) =>
            Card(
              child: ListTile(
                title: Text(getDescription(snapshot.data, index)),
                onTap: () {
                  close(context, getDescription(snapshot.data, index));
                },
              ),
            ),
        itemCount: getLength(snapshot.data),
      )
          : Container(
        padding: EdgeInsets.all(16.0),
        child: Text('Mencari ...'),
      ),
    );
  }

  String getDescription(ApiPlace apiPlace, int index){
    return apiPlace.predictions[index].description;
  }

  int getLength(ApiPlace apiPlace){
    return apiPlace.predictions.length;
  }

}

Future<LatLng> getLatlng(address) async {
  List<Address> addresses = await Geocoder.local.findAddressesFromQuery(address);
  if(addresses.length > 0 ){
    return new LatLng(addresses.first.coordinates.latitude, addresses.first.coordinates.longitude);
  } else return null;
}