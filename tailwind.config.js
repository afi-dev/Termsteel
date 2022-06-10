module.exports = {
  content: ["./src/**/**/*.{html,js}"],
  prefix: 'termsteel-',
  theme: {
    extend: {
      colors: {
        orange: '#FB923C',
        red: '#EF4444',
        blue: '#3B82F6',
        green: '#4ADE80',
        yellow: '#CA8A04',
        amber: '#F59E0B',
        steel: {
          100: '#323232',
          200: '#17191a',
          300: '#121212',
        },
      },
      fontFamily: {
        'poppins': ['Poppins'],
      },
    },
  },
  plugins: [
    require('tailwind-scrollbar-hide'),
  ]
}