import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    commentId: Number,
    author: String
  }

  select() {
    // parent_id
    document.getElementById("comment_parent_id").value = this.commentIdValue

    // trix editor
    const trixEditor = document.querySelector("trix-editor")
    if (trixEditor && trixEditor.editor) {
      trixEditor.editor.insertString(this.authorValue + ', ')
    }
    // scroll
    document.getElementById("add-comment")
      .scrollIntoView({ behavior: "smooth" })
  }
}