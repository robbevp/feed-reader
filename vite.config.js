import { defineConfig } from "vite";
import RubyPlugin from "vite-plugin-ruby";

export default defineConfig({
  plugins: [RubyPlugin()],
  css: {
    transformer: "lightningcss",
    lightningcss: {
      drafts: {
        nesting: true,
        customMedia: true,
      },
    },
  },
  build: {
    cssMinify: "lightningcss",
  },
});
