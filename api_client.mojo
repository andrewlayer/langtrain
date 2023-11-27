from python import Python


fn test_call(prompt: String) raises -> String:
    let HOST = '127.0.0.1'
    let PORT = 65432

    let py_builtins = Python.import_module("builtins")
    let socket = Python.import_module("socket")

    let s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    _ = s.connect((HOST, PORT))
    _ = s.sendall(py_builtins.bytes(prompt, "utf-8"))
    let response = s.recv(1024).to_string()[2:-1]
    _ = s.close()

    return response


fn main() raises:
    let prompt = "<|im_start|>user\nGive me a python function to generate Fibonacci sequence<|im_end|>\n<|im_start|>assistant\n"
    let response = test_call(prompt)
    print(response)
