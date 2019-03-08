import UIKit
import Firebase

class FolloweeViewController: UIViewController {

    //テーブルビューインスタンス
    var friendsCollectionView: UICollectionView!
    private var followee: [Follow] = []
    private var uid: String!

    init(uid: String) {
        self.uid = uid
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width/3, height: view.frame.width/3)
        layout.sectionInset = UIEdgeInsets.zero
        layout.minimumInteritemSpacing = 0.0
        layout.minimumLineSpacing = 0.0
        layout.headerReferenceSize = CGSize(width: 0, height: 0)
        let collectionFrame = view.frame
        friendsCollectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        friendsCollectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UserCollectionViewCell.self))
        friendsCollectionView.delegate = self
        friendsCollectionView.dataSource = self
        friendsCollectionView.backgroundColor = UIColor.white
        view.addSubview(friendsCollectionView)

        FollowHandler.featchFollowee(uid: uid) { (follows, error) in
            if let error = error {
                self.showMessageAlert(message: error.description)
                return
            }
            self.followee = follows
            self.friendsCollectionView.reloadData()
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        friendsCollectionView.frame = view.frame
    }
}

extension FolloweeViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let followeeUid = followee[indexPath.row].followUid
        let userInfoView = UserInfoViewController(uid: followeeUid)
        navigationController?.pushViewController(userInfoView, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followee.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let followeeUid = followee[indexPath.row].followUid
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(UserCollectionViewCell.self), for: indexPath) as! UserCollectionViewCell
        cell.icomImageView.sd_setImage(with: User.getIconReference(uid: followeeUid), placeholderImage: UIImage(named: "common-icon-default"))
        UserHandler.featchUser(uid: followeeUid) { (user, error) in
            if let error = error {
                self.showMessageAlert(message: error.description)
                return
            }
            cell.userLabel!.text = user?.nickname
        }
        return cell
    }
}
