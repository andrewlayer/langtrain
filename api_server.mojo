from python import Python

import builtin

from llama2 import run


fn main() raises:
    let HOST = "127.0.0.1"
    let PORT = 65432

    let py_builtins = Python.import_module("builtins")
    let socket = Python.import_module("socket")

    while True:
        let s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        _ = s.bind((HOST, PORT))
        _ = s.listen()

        let conn = s.accept()[0]

        while True:
            let data = conn.recv(1024)
            let str_data = data.to_string()[2:-1]
            if not data:
                break
            
            let result = run(str_data)
            let send_back = py_builtins.bytes(result, "utf-8")
            
            _ = conn.sendall(send_back)