//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Bakhtovar Umarov on 27/01/23.
//

import UIKit
import SnapKit
import SkeletonView

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    // MARK: - Data Layer
    private var randomTrendingMovies: Title?
    private var headerView: HeaderUIView?
    let sectionsTitle: [String] = ["Trending Movies", "Popular", "Trending Tv", "Upcoming Movies", "Top Rated"]
    
    // MARK: - UI
    private lazy var homeFeedTable: UITableView = {
        let homeFeedTable = UITableView(frame: .zero, style: .grouped)
        homeFeedTable.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        headerView = HeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        homeFeedTable.tableHeaderView = headerView
        return homeFeedTable
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
           super.viewDidLoad()
           view.backgroundColor = .systemBackground
           addSubViews()
           //skeletonUsage()
           //skeletonUsage()
           configureNavbar()
           makeConstraints()
           getTrandingMovies()
           configureHeaderUIView()
         
           
//        APICaller.shared.getMovie(with: "Harry Potter") { result in
//
//        }
       }
    
    func skeletonUsage() {
        homeFeedTable.isSkeletonable = true
        homeFeedTable.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .emerald), animation: nil, transition: .crossDissolve(0.25))
        homeFeedTable.startSkeletonAnimation()
        homeFeedTable.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .emerald), animation: nil, transition: .crossDissolve(0.25))
    }
    
    private func configureHeaderUIView() {
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                let selectedTitle = titles.randomElement()
                self?.randomTrendingMovies = selectedTitle
                self?.headerView?.configure(with: TitleViewModel(titleName: selectedTitle?.original_title ?? "", posterURL: selectedTitle?.poster_path ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Constraints
    private func makeConstraints() {
        homeFeedTable.snp.makeConstraints { make in
            make.size.equalToSuperview()
        }
    }
    
    // MARK: - Private
    private func addSubViews() {
        view.addSubview(homeFeedTable)
    }
    
    private func configureNavbar() {
           var image = UIImage(named: "netflixLogo")
           image = image?.withRenderingMode(.alwaysOriginal)
           navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
           navigationItem.rightBarButtonItems = [
            UIBarButtonItem.init(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem.init(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
           ]
            
        navigationController?.navigationBar.tintColor = .white
       }
    
    private func getTrandingMovies() {
        APICaller.shared.getTrendingMovies { results in
        switch results {
            case .success(let movies):
            print(movies)
            case .failure(let error):
            print(error)
        }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionsTitle.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier) as? CollectionViewTableViewCell else {
            return UITableViewCell()
      	  }
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            
            APICaller.shared.getTrendingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.TrendingTv.rawValue:
            
            APICaller.shared.getTrendingTvs { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Popular.rawValue:
            
            APICaller.shared.getPopularMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sections.Upcoming.rawValue:
            
            APICaller.shared.getUpcomingMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue:
            
            APICaller.shared.getTopRatedMovies { result in
                switch result {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y , width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionsTitle[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
