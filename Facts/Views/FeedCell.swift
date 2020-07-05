
import UIKit
import Kingfisher
import SnapKit

class FeedCell: UITableViewCell {
    
    var feed : Fact? {
        didSet {
            let url = URL(string: feed?.imageHref ?? "")
            let processor = DownsamplingImageProcessor(size: feedImage.bounds.size)
            feedImage.kf.indicatorType = .activity
            feedImage.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholder"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
            feedNameLabel.text = feed?.title ?? ""
            feedDescriptionLabel.text = feed?.rowDescription ?? ""
        }
    }
    
    private let feedNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    private let feedDescriptionLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let feedImage : UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.layer.cornerRadius = 7.0
        imgView.clipsToBounds = true
        return imgView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(feedImage)
        addSubview(feedNameLabel)
        addSubview(feedDescriptionLabel)
    
        feedImage.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 16, paddingBottom: 10, paddingRight: 0, width: contentView.frame.width/3, height: contentView.frame.width/3, enableInsets: false)
        feedNameLabel.anchor(top: feedImage.topAnchor, left: feedImage.rightAnchor, bottom: feedDescriptionLabel.topAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        feedDescriptionLabel.anchor(top: feedNameLabel.bottomAnchor, left: feedImage.rightAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 10, paddingRight: 10, width: 0, height: 0, enableInsets: false)
        
        feedDescriptionLabel.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(contentView.frame.width/3)
        }
        feedDescriptionLabel.sizeToFit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        feedDescriptionLabel.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    
}
