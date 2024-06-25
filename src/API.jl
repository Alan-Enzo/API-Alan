#module API
using Genie


route(deleteuser, "/delete/:id", method = "DELETE")
route(ControllerCreateUser, "/criar", method = "POST")
route(ControllerGetUsers, "/users", method = "GET")
route(getuser, "/user/:id", method = "GET")
route(ControllerUserUpdate, "/update/:id", method = "PUT")
#end
 
