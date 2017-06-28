//
//  WalkthroughPageThree.swift
//  HiringApp
//
//  Created by Santi Bernaldo on 27/06/2017.
//  Copyright © 2017 Visual Engineering. All rights reserved.
//

import UIKit
import BWWalkthrough

class WalkthroughPageThreeViewController: BWWalkthroughPageViewController {
    
    var presenter: WalkthroughPresenter?
    
    enum Constants {
        static let blueBackground : UIColor = UIColor(red: 101/255.0, green: 174/255.0, blue: 242/255.0, alpha: 1.0)
        static let labelsTextColor: UIColor = .white
        
        static let heightStackView : CGFloat = 0.6
        static let stackViewSpacing: CGFloat = 20.0
        static let stackViewSidesMargin: CGFloat = 40.0
        
        static let topLabelFontSize: CGFloat = 20.0
        static let bottomLabelFontSize: CGFloat = 14.0
        static let labelsFontType: String = "Arial"
    }
    
    let labelTop : UILabel = {
        let label = UILabel()
        label.text = "¿Dónde estamos?"
        label.font = UIFont(name: Constants.labelsFontType, size: Constants.topLabelFontSize)
        label.numberOfLines = 1
        label.sizeToFit()
        label.textAlignment = .center
        label.textColor = Constants.labelsTextColor
        return label
    }()
    
    let imageMapView : UIImageView = {
        let image = UIImage(named: "map-screenshot")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let labelBottom : UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        label.font = UIFont(name: Constants.labelsFontType, size: Constants.bottomLabelFontSize)
        label.numberOfLines = 3
        label.sizeToFit()
        label.textAlignment = .center
        label.textColor = Constants.labelsTextColor
        return label
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    //MARK: - Private API
    private func layout() {
        view.backgroundColor = .clear
        
        stackView.heightAnchor.constraint(equalToConstant: view.frame.size.height * Constants.heightStackView).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackViewSidesMargin).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.stackViewSidesMargin).isActive = true
    }
    
    private func setup() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOnMap))
        imageMapView.addGestureRecognizer(tapGesture)
        imageMapView.isUserInteractionEnabled = true
        
        view.addSubviewWithAutolayout(stackView)
        
        stackView.addArrangedSubview(labelTop)
        stackView.addArrangedSubview(imageMapView)
        stackView.addArrangedSubview(labelBottom)
    }
    
    override func walkthroughDidScroll(to position: CGFloat, offset: CGFloat) {
        var tr = CATransform3DIdentity
        tr.m34 = -1/500.0
        view.layer.transform = CATransform3DRotate(tr, CGFloat(Double.pi*2)  * (1.0 - offset), 0.5,1, 0.2)
    }
}

extension WalkthroughPageThreeViewController {
    func didTapOnMap() {
        presenter?.showModalMap()
    }
}
