//
//  ViewController.swift
//  iOS_ToDoApp
//
//  Created by Nazerke Sembay on 01.09.2023.
//

import UIKit

class ListViewController: UIViewController {
    
    let defaults = UserDefaults.standard
    var tasksArray: [Task] = []
    var height = 60
    
    var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = 60
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableViewConfigure()
        addNewTaskButtonConstraints()
        editButtonCostraints()
        getTasks()
        tableView.reloadData()
    }
}

extension ListViewController {
    func warningLabelConfigure() {
        tableView.addSubview(warningLabel)
        NSLayoutConstraint.activate([
//            warningLabel.topAnchor.constraint(equalTo: tableView.tableFooterView!.bottomAnchor),
            warningLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            warningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            warningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30)
        ])
    }
    
    func tableViewConfigure() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        warningLabelConfigure()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0)
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

extension ListViewController {
    func getTasks() {
        guard let data = defaults.data(forKey: "tasks") else {
            return
        }
        
        do {
            let tasks = try JSONDecoder().decode([Task].self, from: data)
            tasksArray = tasks
            height *= tasksArray.count
        } catch {
            print("error decode")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTasks()
        tableView.reloadData()
    }
}
