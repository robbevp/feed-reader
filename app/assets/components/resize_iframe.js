import { SprinklesComponent } from "../lib/sprinkles";

export default class ResizeIframeComponent extends SprinklesComponent {
  connect() {
    document.addEventListener("load", () => this.setCorrectHeight());
    this.element.contentWindow.addEventListener("load", () =>
      this.setCorrectHeight()
    );
    window.addEventListener("resize", () => this.setCorrectHeight());
    this.setCorrectHeight();
  }

  disconnect() {
    document.removeEventListener("load", () => this.setCorrectHeight());
    window.removeEventListener("resize", () => this.setCorrectHeight());
  }

  setCorrectHeight() {
    const height = this.element.contentDocument.body.scrollHeight;
    // Add extra padding, since the body margin is not taken into account
    this.element.height = `${height + 40}px`;
  }
}
