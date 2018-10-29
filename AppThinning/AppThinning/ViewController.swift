//
//  ViewController.swift
//  AppThinning
//
//  Created by ngodacdu on 10/29/18.
//  Copyright © 2018 ngodacdu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var notifyLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func fetchLevelAssests(tags: Set<String>) {
        loadingIndicator.startAnimating()
        notifyLabel.text = "Downloading"
        let resourceRequest = NSBundleResourceRequest(tags: tags)
        resourceRequest.conditionallyBeginAccessingResources { [weak self] (isExist) in
            if isExist {
                DispatchQueue.main.async {
                    self?.notifyLabel.text = "Finished (existed)"
                    self?.loadingIndicator.stopAnimating()
                }
            } else {
                resourceRequest.beginAccessingResources { (error) in
                    DispatchQueue.main.async {
                        self?.notifyLabel.text = "Finished (Downloaded)"
                        self?.loadingIndicator.stopAnimating()
                    }
                }
            }
        }
    }
    
    @IBAction func goToLevel02(_ sender: Any) {
        let tags = Set([
            "level01",
            "level02",
            "level03",
            "level04",
            "level05",
            "level06",
            "level07",
            "level08",
            "level09",
        ])
        fetchLevelAssests(tags: tags)
    }
    
}

