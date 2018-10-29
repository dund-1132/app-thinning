//
//  ViewController.swift
//  AppThinning
//
//  Created by ngodacdu on 10/29/18.
//  Copyright © 2018 ngodacdu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLevelAssests(imageName: "sp01", tag: "level01")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func fetchLevelAssests(imageName: String, tag: String) {
        loadingIndicator.startAnimating()
        let resourceRequest = NSBundleResourceRequest(tags: Set([tag]))
        resourceRequest.conditionallyBeginAccessingResources { [weak self] (isExist) in
            if isExist {
                self?.displayImageView(error: nil, imageName: imageName)
            } else {
                resourceRequest.beginAccessingResources { (error) in
                    self?.displayImageView(error: error, imageName: imageName)
                }
                
            }
        }
    }
    
    private func displayImageView(error: Error?, imageName: String) {
        DispatchQueue.main.async {
            if let error = error {
                print("[App Thinning] error \(error.localizedDescription)")
                self.imageView.image = nil
            } else {
                self.imageView.image = UIImage(named: imageName)
            }
            self.loadingIndicator.stopAnimating()
        }
    }
    
    @IBAction func goToLevel02(_ sender: Any) {
        fetchLevelAssests(imageName: "sp02", tag: "level02")
    }
    
}

