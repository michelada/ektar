import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["modal", "content"];

  show(event) {
    event.preventDefault();

    this.contentTarget.innerHTML = "";

    fetch(this.contentTarget.dataset.modalViewUrl)
      .then(response => response.text())
      .then(html => {
        this.contentTarget.innerHTML = html;
      });

    const html = document.querySelector("html");
    html.classList.toggle("is-clipped");
    this.modalTarget.classList.toggle("is-active");
  }

  close(event) {
    event.preventDefault();

    const html = document.querySelector("html");
    html.classList.toggle("is-clipped");
    this.modalTarget.classList.toggle("is-active");

    this.contentTarget.innerHTML = "";
  }
}
