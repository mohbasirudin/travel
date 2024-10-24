class ApiUrl {
  static String provinces = "https://open-api.my.id/api/wilayah/provinces";
  static String hotels({required double lat, required double long}) {
    return "https://api.geoapify.com/v2/places?categories=accommodation.hotel&filter=circle:$lat,$long,5000&bias=proximity:113.7041657,-8.1713552&limit=20&apiKey=56eaf10623e24057b8030629821ca81b";
  }
}
