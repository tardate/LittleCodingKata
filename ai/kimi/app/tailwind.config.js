/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: ["class"],
  content: ['./index.html', './src/**/*.{js,ts,jsx,tsx}'],
  theme: {
    extend: {
      colors: {
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        primary: {
          DEFAULT: "hsl(var(--primary))",
          foreground: "hsl(var(--primary-foreground))",
        },
        secondary: {
          DEFAULT: "hsl(var(--secondary))",
          foreground: "hsl(var(--secondary-foreground))",
        },
        destructive: {
          DEFAULT: "hsl(var(--destructive) / <alpha-value>)",
          foreground: "hsl(var(--destructive-foreground) / <alpha-value>)",
        },
        muted: {
          DEFAULT: "hsl(var(--muted))",
          foreground: "hsl(var(--muted-foreground))",
        },
        accent: {
          DEFAULT: "hsl(var(--accent))",
          foreground: "hsl(var(--accent-foreground))",
        },
        popover: {
          DEFAULT: "hsl(var(--popover))",
          foreground: "hsl(var(--popover-foreground))",
        },
        card: {
          DEFAULT: "hsl(var(--card))",
          foreground: "hsl(var(--card-foreground))",
        },
        sidebar: {
          DEFAULT: "hsl(var(--sidebar-background))",
          foreground: "hsl(var(--sidebar-foreground))",
          primary: "hsl(var(--sidebar-primary))",
          "primary-foreground": "hsl(var(--sidebar-primary-foreground))",
          accent: "hsl(var(--sidebar-accent))",
          "accent-foreground": "hsl(var(--sidebar-accent-foreground))",
          border: "hsl(var(--sidebar-border))",
          ring: "hsl(var(--sidebar-ring))",
        },
        cyber: {
          pink: "#ff0080",
          purple: "#8b00ff",
          yellow: "#ffff00",
          orange: "#ff8000",
          green: "#39ff14",
          blue: "#00ffff",
          dark: "#0a0a0a",
          deepblue: "#0a1628",
          cream: "#e7d9cf",
          light: "#f6e7d9",
        },
      },
      borderRadius: {
        xl: "calc(var(--radius) + 4px)",
        lg: "var(--radius)",
        md: "calc(var(--radius) - 2px)",
        sm: "calc(var(--radius) - 4px)",
        xs: "calc(var(--radius) - 6px)",
      },
      boxShadow: {
        xs: "0 1px 2px 0 rgb(0 0 0 / 0.05)",
        neon: "0 0 10px rgba(255, 0, 128, 0.8), 0 0 20px rgba(255, 0, 128, 0.6), 0 0 30px rgba(255, 0, 128, 0.4)",
        "neon-blue": "0 0 10px rgba(0, 255, 255, 0.8), 0 0 20px rgba(0, 255, 255, 0.6), 0 0 30px rgba(0, 255, 255, 0.4)",
        "neon-green": "0 0 10px rgba(57, 255, 20, 0.8), 0 0 20px rgba(57, 255, 20, 0.6), 0 0 30px rgba(57, 255, 20, 0.4)",
        "neon-purple": "0 0 10px rgba(139, 0, 255, 0.8), 0 0 20px rgba(139, 0, 255, 0.6), 0 0 30px rgba(139, 0, 255, 0.4)",
      },
      fontFamily: {
        display: ['"Bebas Neue"', 'sans-serif'],
        body: ['"Montserrat"', 'sans-serif'],
        mono: ['"PT Mono"', 'monospace'],
      },
      keyframes: {
        "accordion-down": {
          from: { height: "0" },
          to: { height: "var(--radix-accordion-content-height)" },
        },
        "accordion-up": {
          from: { height: "var(--radix-accordion-content-height)" },
          to: { height: "0" },
        },
        "caret-blink": {
          "0%,70%,100%": { opacity: "1" },
          "20%,50%": { opacity: "0" },
        },
        "neon-pulse": {
          "0%, 100%": { opacity: "0.9" },
          "50%": { opacity: "1" },
        },
        "neon-flicker": {
          "0%, 100%": { opacity: "1", filter: "brightness(1)" },
          "50%": { opacity: "0.8", filter: "brightness(1.2)" },
          "75%": { opacity: "0.9", filter: "brightness(0.9)" },
        },
        "float": {
          "0%, 100%": { transform: "translateY(0px)" },
          "50%": { transform: "translateY(-10px)" },
        },
        "spin-slow": {
          from: { transform: "rotate(0deg)" },
          to: { transform: "rotate(360deg)" },
        },
        "marquee-up": {
          from: { transform: "translateY(0)" },
          to: { transform: "translateY(-50%)" },
        },
        "marquee-down": {
          from: { transform: "translateY(-50%)" },
          to: { transform: "translateY(0)" },
        },
        "cat-walk": {
          "0%": { transform: "translateX(-10%) scaleX(1)" },
          "49%": { transform: "translateX(110%) scaleX(1)" },
          "50%": { transform: "translateX(110%) scaleX(-1)" },
          "99%": { transform: "translateX(-10%) scaleX(-1)" },
          "100%": { transform: "translateX(-10%) scaleX(1)" },
        },
        "rat-scurry": {
          "0%": { transform: "translateX(110%) scaleX(-1)" },
          "49%": { transform: "translateX(-10%) scaleX(-1)" },
          "50%": { transform: "translateX(-10%) scaleX(1)" },
          "99%": { transform: "translateX(110%) scaleX(1)" },
          "100%": { transform: "translateX(110%) scaleX(-1)" },
        },
        "bird-fly": {
          "0%": { transform: "translate(-20%, 20%) rotate(-10deg)", opacity: "0" },
          "10%": { opacity: "1" },
          "25%": { transform: "translate(25%, 5%) rotate(5deg)" },
          "50%": { transform: "translate(70%, 15%) rotate(-5deg)" },
          "90%": { opacity: "1" },
          "100%": { transform: "translate(120%, -10%) rotate(10deg)", opacity: "0" },
        },
        "laundry-flutter": {
          "0%, 100%": { transform: "rotate(-2deg)" },
          "50%": { transform: "rotate(2deg)" },
        },
        "fan-spin": {
          from: { transform: "rotate(0deg)" },
          to: { transform: "rotate(360deg)" },
        },
        "day-night-cycle": {
          "0%": { backgroundColor: "#1a1a2e" },
          "25%": { backgroundColor: "#4a7c9d" },
          "50%": { backgroundColor: "#ff7e5f" },
          "75%": { backgroundColor: "#1a1a2e" },
          "100%": { backgroundColor: "#1a1a2e" },
        },
      },
      animation: {
        "accordion-down": "accordion-down 0.2s ease-out",
        "accordion-up": "accordion-up 0.2s ease-out",
        "caret-blink": "caret-blink 1.25s ease-out infinite",
        "neon-pulse": "neon-pulse 4s ease-in-out infinite",
        "neon-flicker": "neon-flicker 3s ease-in-out infinite",
        "float": "float 6s ease-in-out infinite",
        "spin-slow": "spin-slow 20s linear infinite",
        "marquee-up": "marquee-up 30s linear infinite",
        "marquee-down": "marquee-down 30s linear infinite",
        "cat-walk": "cat-walk 20s linear infinite",
        "rat-scurry": "rat-scurry 15s linear infinite",
        "bird-fly": "bird-fly 12s ease-in-out infinite",
        "laundry-flutter": "laundry-flutter 3s ease-in-out infinite",
        "fan-spin": "fan-spin 0.5s linear infinite",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
}
