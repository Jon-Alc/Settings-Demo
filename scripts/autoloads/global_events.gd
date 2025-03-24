extends Node

# main menu signals
## MainMenuLabelPressed is raised when one of the labels in the Main Menu component is pressed. The
## label ID contains the enum ID of the label pressed.
signal MainMenuLabelPressed(label_id: GlobalEnums.MainMenuButtonID)
## SettingsSaveChangesPressed is raised when the Save Changes button in the Settings component is
## pressed.
signal SettingsSaveChangesPressed()

## DisplayPromptButtonPressed is raised when either the Accept or Cancel button in the DisplayPrompt
## component is pressed.
signal DisplayPromptButtonPressed()
## DisplayPromptResponded is raised when the Accept or Cancel buttons in the DisplayPrompt component
## are pressed. The response is true if Accept is clicked, and false if Cancel is clicked.
signal DisplayPromptResponded(response: bool)
