import UIKit
import SnapKit
import SDWebImage
import Kingfisher

class TitleCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Data Layer
    static let identifier = "TitleCollectionViewCell"
    
//    var title: TrendingTitleResponse? {
//        didSet {
//            guard let title = title else {
//                return
//            }
//            posterImageView.image = TitleCollectionViewCell.load(from: title.poster_path)
//            posterImageView.image = title.results
//
//            //updateConstraints()
//        }
//    }
    
    // MARK: - UI
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
     
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(with model: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
            return
        }
        posterImageView.sd_setImage(with: url, completed: nil)
    }
    
    // MARK: - Constraints
    override func updateConstraints() {
        posterImageView.snp.updateConstraints() { make in
            make.size.equalToSuperview()
        }
        super.updateConstraints()
    }
    
    // MARK: - Private
    private func addSubviews() {
        contentView.addSubview(posterImageView)
    }
}
