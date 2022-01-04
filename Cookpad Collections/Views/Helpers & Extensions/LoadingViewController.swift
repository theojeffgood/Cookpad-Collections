//
//  LoadingViewController.swift
//  Cookpad Collections
//
//  Created by Theo Goodman on 1/4/22.
//

import UIKit

// LoadingViewController is a plug-in for displaying loading spinners e.g. during network calls

class LoadingViewController: UIViewController {
   private lazy var activityIndicator = UIActivityIndicatorView(style: .medium)

    override func viewDidLoad() {
        super.viewDidLoad()

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)

        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Delay is added to the activity indicator in case data loads very quickly
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) { [weak self] in
            self?.activityIndicator.startAnimating()
        }
    }
}

// Easy adding & removing child VCs to facilitate display of the LoadingViewController

extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        // Just to be safe, we check that this view controller
        // is actually added to a parent before removing it.
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
