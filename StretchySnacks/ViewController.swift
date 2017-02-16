//
//  ViewController.swift
//  StretchySnacks
//
//  Created by Alex Bearinger on 2017-02-16.
//  Copyright © 2017 Alex Bearinger. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    @IBOutlet weak var fakeNavBar: UIView!
    @IBOutlet weak var navBarHeight: NSLayoutConstraint!
    @IBOutlet weak var plusButtonProperty: UIButton!
    @IBOutlet weak var tableView: UITableView!
    let stackView = UIStackView()
    var views = [UIImageView]()
    var open = false
    var images = [UIImage]()
    var snacks = [String]()
    @IBOutlet weak var snacksLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addImages()
        setupStackView()
        tableView.delegate = self
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
                self.snacksLabel.text = "SNACKS"
                self.stackView.distribution = .equalCentering
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
                self.snacksLabel.text = "Add a SNACK"
                self.stackView.distribution = .fillEqually
            }) { _ in
                self.open = true
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snacks.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = snacks[indexPath.row]
        return cell
    }
    
    //MARK: Helper methods
    func addImages(){
        images.append(#imageLiteral(resourceName: "oreos"))
        images.append(#imageLiteral(resourceName: "pizza_pockets"))
        images.append(#imageLiteral(resourceName: "pop_tarts"))
        images.append(#imageLiteral(resourceName: "popsicle"))
        images.append(#imageLiteral(resourceName: "ramen"))
        
        for i in 0...4{
            let button = UIButton()
            button.imageView?.contentMode = .scaleAspectFit
            let image = images[i]
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
    }
    
    func setupStackView(){
        stackView.isHidden = true
        fakeNavBar.addSubview(stackView)
        
        stackView.widthAnchor.constraint(equalTo: fakeNavBar.widthAnchor).isActive = true
        stackView.centerXAnchor.constraint(equalTo: fakeNavBar.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: fakeNavBar.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: fakeNavBar.heightAnchor, multiplier: 0.7).isActive = true
        
        stackView.axis = .horizontal
        stackView.alignment = UIStackViewAlignment.center
        stackView.spacing = 0
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
}

