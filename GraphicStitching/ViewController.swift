//
//  ViewController.swift
//  GraphicStitching
//
//  Created by Will on 30/12/2019.
//  Copyright © 2019 Ge Will. All rights reserved.
//

import QMUIKit
import UIKit

class ViewController: UIViewController {
    // MARK: - outlets

    @IBOutlet var containerView: UIView!

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - response methods

    @IBAction func CompositePictureButtonClick(_ sender: UIButton) {
        guard let image = UIImage.qmui_image(with: containerView, afterScreenUpdates: true) else {
            return
        }
        PhotoBrowser.presentPhotos(photos: [image], index: 0)
    }
}
