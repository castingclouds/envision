import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="theme"
export default class extends Controller {
  static targets = ["toggle", "selector"]
  static values = {
    themes: { type: Array, default: ["light", "dark", "bumblebee", "cupcake", "corporate", "emerald", "synthwave"] },
    defaultLight: { type: String, default: "bumblebee" },
    defaultDark: { type: String, default: "dark" }
  }

  connect() {
    // Initialize the toggle based on current theme
    this.updateToggleState()
    
    // Add event listener for system preference changes
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', this.handleSystemThemeChange.bind(this))
  }

  toggle() {
    const currentTheme = document.documentElement.getAttribute('data-theme')
    const isDark = this.isDarkTheme(currentTheme)
    
    // Toggle between dark and light themes
    const newTheme = isDark ? this.defaultLightValue : this.defaultDarkValue
    document.documentElement.setAttribute('data-theme', newTheme)
    
    // Save preference to localStorage
    localStorage.setItem('theme', newTheme)
    
    // Update toggle state
    this.updateToggleState()
  }
  
  updateToggleState() {
    const currentTheme = document.documentElement.getAttribute('data-theme')
    const isDark = this.isDarkTheme(currentTheme)
    
    if (this.hasToggleTarget) {
      this.toggleTarget.checked = isDark
    }
    
    if (this.hasSelectorTarget) {
      this.selectorTarget.value = currentTheme
    }
  }
  
  handleSystemThemeChange(event) {
    // Only change theme if user hasn't set a preference
    if (!localStorage.getItem('theme')) {
      const newTheme = event.matches ? this.defaultDarkValue : this.defaultLightValue
      document.documentElement.setAttribute('data-theme', newTheme)
      this.updateToggleState()
    }
  }
  
  changeTheme(event) {
    const newTheme = event.target.value
    document.documentElement.setAttribute('data-theme', newTheme)
    localStorage.setItem('theme', newTheme)
    this.updateToggleState()
  }
  
  isDarkTheme(theme) {
    // Consider dark theme or any theme that should be treated as dark
    return theme === 'dark' || theme === 'synthwave'
  }
}
