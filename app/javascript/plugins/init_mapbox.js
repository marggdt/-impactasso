import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([marker.lng, marker.lat]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

// const addMarkersToMap = (map, markers) => {
//   const el = document.createElement('div');
//   el.className = 'marker';
//   el.style.backgroundImage = `url('${marker.image_url}')`;
//   el.style.backgroundSize = 'contain'
//   el.style.width = '25px'
//   el.style.height = '25px'
//   markers.forEach((marker) => {
//     new mapboxgl.Marker()
//     .setLngLat([marker.lng, marker.lat])
//     .setPopup(popup)
//     .addTo(map);
//   });
// };
const initMapbox = () => {
  const mapElement = document.getElementById('map');

  if (mapElement) {
    console.log("in mapox")
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/pdunleav/cjofefl7u3j3e2sp0ylex3cyb'
    });

    const markers = JSON.parse(mapElement.dataset.markers);

    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
      const el = document.createElement('div');
      // el.className = 'marker';
      el.style.backgroundImage = `url('${marker.image_url}')`;
      el.style.backgroundSize = 'contain'
      el.style.width = '25px'
      el.style.height = '25px'

      console.log(el)

      new mapboxgl.Marker(el)
        .setLngLat([marker.lng, marker.lat])
        .addTo(map);
    });

    fitMapToMarkers(map, markers);
    // addMarkersToMap(map, markers);
  }

};

export { initMapbox };
