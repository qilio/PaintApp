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
    
    // undo button with closure
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
    
    //clear button
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
    
    // yellow button
    let yellowBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    // red button
    let redBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    // blue button
    let blueBtn: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .blue
        button.layer.borderWidth = 1
        button.addTarget(self, action: #selector(handleColorChange), for: .touchUpInside)
        return button
    }()
    
    @objc fileprivate func handleColorChange(colorButton: UIButton) {
        canvas.setStrokeColor(color: colorButton.backgroundColor ?? .black)
        
    }
    // slider
    let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.addTarget(self, action: #selector(handleSliderChange), for: .valueChanged)
        return slider
    }()
    
    @objc fileprivate func handleSliderChange() {
        print("slider value: \(slider.value)")
        canvas.setStrokeWidth(width: slider.value)
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
        
        let colorStackview = UIStackView(arrangedSubviews: [redBtn,yellowBtn,blueBtn])
        colorStackview.distribution = .fillEqually
        let stackView = UIStackView(arrangedSubviews: [undoBtn,colorStackview,clearBtn,slider])
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }


}



