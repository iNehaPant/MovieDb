

import UIKit
import SDWebImage

let commonSpacing: CGFloat = 10.0
let containerViewHeight: CGFloat = 140.0
let titleNReleaseDateSpacing: CGFloat = 3.0
let movieImgWidth: CGFloat = 80.0
let movieImgHeight: CGFloat = 80.0
let imgBaseURL: String = "https://image.tmdb.org/t/p/w500"
let defaultMovieImg = "movie_default"
let percentage = "%"

class MovieCell: UITableViewCell {
    
    var movie: Result? {
        didSet {
            guard let movieItem = movie else {return}
            if let imageURLStr = movieItem.posterPath {
                let imageUrl = URL(string: imgBaseURL + imageURLStr)!
                moviewImageView.sd_setImage(with: imageUrl as URL?, placeholderImage: UIImage(named: defaultMovieImg), options: .transformAnimatedImage, progress: nil, completed: nil)
                
            }
            if let title = movieItem.title {
                titleLabel.text = title
            }
            
            if let releaseDate = movieItem.releaseDate {
                if let date: Date = releaseDate.toDate() {
                    releaseDateLabel.text = date.toString()
                }
            }
            if let voteAverage = movieItem.voteAverage{
                votingAvgLabel.text = String(voteAverage*10) + percentage
            }
        }
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let titleLabel: UILabel = {
        return LabelUtility.getLbl(fontName: "Helvetica-Bold", fontSize: 18)
    }()
    
    let releaseDateLabel: UILabel = {
        return LabelUtility.getLbl(fontName: "Helvetica", fontSize: 14)
    }()
    
    let votingAvgLabel: UILabel = {
        return LabelUtility.getLbl(fontName: "Arial", fontSize: 12)
    }()
    
    let moviewImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.translatesAutoresizingMaskIntoConstraints = false 
        img.clipsToBounds = true
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        self.contentView.addSubview(moviewImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(releaseDateLabel)
        containerView.addSubview(votingAvgLabel)
        self.contentView.addSubview(containerView)
        setMovieImgConstraints()
        setContainerViewConstraints(marginGuide)
        setTitleLblConstarints()
        setReleaseDateConstraints()
        setVotingAvgConstraints()
    }
    
    func setMovieImgConstraints(){
        moviewImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        moviewImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:commonSpacing).isActive = true
        moviewImageView.widthAnchor.constraint(equalToConstant:movieImgWidth).isActive = true
        moviewImageView.heightAnchor.constraint(equalToConstant:movieImgHeight).isActive = true
    }
    
    func setContainerViewConstraints(_ marginGuide: UILayoutGuide) {
        containerView.topAnchor.constraint(equalTo:marginGuide.topAnchor,constant: commonSpacing).isActive = true
        containerView.centerYAnchor.constraint(equalTo:marginGuide.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.moviewImageView.trailingAnchor, constant:commonSpacing).isActive = true
        containerView.trailingAnchor.constraint(equalTo:marginGuide.trailingAnchor, constant:commonSpacing).isActive = true
    }
    
    func setTitleLblConstarints() {
        titleLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor,constant: commonSpacing).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor,constant: commonSpacing).isActive = true
    }
    
    func setReleaseDateConstraints() {
        releaseDateLabel.topAnchor.constraint(equalTo:self.titleLabel.bottomAnchor,constant: titleNReleaseDateSpacing).isActive = true
        releaseDateLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        releaseDateLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
    }
    
    func setVotingAvgConstraints() {
        votingAvgLabel.topAnchor.constraint(equalTo:self.releaseDateLabel.bottomAnchor,constant: commonSpacing).isActive = true
        votingAvgLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        votingAvgLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        votingAvgLabel.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

