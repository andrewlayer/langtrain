import customtkinter
import tkinter as tk
import uuid
import time
import customtkinter


ctk = customtkinter
app = ctk.CTk()


class CTkButton(customtkinter.CTkButton):
    """
    A extension for customtkinter Button for use in Mojo

    Attributes:
        clicked (bool): Indicates whether the button has been clicked.
    """

    def __init__(self, text, width=150, *args, **kwargs):
        super().__init__(app, text=text, width=width, *args, **kwargs)

        self.clicked = False
        self._command = lambda: self.set_clicked(True)

    def set_clicked(self, value: bool):
        self.clicked = value

    def get_clicked(self):
        return self.clicked

    def reset(self):
        self.clicked = False


class CTkTextbox(customtkinter.CTkTextbox):
    """
    A extension for customtkinter Textbox for use in Mojo

    Attributes:
        text_changed (bool): Indicates if the text in the textbox has changed
    """

    def __init__(self, height=100, width=100, *args, **kwargs):
        super().__init__(app, height=height, width=width, *args, **kwargs)

        self.text_changed = False

    def get_text(self) -> str:
        return self.get("1.0", 'end-1c')


class CTkLabel(customtkinter.CTkLabel):
    def __init__(self, text, padx, pady, font=("", 12), width=100, anchor=tk.W, *args, **kwargs):
        super().__init__(app, text=text, font=font, width=width, anchor=anchor, padx=padx, pady=pady, *args, **kwargs)
        
    def configure(self, newtext, *args, **kwargs):
        return super().configure(text=newtext, *args, **kwargs)

class CTkSpacer(customtkinter.CTkLabel):
    def __init__(self, size=12):
        super().__init__(app, text="", font=("", size))
