import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="theme"
export default class extends Controller {
  static targets = ["toggle"]

  connect() {
    // Initialize the toggle based on current theme
    this.updateToggleState()
    
    // Add event listener for system preference changes
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', this.handleSystemThemeChange.bind(this))
  }

  toggle() {
    const currentTheme = document.documentElement.getAttribute('data-theme')
    const isDark = currentTheme === 'dark'
    
    // Toggle between dark and light themes
    const newTheme = isDark ? 'corporate' : 'dark'
    document.documentElement.setAttribute('data-theme', newTheme)
    
    // Save preference to localStorage
    localStorage.setItem('theme', newTheme)
    
    // Update toggle state
    this.updateToggleState()
  }
  
  updateToggleState() {
    const currentTheme = document.documentElement.getAttribute('data-theme')
    const isDark = currentTheme === 'dark'
    
    if (this.hasToggleTarget) {
      this.toggleTarget.checked = isDark
    }
  }
  
  handleSystemThemeChange(event) {
    // Only change theme if user hasn't set a preference
    if (!localStorage.getItem('theme')) {
      const newTheme = event.matches ? 'dark' : 'corporate'
      document.documentElement.setAttribute('data-theme', newTheme)
      this.updateToggleState()
    }
  }
}
