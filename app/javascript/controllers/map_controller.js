import { Controller } from "@hotwired/stimulus"
import { MapboxGeocoder } from "@mapbox/mapbox-gl-geocoder";

export default class extends Controller {
  connect() {
    console.log("Hello, Stimulus!")
  }
}
