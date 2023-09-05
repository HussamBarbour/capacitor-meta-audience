#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(CapacitorMetaAudiencePlugin, "CapacitorMetaAudience",
           CAP_PLUGIN_METHOD(echo, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(showBanner, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(hideBanner, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(removeBanner, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(resumeBanner, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(showInterstitial, CAPPluginReturnPromise);
)
