import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["image", "background", "button", "buttonText"];

  connect() {
    const { image, maxSize } = this.backgroundTarget.dataset;
    this.max_file_size = maxSize;
    let buttonText = "";

    if (image !== "") {
      this.backgroundTarget.style.backgroundImage = `url(${image})`;
      this.backgroundTarget.classList.add("field-image-loaded");
      buttonText = this.buttonTextTarget.dataset.change;
    } else {
      buttonText = this.buttonTextTarget.dataset.new;
    }

    this.buttonTextTarget.innerText = buttonText;

    // https://stackoverflow.com/a/51250378 FACEBOOK BUG
    if (this.isFacebook() && this.hasImageTarget) {
      this.imageTarget.removeAttribute("accept");
    }
  }

  isFacebook() {
    let ua = navigator.userAgent || navigator.vendor || window.opera;
    return (ua.indexOf("FBAN") > -1) || (ua.indexOf("FBAV") > -1);
  }

  changeImage(event) {
    this.clearErrors();

    let file = event.target.files[0];
    this.backgroundTarget.style.backgroundImage = `url(${URL.createObjectURL(file)})`;

    this.backgroundTarget.classList.add("field-image-loaded");
    const buttonText = this.buttonTextTarget.dataset.change;
    this.buttonTextTarget.innerText = buttonText;

    this.validate(file);
  }

  clearErrors(){
    this.backgroundTarget.classList.remove("is-danger");

    const field = this.backgroundTarget.closest(".field");
    if (field) {
      const messages = field.querySelectorAll("p.is-danger");
      Array.from(messages).forEach(message => message.remove());
    }
  }

  validate(file) {
    if (Math.ceil(file.size / 1024) > this.max_file_size) {
      this.backgroundTarget.classList.add("is-danger");
      const message = this.backgroundTarget.dataset["validation"]

      const messageNode = document.createElement("p");
      messageNode.classList.add("help");
      messageNode.classList.add("is-danger");
      messageNode.innerText = message;

      const field = this.backgroundTarget.closest(".field");
      if (field) {
        field.appendChild(messageNode);
      }
    }
  }

  choose(event) {
    event.preventDefault();
    this.imageTarget.click();
  }
}
