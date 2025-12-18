// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "./application"
import ReplyController from "./reply_controller"
application.register("reply", ReplyController)
