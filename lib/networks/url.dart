class ApiUrl {
  static String provinces = "https://open-api.my.id/api/wilayah/provinces";
  static String hotels({required double lat, required double long}) {
    return "https://api.geoapify.com/v2/places?categories=accommodation.hotel&filter=circle:$long,$lat,50000&bias=proximity:$long,$lat&limit=20&apiKey=56eaf10623e24057b8030629821ca81b";
  }
}
