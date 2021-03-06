import UIKit

class PostDetailView: UIView {

    //  各種高さ
    // Iconとフォロー
    let userInfoHeight: CGFloat = 60
    // Favoriteとコメントなど
    let menuHeight: CGFloat = 60
    // Dateの高さ
    let dateHeight: CGFloat = 20
    // テーブルビューまでのマージン
    let bottomMargin: CGFloat = 8

    // Viewのパーツ
    // UserInfo
    var userThumbnail: UIImageView!
    var usetName: UILabel!
    var userInfoButton: UIButton!

    // Follow Info
    var followButton: UIButton!
    var followIcon: UIImageView!
    var followLabel: UILabel!

    // Image
    var postImage: UIImageView!

    // Favorite
    var favoriteButton: UIButton!
    var favoriteLabel: UILabel!

    // Comment
    var commentButton: UIButton!
    var commentLabel: UILabel!

    // Menu
    var menuButton: UIButton!

    // Date
    var dateLabel: UILabel!

    // Detail
    var detailTextView: UITextView!

    // BottomLine
    var bottomLine: UIView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        // UserInfo
        userInfoButton = UIButton()
        addSubview(userInfoButton)

        userThumbnail = UIImageView()
        userThumbnail.image = UIImage(named: "common-icon-default")
        userThumbnail.isUserInteractionEnabled = false
        addSubview(userThumbnail)

        usetName = UILabel()
        usetName.text = "いろはにほへと"
        usetName.textAlignment = .left
        usetName.font = UIFont.systemFont(ofSize: 20)
        usetName.isUserInteractionEnabled = false
        addSubview(usetName)

        // Follow Info
        followButton = UIButton()
        followButton.setImage(UIImage(named: "post-detail-follow-icon"), for: .normal)
        addSubview(followButton)

        followLabel = UILabel()
        followLabel.text = "フォロー"
        followLabel.textColor = .gray
        addSubview(followLabel)

        // Image
        postImage = UIImageView()
        postImage.image = UIImage(named: "sample-postImage")
        addSubview(postImage)

        // Favorite
        favoriteButton = UIButton()
        favoriteButton.setImage(UIImage(named: "post-detail-fav-on"), for: .normal)
        addSubview(favoriteButton)

        favoriteLabel = UILabel()
        favoriteLabel.textColor = UIColor(named: "postDetailFavPink")
        favoriteLabel.font = UIFont.boldSystemFont(ofSize: 24)
        favoriteLabel.text = "10"
        addSubview(favoriteLabel)

        // Comment
        commentButton = UIButton()
        commentButton.setImage(UIImage(named: "post-detail-comment"), for: .normal)
        addSubview(commentButton)

        commentLabel = UILabel()
        commentLabel.textColor = UIColor(named: "textColorGray")
        commentLabel.font = UIFont.boldSystemFont(ofSize: 24)
        commentLabel.text = "10"
        addSubview(commentLabel)

        // Menu
        menuButton = UIButton()
        menuButton.setImage(UIImage(named: "post-detail-menu"), for: .normal)
        addSubview(menuButton)

        // Date
        dateLabel = UILabel()
        dateLabel.text = "2017年4月1日"
        dateLabel.textColor = UIColor(named: "textColorGray")
        dateLabel.font = UIFont.systemFont(ofSize: 18)
        addSubview(dateLabel)

        // Detail
        detailTextView = UITextView()
        detailTextView.text = "アライさんなのだ！！天王寺動物園でサイさんをみたのだ。思ったよりも大きかったのだ。"
        detailTextView.font = UIFont.systemFont(ofSize: 18)
        detailTextView.textAlignment = .left
        detailTextView.isEditable = false
        addSubview(detailTextView)

        // BottomLine
        bottomLine = UIView()
        bottomLine.backgroundColor = UIColor(named: "mypageArrowGray")
        addSubview(bottomLine)
    }

    override func layoutSubviews() {
        let width = frame.width

        // UserInfo
        userThumbnail.frame = CGRect(x: 20, y: (userInfoHeight - 40) / 2, width: 40, height: 40)
        userThumbnail.layer.cornerRadius = 24
        usetName.frame = CGRect(x: 72, y: 0, width: 250, height: userInfoHeight)
        userInfoButton.frame = CGRect(x: 0, y: 0, width: 250, height: userInfoHeight)

        // Follow
        followButton.frame = CGRect(x: width - 140, y: 0, width: userInfoHeight, height: userInfoHeight)
        followLabel.frame = CGRect(x: width - 80, y: 0, width: 80, height: userInfoHeight)

        // Image
        postImage.frame = CGRect(x: 0, y: userInfoHeight, width: width, height: width)

        // Favorite
        favoriteButton.frame = CGRect(x: 20, y: userInfoHeight + width + (menuHeight - 48) / 2, width: 48, height: 48)
        favoriteLabel.frame = CGRect(x: 68, y: userInfoHeight + width, width: 40, height: menuHeight)

        // Comment
        commentButton.frame = CGRect(x: 112, y: userInfoHeight + width + (menuHeight - 48) / 2, width: 48, height: 48)
        commentLabel.frame = CGRect(x: 160, y: userInfoHeight + width, width: 40, height: menuHeight)

        // Menu
        menuButton.frame = CGRect(x: width - 60, y: userInfoHeight + width + (menuHeight - 48) / 2, width: 48, height: 48)

        // Date
        dateLabel.frame = CGRect(x: 20, y: userInfoHeight + width + menuHeight, width: 200, height: dateHeight)

        // Detail
        let textViewSize = getTextViewSize(viewWidth: frame.width)
        detailTextView.frame = CGRect(
            x: 20,
            y: userInfoHeight + width + menuHeight + dateHeight,
            width: textViewSize.width,
            height: textViewSize.height)

        // BottomLine
        bottomLine.frame = CGRect(
            x: 0,
            y: userInfoHeight + width + menuHeight + dateHeight + textViewSize.height + bottomMargin - 1,
            width: width,
            height: 0.5)
    }

    func getTextViewSize(viewWidth: CGFloat) -> CGSize {
        return detailTextView.sizeThatFits(CGSize(width: viewWidth - 40, height: 0))
    }

    func calcHeight(viewWidth: CGFloat) -> CGFloat {
        let textViewSize = getTextViewSize(viewWidth: viewWidth)
        return userInfoHeight + viewWidth + menuHeight + dateHeight + textViewSize.height + bottomMargin
    }
}
