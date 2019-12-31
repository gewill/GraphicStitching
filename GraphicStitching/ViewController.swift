//
//  ViewController.swift
//  GraphicStitching
//
//  Created by Will on 30/12/2019.
//  Copyright © 2019 Ge Will. All rights reserved.
//

import QMUIKit
import Repeat
import SwiftCSV
import UIKit

class ViewController: UIViewController {
    // MARK: - outlets

    @IBOutlet var contentL: UILabel!
    @IBOutlet var containerView: UIView!
    var timer: Repeater!

    // MARK: - properties

    // MARK: - life cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        getData()
    }

    private func getData() {
        guard let path = Bundle.main.path(forResource: "poetry", ofType: "csv"),
            let csv = try? CSV(url: URL(fileURLWithPath: path)) else {
            return
        }

        guard let col = csv.namedColumns["key"] else {
            return
        }

        timer = Repeater.every(.seconds(3), count: col.count) { timer in
            if let remainingIterations = timer.remainingIterations {
                if remainingIterations >= 0 {
                    self.save(with: col[remainingIterations])
                    print(#function)
                }
            }
        }
        timer.start()
    }

    // MARK: - response methods

    @IBAction func CompositePictureButtonClick(_ sender: UIButton) {
        guard let image = UIImage.qmui_image(with: containerView, afterScreenUpdates: true) else {
            return
        }
        PhotoBrowser.presentPhotos(photos: [image], index: 0)
    }

    // MARK: - private methods

    private func save(with text: String) {
        DispatchQueue.main.async {
            self.contentL.text = text
            self.compositePicture()
        }
    }

    private func compositePicture() {
        guard let image = UIImage.qmui_image(with: containerView, afterScreenUpdates: true) else {
            return
        }
        store(image: image, forKey: UUID().uuidString)
    }

    private func store(image: UIImage,
                       forKey key: String) {
        if let pngRepresentation = image.pngData() {
            if let filePath = filePath(forKey: key) {
                do {
                    try pngRepresentation.write(to: filePath,
                                                options: .atomic)
                    print(filePath)
                } catch let err {
                    print("Saving file resulted in error: ", err)
                }
            }
        }
    }

    private func filePath(forKey key: String) -> URL? {
        let fileManager = FileManager.default
        guard let documentURL = fileManager.urls(for: .documentDirectory,
                                                 in: FileManager.SearchPathDomainMask.userDomainMask).first else { return nil }

        return documentURL.appendingPathComponent(key + ".png")
    }
}
