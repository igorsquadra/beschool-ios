//
//  Utils.swift
//  lacnews24
//
//  Created by Filippo Giove on 03/04/24.
//

import Foundation
import UIKit

class Utils {
  
    /// Get current environment
    static var currentEnvironment: AppEnvironment = .production
    
    static var isPreview: Bool {
        ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
    static var hideAdvHome: Bool = false
    static var hideAdv: Bool = true
    
    static var isIpad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    
    struct Notifications {
        static let registeredToPushNotification = NSNotification.Name("registeredToPushNotification")
        static let tapOnPushNotification = NSNotification.Name("tapOnPushNotification")
        static let receivedPushNotification = NSNotification.Name("receivedPushNotification")
        static let interstitialReady = NSNotification.Name("interstitialReady")
        static let interstitialDismissed = NSNotification.Name("interstitialDismissed")
    }
    
    enum NotificationPeriod: String, Codable {
        case year = "1-year"
        case last3Month = "3-months"
        case lastDay = "1-day"
        case last12Hours = "12-hours"
        case last30Minutes = "30-minutes"
    }
    
    enum LacURLs {
      static let rubriche = "https://www.lac.atexcloud.io/rubriche"
      static let privacyPolicy = "https://api.lacnews24.it/_app/policy_app_lacnews24.html"
      static let legalNotes = "https://api.lacnews24.it/_app/policy_app_lacnews24.html"
      static let redazione = "https://www.diemmecom.it/il-nostro-network/"
        static let appStore = "https://apps.apple.com/it/developer/diemmecom-societ%C3%A0-editoriale-srl/id1544296621"
    }
    
    typealias LocalEdition = (title: String, url: String)
    static let localEditions: [LocalEdition] = [
        LocalEdition(title: "La City Mag", url: "https://www.lacitymag.it/"),
        LocalEdition(title: "Il Reggino", url: "https://www.ilreggino.it/"),
        LocalEdition(title: "Cosenza Channel", url: "https://www.cosenzachannel.it/"),
        LocalEdition(title: "Il Vibonese", url: "https://www.ilvibonese.it/"),
        LocalEdition(title: "Catanzaro Channel", url: "https://www.catanzarochannel.it/")
    ]
    
    static let lacitymagHTML: String = """
        <!DOCTYPE html>
        <html>
        <head>
        <script src="https://d3fab4b48l25u.cloudfront.net/widget-articles.umd.js"></script>
        </head>
        <body>
        <div id="widget-articles-container" data-widget-count="2"></div>
        <script>
        document.addEventListener("DOMContentLoaded", () => {
            WidgetArticles.createWidget("widget-articles-container");
        });
        </script>
        </body>
        </html>
        """
}
