import { defineConfig, presetUno } from 'unocss';
export default defineConfig({
  presets: [presetUno()],
  content: {
    filesystem: ['src/**/*.{html,t.html}'],
  },
  theme: {
    breakpoints: {
      xs: '475px',
      sm: '640px',
      md: '768px',
      lg: '1024px',
      xl: '1280px',
      xxl: '1536px',
    },
  },
});
