//
//  ViewController.swift
//  StretchySnacks
//
//  Created by Alex Bearinger on 2017-02-16.
//  Copyright © 2017 Alex Bearinger. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var fakeNavBar: UIView!
    @IBOutlet weak var navBarHeight: NSLayoutConstraint!
    @IBOutlet weak var plusButtonProperty: UIButton!
    var stackView: UIStackView!
    var views = [UIImageView]()
    var open = false
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addImages()
        stackView = UIStackView(arrangedSubviews: views)
        stackView.isHidden = true
        fakeNavBar.addSubview(stackView)
        stackView.heightAnchor.constraint(equalTo: fakeNavBar.heightAnchor)
        stackView.widthAnchor.constraint(equalTo: fakeNavBar.widthAnchor)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
    }
    
    //MARK: Actions
    @IBAction func plusButton(_ sender: UIButton) {
        print("+ button pressed")
        if(open){
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.25, initialSpringVelocity: 3, options: .curveLinear, animations: {
                self.navBarHeight.constant = 66
                self.view.layoutIfNeeded()
                self.plusButtonProperty.transform = CGAffineTransform(rotationAngle: CGFloat(0))
                self.stackView.isHidden = true
            }) { _ in
                self.open = false
           
            }
        }
        else {
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.25, initialSpringVelocity: 3, options: .curveLinear, animations: {
                self.navBarHeight.constant = 200
                 self.view.layoutIfNeeded()
                self.plusButtonProperty.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI_4))
                self.stackView.isHidden = false
                self.stackView.bottomAnchor.constraint(equalTo: self.fakeNavBar.bottomAnchor)
            }) { _ in
                self.open = true
                
            }
        }
    }
    
    func addImages(){
        images.append(#imageLiteral(resourceName: "oreos"))
        images.append(#imageLiteral(resourceName: "pizza_pockets"))
        images.append(#imageLiteral(resourceName: "pop_tarts"))
        images.append(#imageLiteral(resourceName: "popsicle"))
        images.append(#imageLiteral(resourceName: "ramen"))
        for i in 0...4{
            let view = UIImageView()
            view.image = images[i]
            views.append(view)
        }
    }
    
}

