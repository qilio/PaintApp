//
//  ViewController.swift
//  PaintApp
//
//  Created by Qili Ou on 1/5/19.
//  Copyright © 2019 Qili Ou. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    let canvas = Canvas()
    
    let undoBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Undo", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleUndoBtn), for: .touchUpInside)
        return button
    }()
     
    @objc fileprivate func handleUndoBtn() {
        print("undo btn clicked")
        canvas.undo()
    }
    
    let clearBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(handleClearBtn), for: .touchUpInside)
        return button
    }()
    
    @objc func handleClearBtn() {
        print("clear btn clicked")
        canvas.clear()
    }
    
    override func loadView() {
        self.view = canvas
    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set default bg color of canvas
        canvas.backgroundColor = .white
        
        setupLayout()
        
        
    }
    
    
    
    fileprivate func setupLayout() {
        let stackView = UIStackView(arrangedSubviews: [undoBtn,clearBtn])
        stackView.distribution = .fillEqually
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }


}



