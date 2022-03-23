//
//  ResultViewController.swift
//  Water Jug
//
//  Created by Gabriel on 22/03/2022.
//

import UIKit

class ResultViewController: UIViewController {
    private var resultEmojiLabel: UILabel!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var simulateButton: StyledButton!
    private var retryButton: StyledAlternativeButton!
    
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
        
        self.view.backgroundColor = .backgroundColor
        
        initViews()
    }
    
    func initViews() {
        resultEmojiLabel = {
            let resultEmojiLabel = UILabel()
            resultEmojiLabel.translatesAutoresizingMaskIntoConstraints = false
            resultEmojiLabel.font = UIFont.systemFont(ofSize: 96)
            resultEmojiLabel.textColor = UIColor.textColor
            resultEmojiLabel.textAlignment = .center
            resultEmojiLabel.numberOfLines = 1
            resultEmojiLabel.text = waterJugViewModel.emoji
            
            return resultEmojiLabel
        }()
        
        titleLabel = {
            let titleLabel = UILabel()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.font = UIFont.titleFont
            titleLabel.textColor = UIColor.textColor
            titleLabel.textAlignment = .center
            titleLabel.numberOfLines = 0
            titleLabel.lineBreakMode = .byWordWrapping
            titleLabel.text = waterJugViewModel.resultTitle
            
            return titleLabel
        }()
        
        descriptionLabel = {
            let descriptionLabel = UILabel()
            descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
            descriptionLabel.font = UIFont.descriptionFont
            descriptionLabel.textColor = UIColor.textColor
            descriptionLabel.textAlignment = .center
            descriptionLabel.numberOfLines = 0
            descriptionLabel.lineBreakMode = .byWordWrapping
            descriptionLabel.text = waterJugViewModel.resultDescription
            
            return descriptionLabel
        }()
        
        simulateButton = {
            let simulateButton = StyledButton()
            simulateButton.translatesAutoresizingMaskIntoConstraints = false
            simulateButton.setTitle("Simulate", for: .normal)
            simulateButton.addTarget(self, action: #selector(simulateButtonClicked), for: .touchUpInside)
            simulateButton.isHidden = !waterJugViewModel.hasFoundSolution
            
            return simulateButton
        }()
        
        retryButton = {
            let retryButton = StyledAlternativeButton()
            retryButton.translatesAutoresizingMaskIntoConstraints = false
            retryButton.setTitle("Retry", for: .normal)
            retryButton.addTarget(self, action: #selector(retryButtonClicked), for: .touchUpInside)
            
            return retryButton
        }()
        
        setUpConstraints()
    }
    
    func setUpConstraints() {
        self.view.addSubview(resultEmojiLabel)
        self.view.addSubview(titleLabel)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(simulateButton)
        self.view.addSubview(retryButton)
        
        NSLayoutConstraint.activate(
            [
                resultEmojiLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor,constant:  80),
                resultEmojiLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -48),
                resultEmojiLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48),
                resultEmojiLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -48)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(equalTo: resultEmojiLabel.bottomAnchor, constant: 48),
                titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -24),
                titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48),
                titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -48)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
                descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: simulateButton.topAnchor, constant: -64),
                descriptionLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 48),
                descriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -48)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                simulateButton.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 64),
                simulateButton.bottomAnchor.constraint(equalTo: retryButton.topAnchor, constant: -24),
                simulateButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64),
                simulateButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -64)
            ]
        )
        
        NSLayoutConstraint.activate(
            [
                retryButton.topAnchor.constraint(equalTo: simulateButton.bottomAnchor, constant: 24),
                retryButton.bottomAnchor.constraint(lessThanOrEqualTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
                retryButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 64),
                retryButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant:  -64)
            ]
        )
    }

    @objc
    func simulateButtonClicked() {
        let viewController = SimulationViewController(with: waterJugViewModel)
        present(viewController, animated: true, completion: nil)
    }

    @objc
    func retryButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}
