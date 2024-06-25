#module Controllers 
using Genie, Genie.Requests, Genie.Renderer, Genie.Router, Genie.Renderer.Json
using MySQL, DBInterface

function createuser(nome::String, email::String, idade::Int)
    create = """INSERT INTO usuario (nome,email, idade) VALUES (?,?,?);"""
    stmt = DBInterface.prepare(conn, create)
    DBInterface.execute(stmt,(nome, email,idade))
end

function ControllerCreateUser()
    userData = jsonpayload()
    createuser(
        userData["nome"],
        userData["email"],
        userData["idade"]
    )
    return Json.json("mensagem" => "Usuário criado", status= 201)
end

function getusers(result)
    usuarios = []
    for row in result
        push!(usuarios,Dict(
                "id" => row[1],
                "nome" => row[2],
                "email" => row[3],
                "idade" => row[4]
        ))
    end
    return Json.json(usuarios)
end

function ControllerGetUsers()
    result = DBInterface.execute(conn,"SELECT * FROM usuario")
    usuarios_json = getusers(result)
    return usuarios_json
end

function getuser()
    id = params(:id)
    result = DBInterface.prepare(conn, "SELECT * FROM usuario WHERE id = ?")
    stmt = DBInterface.execute(result,(id,))
    rows = []
        for row in stmt
            push!(rows,Dict(
                "id" => row[1],
                "nome" => row[2],
                "email" => row[3],
                "idade" => row[4]
            ))
        end
        if isempty(rows)
           return "Usuário não encontrado"
        else
           return Json.json(rows[1])
        end
    end

    function updateuser(nome::String, email::String,idade::Int,id::Int)
        update = """UPDATE usuario SET nome =?, email =?, idade =? WHERE id =?"""
        updateuser = DBInterface.prepare(conn,update)
        DBInterface.execute(updateuser, (nome,email, idade,id))
    end

    function ControllerUserUpdate()
        userUpdate = jsonpayload()
        updateuser(
            userUpdate["nome"],
            userUpdate["email"],
            userUpdate["idade"],
            userUpdate["id"]
        )
        return Json.json("mensagem" => "Usuário atualizado", status = 201)
    end

    function deleteuser()
        id = params(:id)
        delete = DBInterface.prepare(conn, "DELETE FROM usuario WHERE id =?")
        DBInterface.execute(delete, (id,))
        return Json.json("mensagem" => "Usuário deletado com sucesso", status = 200)
    end
#end

