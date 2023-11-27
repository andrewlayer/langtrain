from python import Python

from api_client import call
    
struct State:
    var prompt: String
    var code: String

    fn __init__(inout self):
        self.prompt = ""
        self.code = ""

    fn set_prompt(inout self, prompt: String):
        self.prompt = prompt

    fn set_code(inout self, code: String):
        self.code = code

def main():

    # "Imports"
    Python.add_to_path(".")
    let ctk = Python.import_module("ctk")
    let tk = Python.import_module("tkinter")
    let helpers = Python.import_module("helpers")
    let os = Python.import_module("os")
    let app = ctk.app

    # Mojo App State
    var state = State()
    let cases = Python.dict()
    
    # Configure Window
    app.title("LangTrain")
    app.geometry("800x1100")

    let title = ctk.CTkLabel("LangTrain", 0, 10, ("", 50), 300, tk.N)
    title.pack()

    let promptLabel = ctk.CTkLabel("Code Prompt:", 0, 10, ("", 10), 700, tk.W)
    promptLabel.pack()

    # Add Window Elements
    let prompt = ctk.CTkTextbox(100, 700)
    prompt.pack()

    ctk.CTkSpacer().pack()


    let generatedCode = ctk.CTkLabel("GeneratedCode:", 0, 10, ("", 10), 700, tk.W)
    generatedCode.pack()

    # Add Window Elements
    let codeBlock = ctk.CTkTextbox(400, 700)
    codeBlock.pack()

    ctk.CTkSpacer().pack()

    let outputLabel = ctk.CTkLabel("Output:", 0, 10, ("", 10), 700, tk.W)
    outputLabel.pack()

    let output = ctk.CTkTextbox(100, 700)
    output.pack()

    ctk.CTkSpacer().pack()

    let button = ctk.CTkButton("Generate Code", 300)
    button.pack()

    ctk.CTkSpacer().pack()

    let run = ctk.CTkButton("Run", 300)
    run.pack()

    ctk.CTkSpacer().pack()

    let save = ctk.CTkButton("Save", 300)
    save.pack()

    # Run Loop
    while True:
        app.update()

        let prompt = prompt.get_text().to_string()
        state.set_prompt(prompt)

        let code = codeBlock.get_text().to_string()
        state.set_code(code)


        if button.get_clicked():
            let response = call(state.prompt)

            codeBlock.delete('1.0', tk.END)
            codeBlock.insert('1.0', response)

            print(state.prompt)
            button.reset()

        if save.get_clicked():
            cases[state.prompt] = code
            json = helpers.convert_to_json(cases.items())
            with open("./cases.json", "w") as f:
                f.write(json.to_string())
            save.reset()

        if run.get_clicked():
            with open("./code.py", "w") as f:
                f.write(state.code)
                outcome = os.system("bash ./interpreters/pythonInterpreter.bash " + state.code)
                print(outcome)
            
            run.reset()

        