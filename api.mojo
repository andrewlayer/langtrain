from python import Python

import builtin

from llama2 import run


fn main() raises:
    let py_builtins = Python.import_module("builtins")
    let socket = Python.import_module("socket")
    while True:
        let HOST = "127.0.0.1"
        let PORT = 65432
        let s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        _ = s.bind((HOST, PORT))
        _ = s.listen()
        let conn_and_addr = s.accept()
        let conn = conn_and_addr[0]
        let addr = conn_and_addr[1]
        while True:
            let data = conn.recv(1024)
            let str_data = data.to_string()
            if not data:
                break
            
            let result = run(str_data)
            let send_back = py_builtins.bytes(result, "utf-8")
            # let send_back =  py_builtins.bytes("Hello, world!", "utf-8")
            
            _ = conn.sendall(send_back)