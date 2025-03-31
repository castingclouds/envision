import { Controller } from "@hotwired/stimulus"

// Handles auto-dismissing alerts
export default class extends Controller {
  connect() {
    // Auto-dismiss alerts after 2 seconds
    setTimeout(() => {
      this.dismiss()
    }, 2000)
  }

  dismiss() {
    // Fade out the alert
    this.element.style.opacity = '0'
    this.element.style.transition = 'opacity 0.5s ease'
    
    // Remove the element after the fade animation completes
    setTimeout(() => {
      this.element.remove()
    }, 500)
  }
}
