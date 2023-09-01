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
        table.rowHeight = 50
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

    var editTaskButton = UIButton()
    var addNewTaskButton = UIButton()
    
    var tasksArray: [Task] = [
        Task(title: "Задача 1", description: "Описание 1"),
        Task(title: "Задача 2", description: "Описание 2"),
        Task(title: "Задача 3", description: "Описание 3"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        tableViewConfigure()
        warningLabelConfigure()
    }
    
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
                equalToConstant: (4 * tableView.rowHeight) + (CGFloat(tasksArray.count - 2) * tableView.rowHeight)
            )
        ])
    }
}

extension ListViewController: UITableViewDelegate {
    
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TaskTableViewCell.identifier) as! TaskTableViewCell
        
        cell.setData(task: tasksArray[indexPath.row])
        cell.accessoryType = .detailDisclosureButton
        
        return cell
    }

}

/*
 cell.textLabel?.text = tasksArray[indexPath.row]
 cell.detailTextLabel?.text = tasksArray[indexPath.row]
 
 // Create the accessory button
 
 
 // Add spacing between the accessory button and the text
 
 // Handle accessory button tap
 accessoryButton.addTarget(self, action: #selector(accessoryButtonTapped(sender:)), for: .touchUpInside)
 
 */
    // Function to handle accessory button tap
    //    @objc func accessoryButtonTapped(sender: UIButton) {
    //            // Handle the tap event here
    //        if let cell = sender.superview?.superview as? UITableViewCell,
    //           let indexPath = tableView.indexPath(for: cell) {
    //                // Use indexPath to identify the tapped cell
    //                // You can perform actions based on the tapped cell here
    //        }
    //    }
