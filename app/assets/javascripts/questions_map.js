var map;
var marker = [];
var data = [];
var windows =[];
var currentInfoWindow = null;

function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 35.0258, lng: 135.761},
    zoom: 14
  });

  if ($('.question-block').length) {
    $.ajax({
      type: 'GET',
      url: '/questions.json'
    }).done(function(json) {
      for (var i = 0; i <= json.length-1; i++) {
        data.push(
          {'question_id' : json[i].id, 'lat' : json[i].lat, 'lng' : json[i].lng}
        );
      }
      for (var i = 0; i < data.length; i++) {
        if (data[i]['lat'] && data[i]['lng']) {
          var markerLatLng = {lat: data[i]['lat'], lng: data[i]['lng']};
          var contentString = '<a href="/questions/' + data[i]['question_id'] + '"> 質問を見る</a>';
          marker[i] = new google.maps.Marker({
            position: markerLatLng,
            map: map
          });
          windows[i] = new google.maps.InfoWindow({
            content: contentString
          });
          markerEvent(i);
        }
      }
    });
  }
}

function markerEvent(i) {
  marker[i].addListener('click', function() {
    if (currentInfoWindow) {
      currentInfoWindow.close();
    }
    windows[i].open(map, marker[i]);
    currentInfoWindow = windows[i];
  });
}