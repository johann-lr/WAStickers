//
// Copyright (c) WhatsApp Inc. and its affiliates.
// All rights reserved.
//
// This source code is licensed under the BSD-style license found in the
// LICENSE file in the root directory of this source tree.
//

import UIKit

/**
 *  Main class that deals with each individual sticker.
 */
class Sticker {

    let imageData: ImageData

    var bytesSize: Int64 {
        return imageData.bytesSize
    }

    /**
     *  Initializes a sticker with an image file and emojis.
     *
     *  - Parameter filename: name of the image in the bundle, including extension. Must be either png or webp.
     *  - Parameter emojis: emojis associated with this sticker.
     *
     *  - Throws:
     - .fileNotFound if file has not been found
     - .unsupportedImageFormat if image is not png or webp
     - .imageTooBig if the image file size is above the supported limit (100KB)
     - .incorrectImageSize if the image is not within the allowed size
     - .animatedImagesNotSupported if the image is animated
     - .tooManyEmojis if there are too many emojis assigned to the sticker
     */
    init(contentsOfFile filename: String) throws {
        self.imageData = try ImageData.imageDataIfCompliant(contentsOfFile: filename, isTray: false)
    }

    /**
     *  Initializes a sticker with image data, type and emojis.
     *
     *  - Parameter imageData: Data of the image. Must be png or webp encoded data
     *  - Parameter type: format type of the sticker (png or webp)
     *  - Parameter emojis: array of emojis associated with this sticker.
     *
     *  - Throws:
     - .imageTooBig if the image file size is above the supported limit (100KB)
     - .incorrectImageSize if the image is not within the allowed size
     - .animatedImagesNotSupported if the image is animated
     - .tooManyEmojis if there are too many emojis assigned to the sticker
     */
    init(imageData: Data, type: ImageDataExtension) throws {
        self.imageData = try ImageData.imageDataIfCompliant(rawData:imageData, extensionType: type, isTray: false)
    }

    func copyToPasteboardAsImage() {
        if let image = imageData.image {
            Interoperability.copyImageToPasteboard(image: image)
        }
    }
}
