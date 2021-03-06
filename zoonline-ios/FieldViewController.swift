import UIKit

class FieldViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //CollectionViews
    var collectionView: UICollectionView!
    var postButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton

        //ナビゲーションアイテムを作成
        title = "ひろば"

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = view.frame.width
        let height = view.frame.height - (view.safeAreaInsets.top + view.safeAreaInsets.bottom)
        let collectionFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: height)
        let layout = FieldCollectionViewFlowLayout()
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView = UICollectionView(frame: collectionFrame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(FieldCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(FieldCollectionViewCell.self))
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        collectionView.register(NetWorkErrorCollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(NetWorkErrorCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInsetAdjustmentBehavior = .never
        view.addSubview(collectionView)

        //リフレッシュコントロールの追加
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(scrollReflesh(sender:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl

        collectionView.collectionViewLayout.invalidateLayout()
        let layout2 = FieldCollectionViewFlowLayout()
        collectionView.setCollectionViewLayout(layout2, animated: false)

        postButton = UIButton()
        postButton.backgroundColor = UIColor(named: "main")
        postButton.frame = CGRect(x: width - 100, y: height - 100, width: 80, height: 80)
        postButton.layer.cornerRadius = 40
        postButton.setImage(UIImage(named: "field-add"), for: .normal)
        postButton.addTarget(self, action: #selector(showPostVC(sender:)), for: .touchUpInside)
        view.addSubview(postButton)
    }

    @objc func scrollReflesh(sender: UIRefreshControl) {
    }

    @objc func showPostVC(sender: UIRefreshControl) {
        let postNavigationController = UINavigationController(rootViewController: PostViewController())
        self.present(postNavigationController, animated: true, completion: nil)
    }

    //Cellが選択された際に呼び出される
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Section: \(indexPath.section)")
        print("Num: \(indexPath.row)")
        print("Number: \(indexPath.section * 6 + indexPath.row)")

        //画面遷移、投稿詳細画面へ
        let picDetailView: PostDetailViewController = PostDetailViewController()
        picDetailView.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(picDetailView, animated: true)
    }

    //セクションあたりのセルの数を返す
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    //セクションの総数を返す
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 5
    }

    //Cellに値を設定する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FieldCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(FieldCollectionViewCell.self), for: indexPath as IndexPath) as! FieldCollectionViewCell
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 16
        cell.thumbnailImgView?.image = UIImage(named: "no_img")
        return cell
    }
}
