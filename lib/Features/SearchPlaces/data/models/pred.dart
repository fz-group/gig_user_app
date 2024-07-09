
class PredictedPlaces
{
  String? place_id;
  String? main_text;
  String? secondary_text;
  String ?address;
//   String ?lat;
  //double ?lng;

  PredictedPlaces({
    this.place_id,
    this.main_text,
    this.address,
    this.secondary_text,
  });

  PredictedPlaces.fromJson(Map<String, dynamic> jsonData)
  {
    place_id = jsonData["place_id"];
    address = jsonData["formatted_address"];
    main_text = jsonData["structured_formatting"]["main_text"];
    secondary_text = jsonData["structured_formatting"]["secondary_text"];
   //  lat=jsonData["structured_formatting"].toString();
  }
}