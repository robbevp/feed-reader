export class Sprinkles {
  registeredComponents = {};
  connectedComponents = [];

  constructor() {
    this.root = document.body;
  }

  registerComponent(name, componentClass) {
    this.registeredComponents[name] = componentClass;
  }

  start() {
    this.initializeComponents();
  }

  update() {
    this.refreshComponents();
    this.initializeComponents();
  }

  initializeComponents() {
    const nodes = document.querySelectorAll(
      "[data-sprinkles-component]:not([data-sprinkles-component-initialized])",
    );
    nodes.forEach((node) => {
      const componentName = node.getAttribute("data-sprinkles-component");
      const componentClass = this.registeredComponents[componentName];
      if (componentClass) {
        this.connectedComponents.push(new componentClass(node, this));
      } else {
        // eslint-disable-next-line no-console
        console.error(
          `Sprinkles components: component ${componentName} was not registered before it was discovered in the DOM`,
          node,
        );
      }
    });
  }

  refreshComponents() {
    this.connectedComponents.forEach((comp, index) => {
      if (comp.isStillConnected) return;

      comp.disconnect();
      this.connectedComponents.splice(index, 1);
    });
  }
}

export class SprinklesComponent {
  constructor(element, sprinkles) {
    this.element = element;
    this.sprinkes = sprinkles;
    this.connect();
    this.setInitialized();
  }

  connect() {}

  disconnect() {}

  get isStillConnected() {
    return document.contains(this.element);
  }

  setInitialized() {
    this.element.toggleAttribute("data-sprinkles-component-initialized");
  }
}
