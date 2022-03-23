//
//  WaterJugView.swift
//  Water Jug
//
//  Created by Gabriel on 22/03/2022.
//

import UIKit

class WaterJugView: UIView {
    var wave: WaveAnimationView!
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        wave = WaveAnimationView(frame: CGRect(origin: .zero, size: CGSize(width: 120, height: 120)), color: UIColor.waterColor.withAlphaComponent(0.5))
        
        wave.startAnimation()
        
        wave.setProgress(0.7)

        self.layer.cornerRadius = 15
        self.layer.masksToBounds = true
        
        wave.translatesAutoresizingMaskIntoConstraints = false
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpConstraints() {
        self.addSubview(wave)
        
        NSLayoutConstraint.activate(
            [
                wave.topAnchor.constraint(equalTo: self.topAnchor),
                wave.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                wave.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                wave.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ]
        )
    }
    
    func setProgress(_ value: Float) {
        wave.setProgress(value)
    }
    
    func getProgress() -> Float {
        return wave.progress
    }
    
    func stopAnimation() {
        wave.stopAnimation()
    }
    
}
