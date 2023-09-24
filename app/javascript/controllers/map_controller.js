import { Controller } from "@hotwired/stimulus"
import MapboxGeocoder from "@mapbox/mapbox-gl-geocoder"


// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/navigation-night-v1"
    });
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
    this.map.addControl(new MapboxGeocoder({
      accessToken: mapboxgl.accessToken,
      mapboxgl: mapboxgl,
    }))
    this.map.addControl(new mapboxgl.FullscreenControl(), 'bottom-left');

  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([marker.lng, marker.lat]))
    this.map.fitBounds(bounds, { padding: 55, maxZoom: 15, duration: 3 })
  }


  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html) // Add this
      new mapboxgl.Marker()
        .setLngLat([marker.lng + Math.random() * 0.001,
        marker.lat + Math.random() * 0.001])
        .setPopup(popup) // Add this
        .addTo(this.map)
    })
  }
}