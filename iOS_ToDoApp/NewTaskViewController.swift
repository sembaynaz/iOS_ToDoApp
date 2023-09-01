//
//  NewTaskViewController.swift
//  iOS_ToDoApp
//
//  Created by Nazerke Sembay on 01.09.2023.
//

import UIKit

class NewTaskViewController: UIViewController {
    let navigationBar = UINavigationBar()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        
        
    }
    
    func configure() {
        
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func saveButtonTapped() {
    }
}
/*
 let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelButtonTapped))
 cancelButton.tintColor = .systemRed
 let saveButton = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(saveButtonTapped))
 self.navigationItem.leftBarButtonItem = cancelButton
 self.navigationItem.rightBarButtonItem = saveButton
 */
