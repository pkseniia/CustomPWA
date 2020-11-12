//
//  PWAService.swift
//  CustomPWA
//
//  Created by Kseniia Poternak on 09.11.2020.
//

import UIKit
import SafariServices
import Swifter

protocol PWACreatorProtocol {
    func openLocalSafariHTML(with entity: CustomAppEntity, completion: @escaping EmptyBlock)
}

class PWACreator: PWACreatorProtocol {
    
    let server: HttpServer = HttpServerPWA.shared.getSever()
    
    init() {}
    
    func openLocalSafariHTML(with entity: CustomAppEntity, completion: @escaping EmptyBlock) {
        
        guard let title = entity.title else { completion(); return }
        guard let schema = entity.schema else { completion(); return }
        guard let image = entity.image else { completion(); return }
        guard let urlToRedirect = URL(string: schema) else { completion(); return }
        
        htmlFor(title: title, urlToRedirect: urlToRedirect, image: image) { [weak self] html in
            guard let self = self else { completion(); return }
            guard let html = html else { completion(); return }
            guard let base64 = html.data(using: .utf8)?.base64EncodedString() else { completion(); return }
            
            self.server["/"] = { request in
                return .movedPermanently("data:text/html;base64,\(base64)")
            }
            self.server["/files/:path"] = directoryBrowser("/")
            
            self.startServer(completion: completion)
        }
    }
    
    private func htmlFor(title: String, urlToRedirect: URL, image: UIImage, completion: @escaping (String?) -> Void) {
        guard let touchIcon = image.jpegData(compressionQuality: 0)?.base64EncodedString() else { completion(nil); return }
        
        ensureMainThread { [weak self] in
            guard let self = self else { return }
            guard let ip5Base64 = self.createImageBase64Data(for: .iphone5, image: image) else { completion(nil); return }
            guard let ip6Base64 = self.createImageBase64Data(for: .iphone6, image: image) else { completion(nil); return }
            guard let ipMaxBase64 = self.createImageBase64Data(for: .iphoneMax, image: image) else { completion(nil); return }
            guard let ipPlusBase64 = self.createImageBase64Data(for: .iphonePlus, image: image) else { completion(nil); return }
            guard let ipXBase64 = self.createImageBase64Data(for: .iphoneX, image: image) else { completion(nil); return }
            guard let ipXrBase64 = self.createImageBase64Data(for: .iphoneXr, image: image) else { completion(nil); return }
            
            let splashModel = IphoneSplashImagesModel(title: title,
                                                      touchIcon: touchIcon,
                                                      urlToRedirect: urlToRedirect.absoluteString,
                                                      ip5Base64: ip5Base64,
                                                      ip6Base64: ip6Base64,
                                                      ipMaxBase64: ipMaxBase64,
                                                      ipPlusBase64: ipPlusBase64,
                                                      ipXBase64: ipXBase64,
                                                      ipXrBase64: ipXrBase64)
            
            self.setupHTML(splashModel: splashModel, completion: completion)
        }
    }
    
