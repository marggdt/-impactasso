import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

let markersObject;

const unselectedMarker = (markerObject) => {
  markerObject.getElement().querySelectorAll('svg g')[2].setAttribute("fill", "#3FB1CE")
}

const selectedMarker = (markerObject) => {
  markerObject.getElement().querySelectorAll('svg g')[2].setAttribute("fill", "red")
}

const updateMarkerSelected = (assoId) => {
  const markerObject = markersObject[assoId]
  Object.values(markersObject).forEach(unselectedMarker)
  selectedMarker(markerObject)
}

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
    const markerObject = new mapboxgl.Marker()
    .setLngLat([marker.lng, marker.lat])
    .setPopup(popup)
    .addTo(map);
    markersObject[marker.id]  =markerObject;
  });
};
const initMapbox = () => {
  const mapElement = document.getElementById('map');
  markersObject = {};

  if (mapElement) {
    console.log("in mapox")
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/pdunleav/cjofefl7u3j3e2sp0ylex3cyb'
    });
    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([marker.lng, marker.lat])
        .addTo(map);
    });

    fitMapToMarkers(map, markers);
    addMarkersToMap(map, markers);
    console.log(markersObject);
    window.updateMarkerSelected = updateMarkerSelected
  }

};

export { initMapbox };
