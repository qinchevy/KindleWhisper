//
//  ShareViewController.swift
//  KindleShareExtension
//
//  Created by QinZhang on 2017/4/17.
//  Copyright © 2017年 QinZhang. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
        if self.extensionContext!.inputItems.count > 0 {
            if let inputItem = extensionContext!.inputItems[0] as? NSExtensionItem {
                if let attachments = inputItem.attachments as? [NSItemProvider] {
                    for attachment in attachments {
                        if attachment.hasItemConformingToTypeIdentifier(kUTTypeURL as String) {
                            attachment.loadItem(forTypeIdentifier: kUTTypeURL as String, options: nil) { data, error in
                                let url = data as! NSURL
                                print(url)
                                // Send to Kindle
                            }
                        }
                    }
                }
            }
            
        }
    
        
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}
