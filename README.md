# iOS_ToDoApp

<img width = "245" height = "500" src = "https://github.com/sembaynaz/iOS_ToDoApp/assets/96616194/16ce05a4-c97c-48d8-8486-ce9227d52b48">
<img width = "245" height = "500" src = "https://github.com/sembaynaz/iOS_ToDoApp/assets/96616194/79a106fe-b242-4c78-a546-baf547497189">
<img width = "245" height = "500" src = "https://github.com/sembaynaz/iOS_ToDoApp/assets/96616194/b3fb47c0-851b-4f38-9d6d-1ce352a31ca1">
<img width = "245" height = "500" src = "https://github.com/sembaynaz/iOS_ToDoApp/assets/96616194/b3942afb-8fa9-4470-bceb-e1989c508b99">

## Project Description
This iOS to-do app provides a basic but functional to-do list management system with features for creating, editing, completing, and reordering tasks.

## Installation
No secondary libraries were used here, only **UIKit**. You can download the project from GitHub as a zip file and then open it in the **xCode** application. (No additional installations are required)

## Usage
Users can launch the app and see their existing tasks or start with an empty list.
To add a new task, users can tap the "+" button at the bottom right.
Tapping a task in the list marks it as complete and reorders it to the bottom.
In editing mode, users can reorder tasks by dragging and dropping, and they can delete tasks by swiping left.
Tapping the accessory button (info icon) allows users to edit task details in the NewTaskViewController.
Users can save or cancel task creation or editing in the NewTaskViewController.
Tasks are persisted between app launches using UserDefaults.

**Task Struct:** The project includes a Task struct that represents a to-do item. Each task has a title, description, and a boolean flag indicating whether it is marked as complete.

View Controllers:

**ListViewController:** This is the main view controller that displays a list of tasks. It includes the following features:
A table view that lists tasks.
Buttons for adding new tasks and toggling editing mode.
The ability to mark tasks as complete by tapping them.
Support for reordering tasks through drag-and-drop.
Deleting tasks by swiping left.
Access to edit task details by tapping an accessory button.

**NewTaskViewController:** This view controller is used for adding or editing tasks. It includes text fields for entering the task title and description and provides options to save or cancel the task creation/editing.

**User Defaults:** The project uses UserDefaults to store tasks persistently. Tasks are encoded and decoded as JSON data and stored in the user defaults.

**Navigation:** The project utilizes a navigation bar to navigate between view controllers. The "Отмена" (Cancel) and "Сохранить" (Save) buttons are included in the navigation bar.

## Contribution
Contributions to this project are welcome!
You can organize my code, add a new functionalities, user interface improvments,testing, error handling. 

## Author
git: sembaynaz

mail: nazerke.sembay11@gmail.com 

telegram: @sembaynaz
