//
//  BucketSizeViewController.swift
//  Water Jug
//
//  Created by Gabriel on 22/03/2022.
//

import UIKit

class BucketSizeViewController: UIViewController {
    private var waterView: WaterJugView!
    private var titleLabel: UILabel!
    private var auxQuantityView: UIView!
    private var quantityLabel: UILabel!
    private var minusImageView: UIImageView!
    private var plusImageView: UIImageView!
    private var confirmButton: StyledButton!
    private var cancelButton: StyledAlternativeButton!
    private var jug: Jug
    var delegate: BucketSizeDelegate?
    
    private var quantity = 1
    
    required init(with jug: Jug) {
        self.jug = jug
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.backgroundColor
        
        initViews()
    }
    
    func initViews() {
        waterView = {
            let waterView = WaterJugView()
            waterView.translatesAutoresizingMaskIntoConstraints = false
            
            return waterView
        }()
        
        titleLabel = {
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.font = UIFont.titleFont
            titleLabel.textColor = UIColor.textColor
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
            titleLabel.lineBreakMode = .byWordWrapping
            switch jug {
            case .x:
                titleLabel.text = "Select Bucket X Size"
            case .y:
                titleLabel.text = "Select Bucket Y Size"
            case .z:
                titleLabel.text = "Select Bucket Z Size"
            }
            
            return titleLabel
        }()
        
        auxQuantityView = {
            let auxQuantityView = UIView()
            auxQuantityView.translatesAutoresizingMaskIntoConstraints = false
            return auxQuantityView
        }()
        
        quantityLabel = {
            let quantityLabel = UILabel()
            quantityLabel.translatesAutoresizingMaskIntoConstraints = false
            quantityLabel.font = UIFont.countFont
            quantityLabel.textColor = .black
            quantityLabel.text = "\(quantity)"
            return quantityLabel
        }()
        
        minusImageView = {
            let minusImageView = UIImageView()
            minusImageView.translatesAutoresizingMaskIntoConstraints = false
            minusImageView.contentMode = .scaleAspectFit
            minusImageView.image = UIImage(named: "minus")
            minusImageView.clipsToBounds = true
            return minusImageView
        }()
        
        plusImageView = {
            let plusImageView = UIImageView()
            plusImageView.translatesAutoresizingMaskIntoConstraints = false
            plusImageView.contentMode = .scaleAspectFit
            plusImageView.image = UIImage(named: "plus")
            plusImageView.clipsToBounds = true
            return plusImageView
        }()
        
        confirmButton = {
            let confirmButton = StyledButton()
            confirmButton.translatesAutoresizingMaskIntoConstraints = false
            confirmButton.setTitle("Confirm", for: .normal)
            confirmButton.addTarget(self, action: #selector(confirmButtonClicked), for: .touchUpInside)
            
            return confirmButton
        }()
        
        cancelButton = {
            let cancelButton = StyledAlternativeButton()
            cancelButton.translatesAutoresizingMaskIntoConstraints = false
            cancelButton.setTitle("Cancel", for: .normal)
            cancelButton.addTarget(self, action: #selector(cancelButtonClicked), for: .touchUpInside)
            
            return cancelButton
        }()
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        let gestureMinus:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(minusQuantityClicked))
        gestureMinus.numberOfTapsRequired = 1
        minusImageView.isUserInteractionEnabled = true
        minusImageView.addGestureRecognizer(gestureMinus)
        
        let gesturePlus:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(plusQuantityClicked))
        gesturePlus.numberOfTapsRequired = 1
        plusImageView.isUserInteractionEnabled = true
        plusImageView.addGestureRecognizer(gesturePlus)
        
        auxQuantityView.addSubview(minusImageView)
        auxQuantityView.addSubview(quantityLabel)
        auxQuantityView.addSubview(plusImageView)
        
        self.view.addSubview(waterView)
        self.view.addSubview(auxQuantityView)
        self.view.addSubview(titleLabel)
        self.view.addSubview(confirmButton)
        self.view.addSubview(cancelButton)
        
        NSLayoutConstraint.activate(
            [
                minusImageView.centerYAnchor.constraint(equalTo: auxQuantityView.centerYAnchor),
                minusImageView.leftAnchor.constraint(equalTo: auxQuantityView.leftAnchor, constant: 24),
                minusImageView.rightAnchor.constraint(equalTo: quantityLabel.leftAnchor, constant: -24),
                minusImageView.heightAnchor.constraint(equalToConstant: 48)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                quantityLabel.topAnchor.constraint(equalTo: auxQuantityView.topAnchor),
                quantityLabel.bottomAnchor.constraint(equalTo: auxQuantityView.bottomAnchor),
                quantityLabel.leftAnchor.constraint(equalTo: minusImageView.rightAnchor, constant: 24),
                quantityLabel.rightAnchor.constraint(equalTo: plusImageView.leftAnchor, constant: -24)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                plusImageView.centerYAnchor.constraint(equalTo: auxQuantityView.centerYAnchor),
                plusImageView.leftAnchor.constraint(equalTo: quantityLabel.rightAnchor, constant: 24),
                plusImageView.rightAnchor.constraint(equalTo: auxQuantityView.rightAnchor, constant: -24),
                plusImageView.heightAnchor.constraint(equalToConstant: 48)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                waterView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant:  96),
                waterView.heightAnchor.constraint(equalToConstant: 120),
                waterView.widthAnchor.constraint(equalToConstant: 120),
                waterView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -48),
                waterView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(equalTo: waterView.bottomAnchor, constant: 48),
                titleLabel.bottomAnchor.constraint(equalTo: auxQuantityView.topAnchor, constant: -24),
                titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48),
                titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -48)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                auxQuantityView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
                auxQuantityView.bottomAnchor.constraint(lessThanOrEqualTo: confirmButton.topAnchor, constant: -64.0),
                auxQuantityView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                confirmButton.topAnchor.constraint(greaterThanOrEqualTo: auxQuantityView.bottomAnchor, constant: 64),
                confirmButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -24),
                confirmButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64),
                confirmButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -64)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                cancelButton.topAnchor.constraint(equalTo: confirmButton.bottomAnchor, constant: 24),
                cancelButton.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
                cancelButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64),
                cancelButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -64)
            ]
        )
    }
    
    @objc func minusQuantityClicked() {
        if quantity > 1 {
            quantity -= 1
        }
        quantityLabel.text = "\(quantity)"
    }
        
    @objc func plusQuantityClicked() {
        quantity += 1
        quantityLabel.text = "\(quantity)"
    }
    
    @objc
    func confirmButtonClicked() {
        delegate?.newBucketSize(jug, value: quantity)
        dismiss(animated: true)
    }
    
    @objc
    func cancelButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
}
