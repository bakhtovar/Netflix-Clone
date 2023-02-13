//
//  HeaderUIView.swift
//  Netflix Clone
//
//  Created by Bakhtovar Umarov on 30/01/23.
//


import UIKit
import SnapKit

class HeaderUIView: UIView {
    
    // MARK: - UI
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.cornerCurve = .continuous
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.cornerCurve = .continuous
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "heroImage")
        return imageView
    }()
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        makeConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        heroImageView.sd_setImage(with: url, completed: nil)
    }
    
    // MARK: - Constraints
    private func makeConstraints() {
        
        heroImageView.snp.makeConstraints { make in
            make.size.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        
        playButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(70)
            make.bottom.equalToSuperview().inset(50)
//            make.bottom.equalTo(heroImageView.snp.bottom).inset(25)
            make.width.equalTo(100)
        }
        
        downloadButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(70)
            make.bottom.equalToSuperview().inset(50)
            make.width.equalTo(100)

        }
    }
    
    // MARK: - Private
    private func addSubviews() {
        addSubview(heroImageView)
        addGradient()
        addSubview(playButton)
        addSubview(downloadButton)
    }
}

