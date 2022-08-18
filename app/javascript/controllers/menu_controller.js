import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="menu"
export default class extends Controller {
  static targets = ['mobileMenu', 'desktopMenu']

  connect() {
  }

  toggleDesktopMenu() {
    console.log('toggle DesktopMenu')
    this.desktopMenuTarget.classList.toggle('hidden')
  }

  toggleMobileMenu() {
    console.log('toggleMobileMenu')
    this.mobileMenuTarget.classList.toggle('hidden')
  }
}
