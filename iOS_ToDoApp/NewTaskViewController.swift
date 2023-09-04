//
//  NewTaskViewController.swift
//  iOS_ToDoApp
//
//  Created by Nazerke Sembay on 01.09.2023.
//

import UIKit

class NewTaskViewController: UIViewController {

    let defaults = UserDefaults.standard
    let navigationBar = UINavigationBar()
    var tasksArray: [Task] = []
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Название"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Название"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let descriptionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Описание"
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.contentVerticalAlignment = .top
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/255, green: 244/255, blue: 247/255, alpha: 1)
        navBarConfigure()
        labelConfigure()
        configureTextFields()
        hideKeyboardWhenTappedAround()
        getTasks()
        print("new \(tasksArray)")
    }
}

//Constraints
extension NewTaskViewController {
    func configureTextFields() {
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextField)
        
        NSLayoutConstraint.activate([
            titleTextField.topAnchor.constraint(equalTo: label  .bottomAnchor, constant: 5),
            titleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        NSLayoutConstraint.activate([
            descriptionTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            descriptionTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
    }
    
    func labelConfigure() {
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 5),
            label.heightAnchor.constraint(equalToConstant: 20),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
    }
    
    func navBarConfigure() {
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButtonTapped))
        cancelButton.tintColor = .systemRed
        let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonTapped))
        
        view.addSubview(navigationBar)
        navigationBar.setItems([UINavigationItem(title: "")], animated: false)
        navigationBar.topItem?.setLeftBarButton(cancelButton, animated: false)
        navigationBar.topItem?.setRightBarButton(saveButton, animated: false)
        
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 44.0)
        ])
    }
    
    
}

// Functionality
extension NewTaskViewController {
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func saveButtonTapped() {
        tasksArray.append(
            Task(title: titleTextField.text!, description: descriptionTextField.text!)
        )
      
        do {
            let json = try JSONEncoder().encode(tasksArray)
            defaults.set(json, forKey: "tasks")
        } catch {
            print("Error encoder")
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func getTasks() {
        guard let data = defaults.data(forKey: "tasks") else {
            return
        }
        
        do {
            let tasks = try JSONDecoder().decode([Task].self, from: data)
            tasksArray = tasks
        } catch {
            print("error decode")
        }
    }
}
