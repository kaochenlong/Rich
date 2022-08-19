import { Controller } from "stimulus"
import Sortable from "sortablejs"

export default class extends Controller {
  connect() {
    Sortable.create(this.element, {
      onEnd: (e) => {
        const { item, newIndex } = e

        console.log(item.dataset.id, newIndex)
      },
    })
  }
}
