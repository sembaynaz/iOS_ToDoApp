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
    var isStartChange = false
    
    var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.rowHeight = 60
        table.register(TaskTableViewCell.self, forCellReuseIdentifier: TaskTableViewCell.identifier)
        table.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        table.layer.backgroundColor = UIColor.white.cgColor
        table.allowsSelectionDuringEditing = true
        return table
    }()
    
    lazy var editTaskButton: UIButton = {
        let button = UIButton()
        if let symbolImage = UIImage(systemName: "pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)) {
            button.setImage(symbolImage, for: .normal)
        }
        button.addTarget(self, action: #selector(editButtonTouched), for: .touchDown)
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
    
    let warningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Создайте новую задачу, нажав на кнопку плюс"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        return label
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getTasks()
        tableView.reloadData()
    }
}

//MARK: Constraints
extension ListViewController {
    func tableViewConfigure() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        footerView.addSubview(warningLabel)
        tableView.tableFooterView = footerView
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
        
        NSLayoutConstraint.activate([
            warningLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 0),
            warningLabel.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -30),
            warningLabel.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 30),
            warningLabel.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: 0)
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

//MARK: TablView Delegate and Data Source
extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tasksArray[indexPath.row].isComplpete.toggle()
        if tasksArray[indexPath.row].isComplpete {
            let task = tasksArray.remove(at: indexPath.row)
            tasksArray.append(task)
        }
        
        saveTasks()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        tasksArray.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        saveTasks()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasksArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.reloadData()
            saveTasks()
        }
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let vc = NewTaskViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.editedIndex = indexPath.row
        vc.isEditTask = true
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
        cell.isChangeConstraints = isStartChange
        
        if tasksArray[indexPath.row].isComplpete {
            cell.accessoryButton.setBackgroundImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        } else {
            cell.accessoryButton.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        }
        
        return cell
    }
}

//MARK: Functions
extension ListViewController {
    @objc func addNewTaskButtonTouched() {
        let vc = NewTaskViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func editButtonTouched() {
        if isStartChange {
            tableView.isEditing = false
            isStartChange = false
            if let symbolImage = UIImage(systemName: "pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)) {
                editTaskButton.setImage(symbolImage, for: .normal)
            }
            addNewTaskButton.isHidden = false
            tableView.reloadData()
        } else {
            tableView.isEditing = true
            isStartChange = true
            if let symbolImage = UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)) {
                editTaskButton.setImage(symbolImage, for: .normal)
            }
            addNewTaskButton.isHidden = true
            tableView.reloadData()
        }
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
    
    func saveTasks() {
        do {
            let json = try JSONEncoder().encode(tasksArray)
            defaults.set(json, forKey: "tasks")
        } catch {
            print("Error encoder")
        }
    }
}
