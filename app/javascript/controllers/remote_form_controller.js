import { Controller } from "stimulus";
import { Notyf } from "notyf";

export default class extends Controller {
  static targets = [
    "form",
    "date",
    "submitButton",
    "cancelButton",
    "notification",
    "spinner"
  ];

  connect() {
    this.notyf = new Notyf({
      duration: 4000,
      dismissible: true,
      position: {
        x: "right",
        y: "top"
      }
    });

    if (this.dateTargets.length > 0) {
      this.dateTargets.forEach(dateTarget => {
        let dateHTML = "";
        Array.from(dateTarget.children, el => {
          const cssClass = el.classList;
          dateHTML += `<div class="control"><div class="select ${cssClass}">${el.outerHTML}</div></div>`;
          return dateHTML;
        });
        dateTarget.innerHTML = dateHTML;
        return null;
      });
    }

    addEventListener("direct-uploads:start", this.showSpinner);
  }

  disconnect() {
    removeEventListener("direct-uploads:start", this.showSpinner);
  }

  showSpinner() {
    if (this.hasSpinnerTarget) {
      this.spinnerTarget.classList.add("is-loading");
    }
  }

  formError(event) {
    this.clearFormErrors();

    const [model, status] = event.detail;
    if (status === "Unprocessable Entity") {
      this.notyf.error(model.flash);

      if (model.errors) {
        const errors = Object.entries(model.errors);

        errors.forEach(([field, error]) => {
          const inputs = this.formTarget.querySelectorAll(
            `input.${field}, .select.${field}, .textarea.${field}, .field-image.${field}`
          );
          inputs.forEach(input => this.inputError(input, error));
        }, this);
      }

      const uploads = this.formTarget.querySelectorAll(
        "input[type=file][data-direct-upload-url][disabled]"
      );
      uploads.forEach(upload => (upload.disabled = false));
    }
  }

  inputError(input, message) {
    const fieldClass = input.classList.contains("date")
      ? ".group-fields"
      : ".field";
    input.classList.add("is-danger");

    const field = input.closest(fieldClass);
    if (field) {
      const hasMessage = field.querySelectorAll("p.is-danger");
      if (hasMessage.length === 0) {
        const messageNode = document.createElement("p");
        messageNode.classList.add("help");
        messageNode.classList.add("is-danger");
        messageNode.innerText = message;

        field.appendChild(messageNode);
      }
    }
  }

  clearFormErrors() {
    const messages = this.formTarget.querySelectorAll("p.is-danger");
    Array.from(messages).forEach(message => message.remove());

    const errorClasses = this.formTarget.querySelectorAll(".is-danger");
    Array.from(errorClasses).forEach(error =>
      error.classList.remove("is-danger")
    );
  }

  didSubmit(event) {
    const imageError = this.formTarget.querySelector(".field-image.is-danger");
    let result = true;

    if (imageError) {
      event.preventDefault();
      event.stopPropagation();
      result = false;
    }

    return result;
  }
}
