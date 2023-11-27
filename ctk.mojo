from python import Python
    
struct State:
    var text: String

    fn __init__(inout self):
        self.text = ""

    fn set_text(inout self, text: String):
        self.text = text

def main():

    # "Imports"
    Python.add_to_path(".")
    let ctk = Python.import_module("ctk")
    let tk = Python.import_module("tkinter")
    let app = ctk.app

    # Mojo App State
    var state = State()
    
    # Configure Window
    app.title("LangTrain")
    app.geometry("800x1000")

    let title = ctk.CTkLabel("LangTrain", 0, 10, ("", 50), 300, tk.N)
    title.pack()

    let promptLabel = ctk.CTkLabel("Code Prompt:", 0, 10, ("", 10), 700, tk.W)
    promptLabel.pack()

    # Add Window Elements
    let prompt = ctk.CTkTextbox(100, 700)
    prompt.pack()

    ctk.CTkLabel(" ", 0, 10).pack() # "padding"

    let button = ctk.CTkButton("Generate Code", 300)
    button.pack()

    let generatedCode = ctk.CTkLabel("GeneratedCode:", 0, 10, ("", 10), 700, tk.W)
    generatedCode.pack()

    # Add Window Elements
    let codeBlock = ctk.CTkTextbox(500, 700)
    codeBlock.pack()

    # Run Loop
    while True:
        app.update()

        let text = prompt.get_text().to_string()
        state.set_text(text)

        if button.get_clicked():
            print(state.text)
            button.reset()


   
            


