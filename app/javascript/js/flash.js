export default class Flash {
  static clean() {
    const flash = document.querySelector(".message-container");
    if (flash) {
      flash.remove();
    }
  }

  static setup() {
    const close = document.querySelector("button.delete");
    if (close) {
      const autoClose = setTimeout(() => {
        close.click();
        clearTimeout(autoClose);
      }, 2000);

      close.addEventListener("click", () => {
        const flash = document.querySelector(".message-container");
        if (flash) {
          flash.remove();
        }
      });
    }
  }
}
