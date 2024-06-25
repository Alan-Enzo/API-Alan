
using MySQL, DBInterface

host = "localhost"
user = "user"
passwd = "123"

conn = DBInterface.connect(MySQL.Connection, host, user, passwd)
DBInterface.execute(conn, "CREATE DATABASE dados")
DBInterface.execute(conn, "USE dados")
DBInterface.execute(conn, """CREATE TABLE usuario (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        nome VARCHAR(100),
                        email VARCHAR(100),
                        idade INT
                        );""")
