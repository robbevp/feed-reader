import "../styles/application.css";
import "@hotwired/turbo-rails";
import { Sprinkles } from "../lib/sprinkles";
import ResizeIframeComponent from "../components/resize_iframe";

const sprinkles = new Sprinkles();
sprinkles.registerComponent("resize-iframe", ResizeIframeComponent);

document.addEventListener("DOMContentLoaded", () => {
  sprinkles.start();
});

document.addEventListener("turbo:load", () => {
  sprinkles.update();
});
