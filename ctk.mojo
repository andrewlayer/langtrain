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
    let app = ctk.app

    # Mojo App State
    var state = State()
    
    # Configure Window
    app.title("my app")
    app.geometry("1400x1000")

    # Add Window Elements
    let prompt = ctk.CTkTextbox()
    prompt.pack()

    let label = ctk.CTkLabel(state.text)
    label.pack()

    let button = ctk.CTkButton("Print Text")
    button.pack()

    # Run Loop
    while True:
        app.update()

        let text = prompt.get_text().to_string()
        state.set_text(text)

        if button.get_clicked():
            print(state.text)
            label.configure(state.text)
            button.reset()


   
            


