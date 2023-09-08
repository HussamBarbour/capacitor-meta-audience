import Foundation
import Capacitor
import FBAudienceNetwork

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(CapacitorMetaAudiencePlugin)
public class CapacitorMetaAudiencePlugin: CAPPlugin, FBInterstitialAdDelegate,FBAdViewDelegate {
    private let implementation = CapacitorMetaAudience()
    var adView: FBAdView?
    var currentCall: CAPPluginCall?
    var interstitialAd: FBInterstitialAd?

    
    @objc func showBanner(_ call: CAPPluginCall) {
        let placementId = call.getString("placementId") ?? ""
        let adSize = call.getString("adSize") ?? "BANNER_50"

        var bannerSize: FBAdSize = kFBAdSizeHeight50Banner
        var adHeight: CGFloat = 50
        switch adSize {
            case "BANNER_50":
                bannerSize = kFBAdSizeHeight50Banner
                adHeight = 50
            break
            case "BANNER_90":
                bannerSize = kFBAdSizeHeight90Banner
                adHeight = 90
            break
            case "RECTANGLE_HEIGHT_250":
                bannerSize = kFBAdSizeHeight250Rectangle
                adHeight = 250
            break
        default:
            break
        }
        currentCall = call

        DispatchQueue.main.async {
            // Instantiate an AdView object.
            self.adView = FBAdView(placementID: placementId, adSize: bannerSize, rootViewController: self.bridge?.viewController)

            // Get screen width
            let screenWidth = UIScreen.main.bounds.size.width

            guard let rootViewController = self.bridge?.viewController else {
                call.reject("Failed to get root view controller.")
                return
            }

            // Calculate y-position to place the ad at the bottom, respecting the safe area
            let safeAreaBottomInset = rootViewController.view.safeAreaInsets.bottom
            let yPos = UIScreen.main.bounds.size.height - adHeight - safeAreaBottomInset

            self.adView?.frame = CGRect(x: 0, y: yPos, width: screenWidth, height: adHeight)
            
            self.adView?.delegate = self
            self.adView?.loadAd()

            rootViewController.view.addSubview(self.adView!)
        }
    }
    
    @objc func hideBanner(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            self.adView?.isHidden = true
            call.resolve(["success": true])
        }
    }
    
    @objc func removeBanner(_ call: CAPPluginCall) {
        DispatchQueue.main.async {
            self.adView?.removeFromSuperview()
            call.resolve() // Send a response back indicating the banner is removed.
        }
    }
    
    @objc func resumeBanner(_ call: CAPPluginCall) {
            DispatchQueue.main.async {
                self.adView?.isHidden = false
                call.resolve(["success": true])
            }
    }

    
    
    
    // MARK: - FBAdViewDelegate

    public func adViewDidLoad(_ adView: FBAdView) {
        print("Banner Ad was loaded and is ready to be displayed")
        // Resolve the call
        currentCall?.resolve(["success": "Banner Ad was loaded and is ready to be displayed"])
        currentCall = nil // Clear the reference after use
    }

    public func adView(_ adView: FBAdView, didFailWithError error: Error) {
        print("Banner Ad failed to load with error: \(error.localizedDescription)")
        currentCall?.reject("Banner Ad failed to load with error: \(error.localizedDescription)")
        currentCall = nil // Clear the reference after use
    }
    
    
    @objc func showInterstitial(_ call: CAPPluginCall) {
        let placementId = call.getString("placementId") ?? ""
        
        DispatchQueue.main.async {
            // Instantiate an InterstitialAd object.
            self.interstitialAd = FBInterstitialAd(placementID:placementId)
            self.interstitialAd?.delegate = self
            // Load the ad.
            self.interstitialAd?.load()
        }
    }

    // MARK: - FBInterstitialAdDelegate

    public func interstitialAdDidLoad(_ interstitialAd: FBInterstitialAd) {
        guard interstitialAd.isAdValid else {
            return
        }
                print("Ad is loaded and ready to be displayed")
                
                if let viewController = self.bridge?.viewController {
                    interstitialAd.show(fromRootViewController: viewController)
                }
            }

            public func interstitialAd(_ interstitialAd: FBInterstitialAd, didFailWithError error: Error) {
                // Handle ad load failure
                print("Ad failed to load with error: \(error.localizedDescription)")
            }

}
