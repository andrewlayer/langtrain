from python import Python


fn call(prompt: String) raises -> String:
    let HOST = '127.0.0.1'
    let PORT = 65432

    let py_builtins = Python.import_module("builtins")
    let socket = Python.import_module("socket")

    let altered_prompt = "<|im_start|>user\n" + prompt + "<|im_end|>\n<|im_start|>assistant\n"

    let s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    _ = s.connect((HOST, PORT))
    _ = s.sendall(py_builtins.bytes(altered_prompt, "utf-8"))
    
    # Convert to Mojo String and remove b''
    var response = s.recv(1024).to_string()[2:-1]
    _ = s.close()

    # Add newlines and remove initial prompt
    response = response.replace("\\n", "\n")[len(altered_prompt):]
    return response


fn main() raises:
    let prompt = "Give me a python function to generate Fibonacci sequence"
    let response = call(prompt)
    print(response)
