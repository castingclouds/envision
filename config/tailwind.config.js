const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require("daisyui")
  ],
  daisyui: {
    themes: ["light", "dark", "bumblebee", "cupcake", "corporate", "emerald", "synthwave"],
    darkTheme: "dark",
    base: true,
    styled: true,
    utils: true,
    logs: false,
    // Custom components
    components: {
      // Custom fieldset component with cleaner focus state
      "fieldset-custom": {
        "selector": ".fieldset-custom",
        "style": `
          @apply border border-base-300 rounded-lg p-4 transition-colors duration-200 mb-4;
          &:focus-within {
            @apply border-primary;
          }
          & > legend {
            @apply px-2 text-lg font-medium;
          }
          & > div {
            @apply mt-0;
          }
        `
      },
      // Custom input component with cleaner focus state
      "input-custom": {
        "selector": ".input-custom",
        "style": `
          @apply input border-2 focus:outline-none focus:border-accent w-full bg-base-100 transition-colors duration-200;
        `
      }
    }
  }
}
