//
//  TaskTableViewCell.swift
//  iOS_ToDoApp
//
//  Created by Nazerke Sembay on 01.09.2023.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    public static let identifier = "TaskTableViewCell"
    private var accessoryButtonLeadingConstraint: NSLayoutConstraint!

    var isChangeConstraints: Bool = false {
        didSet {
            if isChangeConstraints {
                accessoryButtonLeadingConstraint.constant = 50
            } else {
                accessoryButtonLeadingConstraint.constant = 10
            }
        }
    }
    
    let stackLabel: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 2
        return stack
    }()
    
    let accessoryButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemYellow
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(accessoryButton)
        buttonConstraints()
        accessoryButtonLeadingConstraint = accessoryButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        accessoryButtonLeadingConstraint.isActive = true
        
        addSubview(stackLabel)
        stackLabel.addArrangedSubview(titleLabel)
        stackLabel.addArrangedSubview(descriptionLabel)
        stackConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(task: Task) {
        titleLabel.text = task.title
        descriptionLabel.text = task.description
    }
    
    func buttonConstraints() {
        NSLayoutConstraint.activate([
            accessoryButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            accessoryButton.widthAnchor.constraint(equalToConstant: 25),
            accessoryButton.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    
    func stackConstraints() {
        NSLayoutConstraint.activate([
            stackLabel.leadingAnchor.constraint(equalTo: accessoryButton.trailingAnchor, constant: 10),
            stackLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
