// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"
import Rails from "@rails/ujs";
Rails.start();

import { Turbo } from "@hotwired/turbo-rails"
Turbo.session.drive = false


import "@hotwired/turbo-rails"
import "controllers"

//import Rails from "@rails/ujs";
//Rails.start();

function initMap(lat, lng) {    
  var myCoords = new google.maps.LatLng(lat, lng);    
  var mapOptions = {
  center: myCoords,
  zoom: 16
  };    
  var map = new google.maps.Map(document.getElementById('map'), mapOptions);    

  var marker = new google.maps.Marker({
      position: myCoords,
      map: map,
  });
}
window.initMap = initMap;

function myFunction3() {
  var s_cat = document.getElementById(ss_cat);
  
  var s_cat = event.target.value;
  console.log(s_cat);
}
