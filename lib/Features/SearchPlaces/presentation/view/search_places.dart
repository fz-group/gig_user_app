import 'package:get/get.dart';
import 'package:gic_client/Features/Home/presentation/Manager/home_controller.dart';
import 'package:gic_client/Features/SearchPlaces/controllers/search_places_controller.dart';
import 'package:gic_client/Features/SearchPlaces/data/models/pred.dart';
import 'package:gic_client/Features/SearchPlaces/presentation/view/select_area.dart';
import 'package:gic_client/Features/SearchPlaces/presentation/view/user_address.dart';
import 'package:gic_client/core/widgets/Custom_Text.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/resources/color_manager.dart';
import '../../../../core/widgets/Custom_button.dart';

class SearchPlacesView extends StatefulWidget
{

  const SearchPlacesView({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SearchPlacesScreenState createState() => _SearchPlacesScreenState();
}

TextEditingController searchController=TextEditingController();

PredictedPlaces? predValue;


class _SearchPlacesScreenState extends State<SearchPlacesView>
{

  List<PredictedPlaces> placesPredictedList = [];

  String mapKey='AIzaSyCKckCh7RP4ezDtY4F2m5CEV0Y8tfntDFk';

SearchPlacesController searchPlacesController =Get.put(SearchPlacesController());


      nextFunction()async{

         searchPlacesController
             .getPlaceCoordinates(predValue!.main_text.toString(),
         mapKey
         );

        searchPlacesController. getZipCode(
            searchPlacesController.newLat,
            searchPlacesController.newLng,
            mapKey
        ).then((v){
          searchPlacesController.getCity(
              searchPlacesController.newLat
              ,  searchPlacesController.newLng,
              mapKey);

 searchPlacesController.getPlaceState(
     searchPlacesController.newLat
     , searchPlacesController.newLng,
              mapKey);
              
          Future.delayed(const Duration(seconds: 1)).then((v){

            List stateList= predValue!.secondary_text.toString().split(',');

            searchPlacesController.addAdress(predValue!,
                searchPlacesController.newLat,
                searchPlacesController.newCity,
                stateList[0],
                //searchPlacesController.newState,
                searchPlacesController.newLng,
                searchPlacesController.placeZipCode,
              predValue!
            );
            Future.delayed(const Duration(seconds: 2)).then((v){
              print("DATA==="+searchPlacesController.newLat.toString());
              print("DATA==="+searchPlacesController.newLng.toString());
              print("DATA==="+searchPlacesController.placeZipCode.toString());
              print("DATA==="+searchPlacesController.newCity.toString());
              print("DATA==="+searchPlacesController.newState.toString());

            });



          });


        });


      }


@override
  void dispose() {

   //searchController.dispose();
   searchController.text='';

    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: ColorManager.backColor,
      appBar: AppBar(
        backgroundColor: ColorManager.primary,
        toolbarHeight: 65,
        elevation: 0.2,
        title:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Custom_Text(text: 'Enter Your Address',
          fontSize: 26,color:ColorManager.textColorLight,
             fontWeight:FontWeight.w500,
          ),
        ),
        leading:IconButton(
          onPressed:(){
            Get.back();
          },
          icon: Icon(Icons.arrow_back_ios
              ,size: 27,color:ColorManager.textColorLight),
        ),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(
          text: 'Next',
          onPressed: () {
            nextFunction();
 },
          color1:ColorManager.primary,
          color2: ColorManager.backColor,
        ),
      ),
      body: Column(
        children: [
          //search place ui
          Container(
            height: 90,
            decoration:  BoxDecoration(
              color: ColorManager.backColor,
              boxShadow:
              const [
                BoxShadow(
                  color: Colors.white54,
                  blurRadius: 8,
                  spreadRadius: 0.5,
                  offset: Offset(
                    0.7,
                    0.7,
                  ),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [

                  Row(
                    children: [
                       Icon(
                        Icons.adjust_sharp,
                        color: ColorManager.primary,
                      ),

                      const SizedBox(width: 18.0,),
                    //  Expanded(
                        //child:
                         Container(
                          width: 320,
                          decoration:BoxDecoration(
                            border:Border.all(color:ColorManager.textColorDark)
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            controller: searchController,

                            onChanged: (valueTyped)
                            {
                              print("CHABGE");
                              findPlaceAutoCompleteSearch(valueTyped);
                            },
                            decoration:  InputDecoration(
                              hintText: "Search Here .. ",
                              fillColor: ColorManager.textColorLight,
                              filled: true,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.only(
                                left: 11.0,
                                top: 8.0,
                                bottom: 8.0,
                              ),
                            ),
                          ),
                        ),
                     // ),

                    ],
                  ),
                ],
              ),
            ),
          ),
       
          //display place predictions result
          (placesPredictedList.isNotEmpty)
              ? Expanded(
            child:
             SizedBox(
              height: 250,
               child: ListView.separated(
                itemCount: placesPredictedList.length,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index)
                {
                  return PlacePredictionTileDesign(
                    predictedPlaces: placesPredictedList[index],
                  );
                },
                separatorBuilder: (BuildContext context, int index)
                {
                  return const Divider(
                    height: 1,
                    color: Colors.black,
                    thickness: 1,
                  );
                },
                         ),
             ),
          )
              : Container(),


        ],
      ),
    );
  }
  void findPlaceAutoCompleteSearch(String inputText) async
  {
    print("sssXXXXXXssss...................");
    if(inputText.isNotEmpty) //2 or more than 2 input characters
        {
      String urlAutoCompleteSearch = 
      "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$mapKey&components=country:US";
      var responseAutoCompleteSearch = await receiveRequest(urlAutoCompleteSearch);
      if(responseAutoCompleteSearch == "Error Occurred, Failed. No Response.")
      {
        print("ERRRORRRR");
        return;
      }
      if(responseAutoCompleteSearch["status"] == "OK")
      {
        print("OK");
        var placePredictions = responseAutoCompleteSearch["predictions"];

        print("PLACE===="+placePredictions.toString());
        var placePredictionsList = (placePredictions as List)
        .map((jsonData) => PredictedPlaces.fromJson(jsonData)).toList();

        setState(() {
          placesPredictedList = placePredictionsList;
        });
      
      }else{}
      print("ELSE");
      print(responseAutoCompleteSearch["status"]);
    }
  }


