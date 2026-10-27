/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ['./index.html'],
  theme: {
    extend: {
      fontFamily: {
        display: ['Manrope', 'system-ui', 'sans-serif'],
        sans: ['Inter', 'system-ui', 'sans-serif']
      },
      colors: {
        msblue:   { 500: '#0078D4', 600: '#106EBE', 700: '#005A9E', 800: '#004578' },
        msindigo: { 400: '#7B7FE0', 500: '#5B5FC7', 600: '#4F4FB8' },
        navy:     { 900: '#0F1A2F', 800: '#1A2942', 700: '#2C3E60', 600: '#475878' }
      }
    }
  }
}
