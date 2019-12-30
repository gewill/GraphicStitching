//
//  PhotoBrowser.swift
//
//
//  Created by Will
//  Copyright © 2019 All rights reserved.
//

import SKPhotoBrowser
import UIKit

private func setupSKPhotoBrowserOptions() {
    SKPhotoBrowserOptions.displayBackAndForwardButton = false
    SKPhotoBrowserOptions.displayAction = false
    SKPhotoBrowserOptions.indicatorColor = .white
    SKPhotoBrowserOptions.swapCloseAndDeleteButtons = true
    SKPhotoBrowserOptions.enableSingleTapDismiss = true
}

@objc class PhotoBrowser: NSObject {
    @objc static func presentPhotos(photos: [UIImage], index: Int) {
        guard index < photos.count else { return }

        var images = [SKPhoto]()
        photos.forEach {
            images.append(SKPhoto.photoWithImage($0))
        }

        // 2. create PhotoBrowser Instance, and present.
        setupSKPhotoBrowserOptions()
        let browser = SKPhotoBrowser(photos: images, initialPageIndex: index)
        gs_present(browser, animated: true, completion: {})
    }

    @objc static func presentPhotos(photosURLs: [String], index: Int) {
        guard index < photosURLs.count else { return }

        var images = [SKPhoto]()
        photosURLs.forEach {
            images.append(SKPhoto.photoWithImageURL($0))
        }

        // 2. create PhotoBrowser Instance, and present.
        setupSKPhotoBrowserOptions()
        let browser = SKPhotoBrowser(photos: images, initialPageIndex: index)
        gs_present(browser, animated: true, completion: {})
    }
}
