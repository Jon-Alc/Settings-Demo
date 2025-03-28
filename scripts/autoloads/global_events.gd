extends Node

# main menu signals
## MainMenuLabelPressed is raised when one of the labels in the Main Menu component is pressed. The
## label ID contains the enum ID of the label pressed.
signal MainMenuLabelPressed(label_id: GlobalEnums.MainMenuButtonID)
## SettingsSaveChangesPressed is raised when the Save Changes button in the Settings component is
## pressed.
signal SettingsSaveChangesPressed()
