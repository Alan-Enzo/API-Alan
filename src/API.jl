#module API
using Genie
include("bancodedados.jl")
include("Controllers.jl")

route(deleteuser, "/user/:id", method = "DELETE")
route(ControllerCreateUser, "/user", method = "POST")
route(ControllerGetUsers, "/user", method = "GET")
route(getuser, "/user/:id", method = "GET")
route(ControllerUserUpdate, "/user/:id", method = "PUT")
#end
 
