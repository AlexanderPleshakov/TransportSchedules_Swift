//
//  TransportSelectionPanel.swift
//  TransportSchedules_Swift
//
//  Created by Александр Плешаков on 27.09.2024.
//

import UIKit

final class TransportSelectionPanel: UIView {
    private let anyButton = SelectButton(
        title: NSLocalizedString(
            "any",
            comment: ""
        )
    )
    
    private let airplaneButton = SelectButton(
        title: nil,
        type: .onlyImage,
        image: UIImage(
            systemName: "airplane.departure"
        )
    )
    
    private let trainButton = SelectButton(
        title: nil,
        type: .onlyImage,
        image: UIImage(
            systemName: "tram.fill"
        )
    )
    
    private let lightrailButton = SelectButton(
        title: nil,
        type: .onlyImage,
        image: UIImage(
            systemName: "lightrail.fill"
        )
    )
    
    private let busButton = SelectButton(
        title: nil,
        type: .onlyImage,
        image: UIImage(
            systemName: "bus.fill"
        )
    )
    
    // MARK: Init
    
    init() {
        super.init(frame: .zero)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    private func configure() {
        let buttons = [
            anyButton,
            airplaneButton,
            trainButton,
            lightrailButton,
            busButton
        ]
        buttons.forEach { button in
            button.addCornerRadius(6)
        }
        
        anyButton.addTarget(self, action: #selector(buttonAnyTapped), for: .touchUpInside)
        airplaneButton.addTarget(self, action: #selector(buttonAirplaneTapped), for: .touchUpInside)
        trainButton.addTarget(self, action: #selector(buttonTrainTapped), for: .touchUpInside)
        lightrailButton.addTarget(self, action: #selector(buttonLightrailTapped), for: .touchUpInside)
        busButton.addTarget(self, action: #selector(buttonBusTapped), for: .touchUpInside)
        
        let mainHStack = UIStackView(arrangedSubviews: buttons)
        
        mainHStack.axis = .horizontal
        mainHStack.spacing = 8
        mainHStack.distribution = .fill
        
        mainHStack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mainHStack)
        
        NSLayoutConstraint.activate([
            mainHStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainHStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainHStack.heightAnchor.constraint(equalToConstant: 50),
            
            airplaneButton.widthAnchor.constraint(equalToConstant: 56),
            trainButton.widthAnchor.constraint(equalToConstant: 56),
            lightrailButton.widthAnchor.constraint(equalToConstant: 56),
            busButton.widthAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    private func deselectButtons() {
        [anyButton,
         airplaneButton,
         trainButton,
         lightrailButton,
         busButton
        ].forEach { button in
            button.deselect()
        }
    }
    
    @objc private func buttonAnyTapped() {
        if !anyButton.isActive {
            deselectButtons()
            anyButton.select()
        }
    }
    
    @objc private func buttonAirplaneTapped() {
        if !airplaneButton.isActive {
            deselectButtons()
            airplaneButton.select()
        }
    }
    
    @objc private func buttonTrainTapped() {
        if !trainButton.isActive {
            deselectButtons()
            trainButton.select()
        }
    }
    
    @objc private func buttonLightrailTapped() {
        if !lightrailButton.isActive {
            deselectButtons()
            lightrailButton.select()
        }
    }
    
    @objc private func buttonBusTapped() {
        if !busButton.isActive {
            deselectButtons()
            busButton.select()
        }
    }
}
