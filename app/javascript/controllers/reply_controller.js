import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    commentId: Number,
    author: String,
    content: String
  }

  select() {
    // parent_id
    document.getElementById("comment_parent_id").value = this.commentIdValue

    // trix editor
    const trixEditor = document.querySelector("trix-editor")
    if (trixEditor && trixEditor.editor) {
      trixEditor.editor.insertString(this.authorValue + ', ')
      var length = trixEditor.editor.getDocument().toString().length
      trixEditor.editor.setSelectedRange(length - 1)
    }
    // scroll
    document.getElementById("add-comment")
      .scrollIntoView({ behavior: "smooth" })
  }
  edit() {
    // trix editor
    const trixEditor = document.querySelector("trix-editor")
    if (trixEditor && trixEditor.editor) {
      trixEditor.editor.loadHTML(this.contentValue)
    }
    // scroll
    document.getElementById("edit_comment_id").value = this.commentIdValue
    document.getElementById("add-comment")
      .scrollIntoView({ behavior: "smooth" })
  }
}