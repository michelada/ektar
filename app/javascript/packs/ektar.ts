import "../images/ektar.svg";
import "../images/organization-icon.svg";
import "../stylesheets/application.scss";

import "trix";
import "@rails/actiontext";

import Rails from "rails-ujs";
import Turbolinks from "turbolinks";

import "controllers";
import Flash from "../js/flash";

Rails.start();
Turbolinks.start();
Flash.setup();


document.addEventListener("turbolinks:load", () => Flash.setup(), {
  once: true
});
document.addEventListener("turbolinks:render", () => Flash.setup());
document.addEventListener("turbolinks:before-cache", () => Flash.clean());
document.addEventListener("ajax:before", () => Turbolinks.clearCache());
document.addEventListener("[data-remote]", () => Turbolinks.clearCache());
