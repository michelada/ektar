export class Flash {
  static setup() {
    const close = document.querySelector('button.delete');
    if (close) {
      close.addEventListener('click', () => {
        const flash = document.querySelector('.message-container')
        if (flash) {
          flash.remove();
        }
      });
    }
  }
}
