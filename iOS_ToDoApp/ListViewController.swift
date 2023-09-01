//
//  ViewController.swift
//  iOS_ToDoApp
//
//  Created by Nazerke Sembay on 01.09.2023.
//

import UIKit

class ListViewController: UIViewController {
    
    var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = 60
        table.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        table.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        table.layer.backgroundColor = UIColor.white.cgColor
        return table
    }()
    
    var warningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Создайте новую задачу, нажав на кнопку плюс"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    var editTaskButton: UIButton = {
        let button = UIButton()
        if let symbolImage = UIImage(systemName: "pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)) {
            button.setImage(symbolImage, for: .normal)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 25
        return button
    }()
    
    var addNewTaskButton: UIButton = {
        let button = UIButton()
        if let symbolImage = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)) {
            button.setImage(symbolImage, for: .normal)
        }
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        button.layer.cornerRadius = 25

        return button
    }()
    
    var tasksArray: [Task] = [
        Task(title: "Задача 1", description: "Описание 1"),
        Task(title: "Задача 2", description: "Описание 2"),
        Task(title: "Задача 3", description: "Описание 3"),
        Task(title: "Задача 1", description: "Описание 1"),
        Task(title: "Задача 2", description: "Описание 2"),
        Task(title: "Задача 3", description: "Описание 3"),
        Task(title: "Задача 1", description: "Описание 1")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableViewConfigure()
        warningLabelConfigure()
        addNewTaskButtonConstraints()
        editButtonCostraints()
    }
}

extension ListViewController {
    func warningLabelConfigure() {
        view.addSubview(warningLabel)
        
        NSLayoutConstraint.activate([
            warningLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
            warningLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            warningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
    }
    
    func tableViewConfigure() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.heightAnchor.constraint(
                equalToConstant: 200 + (CGFloat(tasksArray.count - 2) * tableView.rowHeight))
        ])
    }
    
    func editButtonCostraints() {
        view.addSubview(editTaskButton)
        
        NSLayoutConstraint.activate([
            editTaskButton.bottomAnchor.constraint(equalTo: addNewTaskButton.topAnchor, constant: -30),
            editTaskButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            editTaskButton.widthAnchor.constraint(equalToConstant: 50),
            editTaskButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func addNewTaskButtonConstraints() {
        view.addSubview(addNewTaskButton)
        addNewTaskButton.addTarget(self, action: #selector(addNewTaskButtonTouched), for: .touchDown)
        
        NSLayoutConstraint.activate([
            addNewTaskButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            addNewTaskButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addNewTaskButton.widthAnchor.constraint(equalToConstant: 50),
            addNewTaskButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tasksArray[indexPath.row].isComplpete.toggle()
        tableView.reloadData()
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as! TaskTableViewCell
        
        cell.setData(task: tasksArray[indexPath.row])
        cell.accessoryType = .detailDisclosureButton
        
        if tasksArray[indexPath.row].isComplpete {
            cell.accessoryButton.setBackgroundImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        } else {
            cell.accessoryButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        }
        
        return cell
    }
}

extension ListViewController {
    @objc func addNewTaskButtonTouched() {
        let vc = NewTaskViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    func editButtonTouched() {
        
    }
}
