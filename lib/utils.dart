const baseURL = 'http://newxiuren.com/uploadfiles/';
const pageSize = 24;

String getYearFromId(int id) {
  return id.toString().substring(0, 4);
}

String getCoverURL(int id, String prefix) {
  return '$baseURL/$prefix/${getYearFromId(id)}/$id/cover.jpg';
}
