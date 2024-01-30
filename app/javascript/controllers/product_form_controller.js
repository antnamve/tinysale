import { Controller } from "@hotwired/stimulus"

const imageTypes = ['image/jpeg', 'image/png', 'image/gif', 'image/svg+xml']
// Connects to data-controller="product-form"
export default class extends Controller {
  static targets = ["cover", "coverSection", "coverInput", "coverUploadSection", "thumbnail", "thumbnailInput"]

  connect() {
  }

  changeCover(e) {
    e.preventDefault()

    this.coverInputTarget.click()
  }

  attachCover(e) {
    e.preventDefault()

    const file = e.target.files[0]

    if (!imageTypes.includes(file.type)) {
      alert('Attached file must be an image')
    }

    this.coverInputTarget.files = e.target.files

    this.coverTarget.src = URL.createObjectURL(file)

    this.coverUploadSectionTarget.classList.add('hidden')

    this.coverSectionTarget.classList.remove('hidden')
  }

  changeThumbnail(e) {
    e.preventDefault()

    this.thumbnailInputTarget.click()
  }

  attachThumbnail(e) {
    e.preventDefault()

    const file = e.target.files[0]

    if (!imageTypes.includes(file.type)) {
      alert('Attached file must be an image')
    }

    this.thumbnailInputTarget.files = e.target.files

    this.thumbnailTarget.src = URL.createObjectURL(file)
  }
}
