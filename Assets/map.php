<!DOCTYPE html>
<html>
  <head>
    <title>Load Map</title>
    <script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
    <style type="text/css">
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }

      /* Optional: Makes the sample page fill the window. */
      html,
      body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>
    <?php
    	$latlang = $_GET['latlang'];
    	$x = explode(',',$latlang);
    	
    	$lat = $x[0];
    	$lang = $x[1];
    ?>
    <script>
      // This example adds a marker to indicate the position of Bondi Beach in Sydney,
      // Australia. -7.5569879,110.886444
      function initMap() {
      	var lat = <?php echo $lat;?>;
      	var lang = <?php echo $lang;?>;
      	// console.log(lat);
        const map = new google.maps.Map(document.getElementById("map"), {
          zoom: 40,
          center: { lat: lat, lng: lang },
          mapTypeId: 'satellite'
        });
        const image =
          "https://github.com/adji142/astar/blob/master/images/marker/waypts.png";
        const beachMarker = new google.maps.Marker({
          position: { lat: lat, lng: lang },
          map,
          // icon: image,
        });
      }
    </script>
  </head>
  <body>
    <div id="map"></div>

    <!-- Async script executes immediately and must be after any DOM elements used in callback. -->
    <script
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyB9kWX3JZIeoK36X9N0vh17TUuv2EU2OlQ&callback=initMap&libraries=&v=weekly"
      async
    ></script>
  </body>
</html>