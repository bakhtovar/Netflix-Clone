//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Bakhtovar Umarov on 01/02/23.
//

import UIKit
import SnapKit

class TitleTableViewCell: UITableViewCell {
    
    // MARK: - Data Layer
    static let identifier = "TitleTableViewCell"
    
    // MARK: - UI
    private lazy var playTitleButton: UIButton = {
         let button = UIButton()
         let image = UIImage(systemName: "play.circle", withConfiguration:UIImage.SymbolConfiguration(pointSize: 30))
         button.tintColor = .white
         button.setImage(image, for: .normal)
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
    }()
    
    private lazy var titleLabel: UILabel = {
         let label = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
    }()
    
    private lazy var titlePosterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true

        return imageView
    }()
    
    // MARK: - Initss
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Constraints
    override func updateConstraints() {
        titlePosterImageView.snp.updateConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
           //make.bottom.equalTo(contentView.snp.bottom).inset(-15)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.updateConstraints { make in
            make.leading.equalTo(titlePosterImageView.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
          //  make.centerY.equalTo(contentView.snp.centerY)
        }
        
        playTitleButton.snp.updateConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        super.updateConstraints()

    }
    
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterURL)") else {
            return
        }
        titlePosterImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.titleName
    }
    
    // MARK: - Private
    private func addSubviews() {
        contentView.addSubview(titlePosterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playTitleButton)
    }
}
