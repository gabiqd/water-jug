//
//  SelectBucketViewController.swift
//  Water Jug
//
//  Created by Gabriel on 22/03/2022.
//

import UIKit

class SelectBucketViewController: UIViewController {
    private var waterXView: WaterJugView!
    private var waterYView: WaterJugView!
    private var waterZView: WaterJugView!
    private var titleJugXLabel: UILabel!
    private var titleJugYLabel: UILabel!
    private var titleJugZLabel: UILabel!
    private var titleLabel: UILabel!
    private var confirmButton: StyledButton!
    
    private var selectBucketViewModel = SelectBucketViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.backgroundColor
        
        initViews()
    }
    
    func initViews() {
        waterXView = {
            let waterXView = WaterJugView()
            waterXView.translatesAutoresizingMaskIntoConstraints = false
            
            return waterXView
        }()
        
        waterYView = {
            let waterYView = WaterJugView()
            waterYView.translatesAutoresizingMaskIntoConstraints = false
            
            return waterYView
        }()
        
        waterZView = {
            let waterZView = WaterJugView()
            waterZView.translatesAutoresizingMaskIntoConstraints = false

            return waterZView
        }()
        
        titleLabel = {
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.font = UIFont.titleFont
            titleLabel.textColor = UIColor.textColor
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.text = "Select Bucket"
            
            return titleLabel
        }()
        
        titleJugXLabel = {
            let titleJugXLabel = UILabel()
            titleJugXLabel.translatesAutoresizingMaskIntoConstraints = false
            titleJugXLabel.font = UIFont.descriptionFont
            titleJugXLabel.textColor = UIColor.textColor
            titleJugXLabel.textAlignment = .center
            titleJugXLabel.numberOfLines = 0
            titleJugXLabel.lineBreakMode = .byWordWrapping
            titleJugXLabel.text = "Bucket X: \(selectBucketViewModel.x)"
            
            return titleJugXLabel
        }()
        
        titleJugYLabel = {
            let titleJugYLabel = UILabel()
            titleJugYLabel.translatesAutoresizingMaskIntoConstraints = false
            titleJugYLabel.font = UIFont.descriptionFont
            titleJugYLabel.textColor = UIColor.textColor
            titleJugYLabel.textAlignment = .center
            titleJugYLabel.numberOfLines = 0
            titleJugYLabel.lineBreakMode = .byWordWrapping
            titleJugYLabel.text = "Bucket Y: \(selectBucketViewModel.y)"
            
            return titleJugYLabel
        }()
        
        titleJugZLabel = {
            let titleJugZLabel = UILabel()
            titleJugZLabel.translatesAutoresizingMaskIntoConstraints = false
            titleJugZLabel.font = UIFont.descriptionFont
            titleJugZLabel.textColor = UIColor.textColor
            titleJugZLabel.textAlignment = .center
            titleJugZLabel.numberOfLines = 0
            titleJugZLabel.lineBreakMode = .byWordWrapping
            titleJugZLabel.text = "Bucket Z: \(selectBucketViewModel.z)"

            return titleJugZLabel
        }()
        
        confirmButton = {
            let confirmButton = StyledButton()
            confirmButton.translatesAutoresizingMaskIntoConstraints = false
            confirmButton.setTitle("Confirm", for: .normal)
            confirmButton.addTarget(self, action: #selector(confirmButtonClicked), for: .touchUpInside)
            confirmButton.isHidden = !selectBucketViewModel.hasRequiredValues
            
            return confirmButton
        }()
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        let gestureXJug:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureXJugClicked))
        gestureXJug.numberOfTapsRequired = 1
        waterXView.isUserInteractionEnabled = true
        waterXView.addGestureRecognizer(gestureXJug)
        
        let gestureYJug:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureYJugClicked))
        gestureYJug.numberOfTapsRequired = 1
        waterYView.isUserInteractionEnabled = true
        waterYView.addGestureRecognizer(gestureYJug)
        
        let gestureZJug:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureZJugClicked))
        gestureZJug.numberOfTapsRequired = 1
        waterZView.isUserInteractionEnabled = true
        waterZView.addGestureRecognizer(gestureZJug)
        
        let auxView: UIView = {
            let auxView = UIView()
            auxView.translatesAutoresizingMaskIntoConstraints = false
            return auxView
        }()
        
        self.view.addSubview(titleLabel)
        self.view.addSubview(auxView)
        auxView.addSubview(waterXView)
        auxView.addSubview(waterYView)
        auxView.addSubview(titleJugXLabel)
        auxView.addSubview(titleJugYLabel)
        self.view.addSubview(waterZView)
        self.view.addSubview(titleJugZLabel)
        self.view.addSubview(confirmButton)
        
        NSLayoutConstraint.activate(
            [
                waterXView.topAnchor.constraint(equalTo: auxView.topAnchor),
                waterXView.heightAnchor.constraint(equalToConstant: 120),
                waterXView.widthAnchor.constraint(equalToConstant: 120),
                waterXView.bottomAnchor.constraint(equalTo: titleJugXLabel.topAnchor, constant: -16),
                waterXView.leadingAnchor.constraint(equalTo: auxView.leadingAnchor, constant: 24),
                waterXView.trailingAnchor.constraint(lessThanOrEqualTo: waterYView.leadingAnchor, constant: -24)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                titleJugXLabel.topAnchor.constraint(equalTo: waterXView.bottomAnchor, constant: 16),
                titleJugXLabel.bottomAnchor.constraint(equalTo: auxView.bottomAnchor),
                titleJugXLabel.centerXAnchor.constraint(equalTo: waterXView.centerXAnchor)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                waterYView.topAnchor.constraint(equalTo: auxView.topAnchor),
                waterYView.heightAnchor.constraint(equalToConstant: 120),
                waterYView.widthAnchor.constraint(equalToConstant: 120),
                waterYView.bottomAnchor.constraint(equalTo: titleJugYLabel.topAnchor, constant: -16),
                waterYView.trailingAnchor.constraint(equalTo: auxView.trailingAnchor, constant: -24),
                waterYView.leadingAnchor.constraint(greaterThanOrEqualTo: waterXView.trailingAnchor, constant: 24)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                titleJugYLabel.topAnchor.constraint(equalTo: waterYView.bottomAnchor, constant: 16),
                titleJugYLabel.bottomAnchor.constraint(equalTo: auxView.bottomAnchor),
                titleJugYLabel.centerXAnchor.constraint(equalTo: waterYView.centerXAnchor)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                waterZView.topAnchor.constraint(equalTo: auxView.bottomAnchor, constant: 32),
                waterZView.heightAnchor.constraint(equalToConstant: 120),
                waterZView.widthAnchor.constraint(equalToConstant: 120),
                waterZView.bottomAnchor.constraint(equalTo: titleJugZLabel.topAnchor, constant: -16),
                waterZView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
            ]
        )

        NSLayoutConstraint.activate(
            [
                titleJugZLabel.topAnchor.constraint(equalTo: waterZView.bottomAnchor, constant: 16),
                titleJugZLabel.bottomAnchor.constraint(lessThanOrEqualTo: confirmButton.topAnchor, constant: -64),
                titleJugZLabel.centerXAnchor.constraint(equalTo: waterZView.centerXAnchor)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant:  48),
                titleLabel.bottomAnchor.constraint(equalTo: auxView.topAnchor, constant: -48),
                titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48),
                titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -48)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                auxView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),
                auxView.bottomAnchor.constraint(equalTo: waterZView.topAnchor, constant: -32),
                auxView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                auxView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -0)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                confirmButton.topAnchor.constraint(greaterThanOrEqualTo: titleJugZLabel.bottomAnchor, constant: 64),
                confirmButton.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
                confirmButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64),
                confirmButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -64)
            ]
        )
    }
    
    @objc
    func gestureXJugClicked() {
        let viewController = BucketSizeViewController(with: .x)
        viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc
    func gestureYJugClicked() {
        let viewController = BucketSizeViewController(with: .y)
        viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc
    func gestureZJugClicked() {
        let viewController = BucketSizeViewController(with: .z)
        viewController.delegate = self
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc
    func confirmButtonClicked() {
        let waterJugViewModel = selectBucketViewModel.makeWaterJugViewModel()
        let viewController = ResultViewController(with: waterJugViewModel)
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SelectBucketViewController: BucketSizeDelegate {
    func newBucketSize(_ jug: Jug, value: Int) {
        selectBucketViewModel.updateValue(jug: jug, value: value)
        
        switch jug {
        case .x:
            titleJugXLabel.text = "Bucket X: \(selectBucketViewModel.x)"
        case .y:
            titleJugYLabel.text = "Bucket Y: \(selectBucketViewModel.y)"
        case .z:
            titleJugZLabel.text = "Bucket Z: \(selectBucketViewModel.z)"
        }
        
        confirmButton.isHidden = !selectBucketViewModel.hasRequiredValues
    }
}

