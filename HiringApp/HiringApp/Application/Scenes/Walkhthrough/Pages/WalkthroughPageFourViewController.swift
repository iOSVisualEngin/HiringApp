//
//  WalkthroughPageFour.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit
import BWWalkthrough

class WalkthroughPageFourViewController: BWWalkthroughPageViewController {
    
    weak var delegate: WalkthoughViewControllerDelegate?

    enum Constants {
        static let buttonBackgroundColor: UIColor = .white
        static let buttonFontColor: UIColor = UIColor(red: 101/255.0, green: 174/255.0, blue: 242/255.0, alpha: 1.0)
        
        static let stackViewSpacing: CGFloat = 100.0
        static let stackViewSidesMargin: CGFloat = 30.0
        static let stackViewHeightAnchorMultiplier: CGFloat = 0.3
        
        static let buttonsFontSize: CGFloat = 16.0
        static let buttonsFontType: String = "Arial"
    }
    
    let buttonTop: RoundedButton = {
        let button = RoundedButton()
        button.setTitle(R.string.localizable.walkthrough_knowMoreButton(), for: .normal)
        button.backgroundColor = Constants.buttonBackgroundColor
        button.setTitleColor(Constants.buttonFontColor, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.buttonsFontType, size: Constants.buttonsFontSize)
        button.addTarget(self, action: #selector(didTouchKnowMoreButton), for: .touchUpInside)
        return button
    }()
    
    let buttonBottom: RoundedButton = {
        let button = RoundedButton()
        button.setTitle(R.string.localizable.walkthrough_workWithUsButton(), for: .normal)
        button.backgroundColor = Constants.buttonBackgroundColor
        button.setTitleColor(Constants.buttonFontColor, for: .normal)
        button.titleLabel?.font = UIFont(name: Constants.buttonsFontType, size: Constants.buttonsFontSize)
        button.addTarget(self, action: #selector(didTouchWorkWithUsButton), for: .touchUpInside)
        return button
    }()
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        setup()
        layout()
        setupWalkthroughTransitionValues()
        
        super.viewDidLoad()
    }
    
    //MARK: - Private API
    private func layout() {
        buttonTop.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackViewSidesMargin).isActive = true
        buttonTop.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.stackViewSidesMargin).isActive = true
        buttonTop.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        buttonTop.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.frame.height*CGFloat(0.1)).isActive = true

        buttonBottom.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackViewSidesMargin).isActive = true
        buttonBottom.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.stackViewSidesMargin).isActive = true
        buttonBottom.topAnchor.constraint(equalTo: buttonTop.bottomAnchor, constant: view.frame.height*CGFloat(0.2)).isActive = true
        buttonBottom.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    }
    
    private func setupWalkthroughTransitionValues(){
        let speed = CGPoint(x: 0, y: 1)
        let speedVariance = CGPoint(x:0, y: 1)
        let animationType = "Zoom"
        let animateAlpha = true
        
        self.setValue(speed, forKey: "speed")
        self.setValue(speedVariance, forKey: "speedVariance")
        self.setValue(animationType, forKey: "animationType")
        self.setValue(animateAlpha, forKey: "animateAlpha")
    }
    
    private func setup() {
        view.backgroundColor = .clear
        
        view.addSubviewWithAutolayout(buttonTop)
        view.addSubviewWithAutolayout(buttonBottom)
    }

    func didTouchKnowMoreButton() {
        delegate?.didClickOnKnowMoreFromUs()
    }
    
    func didTouchWorkWithUsButton() {
        delegate?.didClickOnWorkWithUs()
    }
}