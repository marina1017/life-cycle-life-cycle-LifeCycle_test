//
//  ViewController.swift
//  life cycle life cycle LifeCycle_test
//
//  Created by nakagawa on 2018/02/08.
//  Copyright © 2018年 nakagawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let childView: UIView = {
        let childView = UIView()
        childView.backgroundColor = UIColor.blue
        childView.frame = CGRect.zero
        childView.translatesAutoresizingMaskIntoConstraints = false
        return childView
    }()

    let grandsonView: UIView = {
        let grandsonView = UIView()
        grandsonView.backgroundColor = UIColor.red
        return grandsonView
    }()


    var portraitConstraints:[NSLayoutConstraint]?
    var grandsonViewConstraints:[NSLayoutConstraint]?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = SafeAreaView(frame: UIWindow().bounds)
        self.view.backgroundColor = UIColor.white

        self.view.addSubview(childView)
        self.childView.addSubview(grandsonView)

        (view as? SafeAreaView)?.didChangeSafeAreaInsets = { inset in
            print("view.safeAreaInsets = \(inset)")
        }

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    //画面回転やスプリッドビューなどの画面サイズ変更によるレイアウト変更はここに記述するといい
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

    }

    //safeareaが変更された時　この時意向はSafeareaの値をとれる
    override func viewSafeAreaInsetsDidChange() {
        NSLayoutConstraint.deactivate(portraitConstraints ?? [])
        portraitConstraints = [
            childView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            childView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            childView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(portraitConstraints ?? [])

    }

    //トレイとコレクションが変更された後に読み出される（アプリ起動時やビューコントローラーがはじめてロードされたタイミングでも読み出される）
    //
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }


    override func viewWillLayoutSubviews() {
        
    }



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class SafeAreaView: UIView {
    var didChangeSafeAreaInsets: ((UIEdgeInsets) -> ())?
    override func safeAreaInsetsDidChange() {
        didChangeSafeAreaInsets?(safeAreaInsets)
    }
}
