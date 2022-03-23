//
//  SimulationViewController.swift
//  Water Jug
//
//  Created by Gabriel on 22/03/2022.
//

import UIKit

class SimulationViewController: UIViewController {
    private var waterXView: WaterJugView!
    private var waterYView: WaterJugView!
    private var titleJugXLabel: UILabel!
    private var titleJugYLabel: UILabel!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var nextButton: StyledButton!
    private var previousButton: StyledButton!
    private var cancelButton: StyledAlternativeButton!
    private var waterJugViewModel: WaterJugViewModel!
    
    required init(with waterJugViewModel: WaterJugViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.waterJugViewModel = waterJugViewModel

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.backgroundColor
        
        initViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        waterJugViewModel.resetIndex()
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
        
        titleLabel = {
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.font = UIFont.titleFont
            titleLabel.textColor = UIColor.textColor
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.text = "Target Z: \(waterJugViewModel.target)"
            
            return titleLabel
        }()
        
        descriptionLabel = {
            let descriptionLabel = UILabel()
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.font = UIFont.subTitleFont
            descriptionLabel.textColor = UIColor.textColor
            descriptionLabel.textAlignment = .center
            descriptionLabel.numberOfLines = 0
            descriptionLabel.lineBreakMode = .byWordWrapping
            descriptionLabel.text = ""
            
            return descriptionLabel
        }()
        
        titleJugXLabel = {
            let titleJugXLabel = UILabel()
            titleJugXLabel.translatesAutoresizingMaskIntoConstraints = false
            titleJugXLabel.font = UIFont.descriptionFont
            titleJugXLabel.textColor = UIColor.textColor
            titleJugXLabel.textAlignment = .center
            titleJugXLabel.numberOfLines = 0
            titleJugXLabel.lineBreakMode = .byWordWrapping
            titleJugXLabel.text = "Bucket X: 0"
            
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
            titleJugYLabel.text = "Bucket Y: 0"
            
            return titleJugYLabel
        }()
        
        nextButton = {
            let nextButton = StyledButton()
            nextButton.translatesAutoresizingMaskIntoConstraints = false
            nextButton.setTitle("Next Step", for: .normal)
            nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
            
            return nextButton
        }()
        
        previousButton = {
            let previousButton = StyledButton()
            previousButton.translatesAutoresizingMaskIntoConstraints = false
            previousButton.setTitle("Previous Step", for: .normal)
            previousButton.addTarget(self, action: #selector(previousButtonClicked), for: .touchUpInside)
            
            return previousButton
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
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(nextButton)
        self.view.addSubview(previousButton)
        self.view.addSubview(cancelButton)
        
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
                titleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant:  48),
                titleLabel.bottomAnchor.constraint(equalTo: auxView.topAnchor, constant: -48),
                titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48),
                titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -48)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                auxView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 48),
                auxView.bottomAnchor.constraint(lessThanOrEqualTo: descriptionLabel.topAnchor, constant: -32),
                auxView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
                auxView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -0)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                descriptionLabel.topAnchor.constraint(equalTo: auxView.bottomAnchor, constant: 32),
                descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: nextButton.topAnchor, constant: -64),
                descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48),
                descriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -48)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                nextButton.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 64),
                nextButton.bottomAnchor.constraint(equalTo: previousButton.topAnchor, constant: -24),
                nextButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64),
                nextButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -64)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                previousButton.topAnchor.constraint(equalTo: nextButton.bottomAnchor, constant: 24),
                previousButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -24),
                previousButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64),
                previousButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -64)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                cancelButton.topAnchor.constraint(equalTo: previousButton.bottomAnchor, constant: 24),
                cancelButton.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
                cancelButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64),
                cancelButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -64)
            ]
        )
    }
    
    func showStep(_ step: Step?) {
        guard let step = step else { return }
        guard let waterProgress = self.waterJugViewModel.getWaterProgress(step: step) else { return }

        self.waterXView.setProgress(waterProgress.x)
        self.waterYView.setProgress(waterProgress.y)
        
        self.titleJugXLabel.text = "Bucket X: \(step.x)"
        self.titleJugYLabel.text = "Bucket Y: \(step.y)"
        self.descriptionLabel.text = "\(waterJugViewModel.currentStepdescription)"
    }
    
    @objc
    func nextButtonClicked() {
        showStep(waterJugViewModel.getNextStep())
    }
    
    @objc
    func previousButtonClicked() {
        showStep(waterJugViewModel.getPreviousStep())
    }
    
    @objc
    func cancelButtonClicked() {
        dismiss(animated: true, completion: nil)
    }
}
