import { SprinklesElement } from "sprinkles-js";

export class ResizeIframeElement extends SprinklesElement {
  static tagName = "resize-iframe";
  static refs = ["iframe"];
  static events = {
    resize: { method: "updateHeight", element: window },
    load: { method: "updateHeight", ref: "iframe" },
  };

  afterConnected() {
    window.requestAnimationFrame(this.updateHeight.bind(this));
  }

  updateHeight() {
    const height = this.refs.iframe.contentDocument.body?.scrollHeight || 500;
    // Add extra padding, since the body margin is not taken into account
    this.refs.iframe.height = `${height + 40}px`;
  }
}
