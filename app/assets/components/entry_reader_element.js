import { SprinklesElement } from "sprinkles-js";
import { throttle } from "../helpers/throttle";

export class EntryReaderElement extends SprinklesElement {
  static tagName = "entry-reader";
  static refs = ["iframe", "progress"];
  static events = {
    resize: { method: "updateHeight", element: window },
    load: { method: "updateHeight", ref: "iframe" },
    scroll: { method: "throttledProgress", element: document },
    hashchange: { method: "scrollToAnchor", element: window },
  };

  throttledProgress = throttle(this.#updateProgress.bind(this), 20);

  afterConnected() {
    window.requestAnimationFrame(this.updateHeight.bind(this));
    window.requestAnimationFrame(this.scrollToAnchor.bind(this));
  }

  updateHeight() {
    const height =
      this.refs.iframe.contentDocument.documentElement?.scrollHeight;
    this.refs.iframe.height = `${height || 500}px`;

    this.throttledProgress();
  }

  scrollToAnchor() {
    const anchor = window.location.hash;
    if (anchor === undefined) return;

    const element = this.refs.iframe.contentDocument.querySelector(anchor);
    if (element === null) return;

    const { y: iframeTop } = this.refs.iframe.getBoundingClientRect();
    const { y: elementTop } = element.getBoundingClientRect();
    window.scrollBy(0, iframeTop + elementTop - 16);
  }

  #updateProgress() {
    const target =
      document.documentElement.scrollHeight -
      document.documentElement.clientHeight;
    let progress = document.documentElement.scrollTop / target;
    // If progress is NaN, the target was probably exactly 0
    if (Number.isNaN(progress)) progress = 1;

    const clammedProgress = Math.min(1, Math.max(0, progress));

    this.refs.progress.toggleAttribute("data-fits-page", target <= 0);
    this.refs.progress.value = clammedProgress;
    this.refs.progress.style.setProperty("--progress", clammedProgress);
    this.refs.progress.innerText = `${Math.round(clammedProgress * 100)}%`;
  }
}
