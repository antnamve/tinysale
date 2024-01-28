import { Controller } from "@hotwired/stimulus"
import axios from "axios"

let files = []

export default class extends Controller {
  // Connects to data-controller="file-picker"
  static targets = [ "button", "fileInput", "content"]

  HEADERS = {
    "ACCEPT": "text/vnd.turbo-stream.html"
  }
  
  open() {
    this.fileInputTarget.click()
  }

  attachFile(content) {
    const contentId = content.element.dataset.contentId
    const fileIndex = files.findIndex(file => file.contentId == contentId)
    content.attachFile(files[fileIndex])
    files = files.splice(fileIndex, fileIndex)
    content.uploadFile()
  } 

  uploadFiles(e) {
    Array.from(e.target.files).forEach((file) => {
      axios.post("/api/contents", {
        name: file.name,
        file_size: file.size,
        file_type: file.type
      }, { headers: this.HEADERS }) 
      .then(response => {
        const contentId = response.data.match(/data-content-id=("\d+")/)[1].replace(/"|'/g, '')
        file["contentId"] = parseInt(contentId)
        files.push(file)
        Turbo.renderStreamMessage(response.data)
      })
    })
  }

  getUplodadedFileComponents() {
    return Array.from(document.getElementsByClassName('uploaded-file-component'))
  }

  buildContentParam(fileComponent) {
    const contentId = parseInt(fileComponent.dataset.contentId)
    const name = fileComponent.querySelector('input[name="name"]').value
    const description = fileComponent.querySelector('input[name="description"]').value
    return {
      content_id: contentId,
      name: name,
      description: description
    }
  }  

  submitForm(e) {
    e.preventDefault()

    const productId = this.element.dataset.productId
    const contents = []

    this.getUplodadedFileComponents().forEach((fileComponent) => {
      contents.push(this.buildContentParam(fileComponent))
    })

    axios.post(`/products/${productId}/attach_contents`, {
      contents: contents
    }).then((response) => {
      Turbo.visit(`/products/${productId}/edit`)
    })
  }
}