  static Future<dynamic> receiveRequest(String url) async
  {
    http.Response httpResponse = await http.get(Uri.parse(url));

    try
    {
      if(httpResponse.statusCode == 200) //successful
          {
        String responseData = httpResponse.body; //json

        var decodeResponseData = jsonDecode(responseData);

        return decodeResponseData;
      }
      else
      {
        return "Error Occurred, Failed. No Response.";
      }
    }
    catch(exp)
    {
      return "Error Occurred, Failed. No Response.";
    }
  }
  final controller=Get.put(HomeController());
}


class PlacePredictionTileDesign extends StatelessWidget
{
  final controller=Get.put(HomeController());
  final PredictedPlaces? predictedPlaces;

  PlacePredictionTileDesign({super.key, this.predictedPlaces});

  @override
  Widget build(BuildContext context)
  {
    
    return ElevatedButton(
     
      onPressed: ()
      {

        searchController.text= predictedPlaces!.main_text!;
      
        predValue=predictedPlaces;

        controller.getLatLng(predictedPlaces!.main_text!);

      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.textColorLight,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
         Icon(
              Icons.add_location,
              color: ColorManager.primary,
            ),
            const SizedBox(width: 14.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0,),
                  Text(
                    predictedPlaces!.main_text!,
                    overflow: TextOverflow.ellipsis,
                    style:  TextStyle(
                      fontSize: 16.0,
                      color: ColorManager.textColorDark,
                    ),
                  ),
                  const SizedBox(height: 2.0,),
                  Text(
                    predictedPlaces!.secondary_text!,
                    overflow: TextOverflow.ellipsis,
                    style:  const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8.0,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}