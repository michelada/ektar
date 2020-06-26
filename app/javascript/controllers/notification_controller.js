import { Controller } from "stimulus";
import { Notyf } from "notyf";

export default class extends Controller {
  static targets = ["notification"];

  connect() {
    if (this.hasNotificationTarget) {
      this.notyf = new Notyf({
        duration: 4000,
        dismissible: true,
        position: {
          x: "right",
          y: "top"
        }
      });

      const alertMessage = this.notificationTarget.dataset.alert;
      const noticeMessage = this.notificationTarget.dataset.notice;

      if (alertMessage) {
        this.notyf.error(alertMessage);
      } else if (noticeMessage) {
        this.notyf.success(noticeMessage);
      }
    }
  }
}
