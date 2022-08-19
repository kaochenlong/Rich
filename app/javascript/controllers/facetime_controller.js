import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    navigator.mediaDevices
      .getUserMedia({
        audio: false,
        video: { facingMode: "user" },
      })
      .then((stream) => {
        this.element.srcObject = stream
        this.element.onloadedmetadata = () => {
          this.element.play()
        }
      })
  }
}
