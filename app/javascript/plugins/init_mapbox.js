import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

let markersObject;
let imageSelected;
let imageUnselected;


const unselectedMarker = (markerObject) => {
  markerObject.getElement().style.backgroundImage = `url(${imageUnselected})`;
}

const selectedMarker = (markerObject) => {
  markerObject.getElement().style.backgroundImage = `url(${imageSelected})`;
}

const updateMarkerSelected = (assoId) => {
  const markerObject = markersObject[assoId]
  Object.values(markersObject).forEach(unselectedMarker)
  selectedMarker(markerObject)
}

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 50, duration: 0 });
};

const addMarkersToMap = (map, markers) => {
  markers.forEach((marker) => {
    const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

    const el = document.createElement('div');
    el.className = 'marker';
    el.style.backgroundImage = `url(${imageUnselected})`;
    el.style.backgroundSize = 'contain'
    el.style.width = '25px'
    el.style.height = '25px'

    const markerObject = new mapboxgl.Marker(el)
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


    console.log("in mapbox")
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    imageSelected = mapElement.dataset.imageSelected;
    imageUnselected = mapElement.dataset.imageUnselected;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/pdunleav/cjofefl7u3j3e2sp0ylex3cyb',
      center: [45.7579341, 4.7650812],
      zoom: 80.0
    });


    const markers = JSON.parse(mapElement.dataset.markers);


    fitMapToMarkers(map, markers);
    addMarkersToMap(map, markers);
    window.updateMarkerSelected = updateMarkerSelected
  }

};

export { initMapbox };
