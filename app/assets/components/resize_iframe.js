import { SprinklesComponent } from "../lib/sprinkles";

export default class ResizeIframeComponent extends SprinklesComponent {
  connect() {
    this.element.contentWindow.addEventListener(
      "load",
      this.setCorrectHeight.bind(this),
    );
    window.addEventListener("resize", this.setCorrectHeight.bind(this));

    // Already set height in next frame (when text is loaded, but resources might not be)
    window.requestAnimationFrame(this.setCorrectHeight.bind(this));
  }

  disconnect() {
    document.removeEventListener("load", this.setCorrectHeight.bind(this));
    window.removeEventListener("resize", this.setCorrectHeight.bind(this));
  }

  setCorrectHeight() {
    const height = this.element.contentDocument.body?.scrollHeight || 500;
    // Add extra padding, since the body margin is not taken into account
    this.element.height = `${height + 40}px`;
  }
}
