import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash-removals"
export default class extends Controller {
  remove(){
    this.element.style.display = "none"
  }
}