    private func startServer(port: in_port_t = 8080, maximumOfAttempts: Int = 5, completion: @escaping EmptyBlock) {
        
        if maximumOfAttempts == 0 {
            completion()
            return
        }
        
        do {
            try server.start(port)
            print("Server has started ( port = \(try server.port()) ). Try to connect now...")
            guard let shortcutUrl = URL(string: "http://localhost:\(port)/") else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completion()
                UIApplication.shared.open(shortcutUrl)
            }
        } catch SocketError.bindFailed(let message) where message == "Address already in use" {
            startServer(port: in_port_t.random(in: 8081..<10000), maximumOfAttempts: maximumOfAttempts - 1, completion: completion)
        } catch {
            completion()
            print("Server start error: \(error)")
        }
    }
    
    private func createImageBase64Data(for frame: IphoneFrame, image: UIImage) -> String? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: frame.widthInPixels, height: frame.heightInPixels))
        view.backgroundColor = .black
        let imageView = UIImageView(image: image)
        imageView.cornerRadius = 32
        imageView.pinTo(view: view, addAsSubview: true, position: .center(offset: .zero), size: .constant(width: frame.splashImageFrame, height: frame.splashImageFrame))
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        guard let splashImage = UIGraphicsGetImageFromCurrentImageContext(),
              let splashImageData = splashImage.jpegData(compressionQuality: 0.5) else { return nil }
        return splashImageData.base64EncodedString()
    }
        
    func setupHTML(splashModel: IphoneSplashImagesModel, completion: @escaping (String?) -> Void) {
        
        guard let safariShare = UIImage.custom(name: .safariShare).pngData()?.base64EncodedString() else { completion(nil); return }
        guard let safariInstructions = UIImage.custom(name: .safariInstructions).pngData()?.base64EncodedString() else { completion(nil); return }
        
        let mainTitle = Constants.HTMLTitles.header
        let tapPart1 = Constants.HTMLTitles.tap + " "
        let tapPart2 = " " + Constants.HTMLTitles.atTheBottom
        let selectAddToHome = Constants.HTMLTitles.selectAddToHome
        
        let html = """
        <html>
        <head>
            <meta name="apple-mobile-web-app-capable" content="yes">
            <meta name="apple-mobile-web-app-status-bar-style" content="default">
            <meta content="text/html charset=UTF-8" http-equiv="Content-Type" />
            <meta name="viewport" content="width=device-width,initial-scale=1.0,user-scalable=no" />
            <meta name="apple-mobile-web-app-title" content="\(splashModel.title)">
            <link rel="apple-touch-icon" href="data:image/jpeg;base64,\(splashModel.touchIcon)">

            <link href=href="data:image/jpeg;base64,\(splashModel.ip5Base64)" media="(device-width: 320px) and (device-height: 568px) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image" />
            <link href="data:image/jpeg;base64,\(splashModel.ip6Base64)" media="(device-width: 375px) and (device-height: 667px) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image" />
            <link href="data:image/jpeg;base64,\(splashModel.ipPlusBase64)" media="(device-width: 621px) and (device-height: 1104px) and (-webkit-device-pixel-ratio: 3)" rel="apple-touch-startup-image" />
            <link href="data:image/jpeg;base64,\(splashModel.ipXBase64)" media="(device-width: 375px) and (device-height: 812px) and (-webkit-device-pixel-ratio: 3)" rel="apple-touch-startup-image" />
            <link href="data:image/jpeg;base64,\(splashModel.ipXrBase64)" media="(device-width: 414px) and (device-height: 896px) and (-webkit-device-pixel-ratio: 2)" rel="apple-touch-startup-image" />
            <link href="data:image/jpeg;base64,\(splashModel.ipMaxBase64)" media="(device-width: 414px) and (device-height: 896px) and (-webkit-device-pixel-ratio: 3)" rel="apple-touch-startup-image" />
                
            <title>\(splashModel.title)</title>

            <style>
                *|* {
                        padding: 0; margin: 0; box-sizing: border-box;
                        margin-block-start: 0; margin-block-end: 0; margin-inline-start: 0; margin-inline-end: 0;
                        padding-inline-start: 0; padding-inline-end: 0;
                        -webkit-margin-before: 0; -webkit-margin-after: 0; -webkit-margin-start: 0; -webkit-margin-end: 0;
                        -webkit-padding-start: 0; -webkit-padding-end: 0;
                        -webkit-tap-highlight-color: transparent;
                }

                html, body {margin:0; padding:0; color: #000; text-align: center; font-weight: 400; font-family: -apple-system, BlinkMacSystemFont, Helvetica, sans-serif; background: #fff; overflow: hidden;}

                html {font-size: 1.8vh; width: 100vw;}
                body {
                        -webkit-touch-callout: none;
                        -webkit-user-select: none;
                        user-select: none;
                        -webkit-font-smoothing: antialiased;
                        -webkit-overflow-scrolling: auto;
                        height: 100vh; width: 100vw;
                }
                ul {list-style: none;}
                a {text-decoration: none; color: inherit;}
                strong {font-weight: 600;}

                .hidden {display: none;}
            .unvisible {pointer-events: none; visibility: hidden; opacity: 0;}

                #main-container {
                    width: 100%; height: 100vh; max-width: 375px; margin: auto;
                    padding-top: 49px;
                }

                header {font-size: 15px; line-height: 1.1; font-weight: 400;}
                header p {padding-top: 1.3vh;}
                .icon {
                    width: 60px; height: 60px;
                    margin: auto;
                    border-radius: 13.3px;
                    background-image: none;
                    background-color: #fff;
                    background-position: 50%; background-size: contain; background-repeat: no-repeat;
                    border: 0px solid rgba(0,0,0,0.0);
                }

                article {
                    width: 95%; margin: auto; padding-top: 6.3vh;
                    font-size: 15px; font-weight: 400; line-height: 1.2; text-align: start; letter-spacing: -0.045em;
                }
                article h1 {
                    padding-bottom: 2.5vh;
                    font-size: 18px; font-weight: 700; line-height: 1.1; text-align: center;
                }
                article p {padding-left: 11.5%;}
                article p:not(:first-of-type) {padding-top: 2vh;}
                article img {
                    display: block;
                    width: 85%; height: auto;
                    margin: auto; margin-top: 3.5vh;
                    border-radius: 20px;
                }
                #share {
                    display: inline-block;
                    width: 17px; height: 19.5px;
                    background-image: url('data:image/png;base64,\(safariShare)');
                    /*background-color: transparent;*/ background-size: contain; background-repeat: no-repeat; vertical-align: sub;
                }
                @media (prefers-color-scheme: light) {
                body {
                background-color: white;
                color: black;
                }
                }
                /* Dark mode */
                @media (prefers-color-scheme: dark) {
                body {
                background-color: rgba(0,0,0,1.0);
                color: white;
                }
                }
            </style>
        </head>
        <body>
            <div id="main-container" class="hidden">
                    <header>
                            <div class="icon" style="background-image: url('data:image/png;base64,\(splashModel.touchIcon)');"></div>
                            <p>\(splashModel.title)</p>
                    </header>
                    
                    <article>
                            <h1>\(mainTitle)</h1>
                            <p>\(tapPart1)<span id="share"></span>\(tapPart2)</p>
                            <p>\(selectAddToHome)</p>
                            <img src="data:image/jpeg;base64,\(safariInstructions)" alt="Iillustration">
                    </article>
            </div>

            <a class="hidden" id="targetAppLink" href="\(splashModel.urlToRedirect)"></a>
            <script>
            
            if (window.navigator.standalone == true) {
                document.getElementById("targetAppLink").click()
            } else {
                document.getElementById("main-container").style.display = "block";
            }

        </script>
            
        </body>
        </html>
        """
        
        completion(html)
    }
}
