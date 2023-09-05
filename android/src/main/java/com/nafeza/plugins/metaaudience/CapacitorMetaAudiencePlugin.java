package com.nafeza.plugins.metaaudience;

import android.app.Activity;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;
import com.facebook.ads.*;

@CapacitorPlugin(name = "CapacitorMetaAudience")
public class CapacitorMetaAudiencePlugin extends Plugin {

    private CapacitorMetaAudience implementation = new CapacitorMetaAudience();
    private InterstitialAd interstitialAd;
    private AdView adView;
    private PluginCall saveCall;
    @PluginMethod
    public void echo(PluginCall call) {
        String value = call.getString("value");

        JSObject ret = new JSObject();
        ret.put("value", implementation.echo(value));
        call.resolve(ret);
    }

  @PluginMethod()
  public void showBanner(PluginCall call) {
    String providedPlacementId = call.getString("placementId");
    final String placementId;

    if (providedPlacementId == null || providedPlacementId.isEmpty()) {
      placementId = "IMG_16_9_APP_INSTALL#YOUR_PLACEMENT_ID"; // Default value
    } else {
      placementId = providedPlacementId;
    }

    getActivity().runOnUiThread(() -> {
      // Instantiate an AdView object
      adView = new AdView(getContext(), placementId, AdSize.BANNER_HEIGHT_50);

      // Retrieve the root content layout
      FrameLayout rootLayout = getActivity().findViewById(android.R.id.content);

      // Create FrameLayout.LayoutParams for the AdView
      FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(FrameLayout.LayoutParams.MATCH_PARENT, FrameLayout.LayoutParams.WRAP_CONTENT);
      params.gravity = Gravity.BOTTOM;  // Ensure the banner ad is positioned at the bottom

      // Add the AdView to the root layout with the params
      rootLayout.addView(adView, params);

      adView.loadAd();

      JSObject ret = new JSObject();
      ret.put("success", true);
      call.resolve(ret);
    });
  }

  @PluginMethod()
  public void hideBanner(PluginCall call) {
    if (adView != null) {
      getActivity().runOnUiThread(() -> {
        adView.setVisibility(View.GONE);
        call.resolve();
      });
    } else {
      call.reject("Banner not initialized");
    }
  }

  @PluginMethod()
  public void removeBanner(PluginCall call) {
    getActivity().runOnUiThread(() -> {
      if (adView != null) {
        // Remove AdView from its parent layout
        ((ViewGroup) adView.getParent()).removeView(adView);

        // Release resources of the AdView
        adView.destroy();
        adView = null;

        JSObject ret = new JSObject();
        ret.put("success", true);
        call.resolve(ret);
      } else {
        JSObject ret = new JSObject();
        ret.put("error", "AdView is not initialized");
        call.reject("AdView is not initialized");
      }
    });
  }

  @PluginMethod()
  public void resumeBanner(PluginCall call) {
    if (adView != null) {
      getActivity().runOnUiThread(() -> {
        adView.setVisibility(View.VISIBLE);
        call.resolve();
      });
    } else {
      call.reject("Banner not initialized");
    }
  }

  @PluginMethod()
  public void showInterstitial(PluginCall call) {
    Activity activity = getActivity();
    String placementId = call.getString("placementId");

    if (activity != null) {
      interstitialAd = new InterstitialAd(activity, placementId);

      InterstitialAdListener interstitialAdListener = new InterstitialAdListener() {
        @Override
        public void onInterstitialDisplayed(Ad ad) {
          Log.e("InterstitialAdActivity", "Interstitial ad displayed.");
        }

        @Override
        public void onInterstitialDismissed(Ad ad) {
          Log.e("InterstitialAdActivity", "Interstitial ad dismissed.");
        }

        @Override
        public void onError(Ad ad, AdError adError) {
          Log.e("InterstitialAdActivity", "Interstitial ad failed to load: " + adError.getErrorMessage());
        }

        @Override
        public void onAdLoaded(Ad ad) {
          Log.d("InterstitialAdActivity", "Interstitial ad is loaded and ready to be displayed!");
          interstitialAd.show();
        }

        @Override
        public void onAdClicked(Ad ad) {
          Log.d("InterstitialAdActivity", "Interstitial ad clicked!");
        }

        @Override
        public void onLoggingImpression(Ad ad) {
          Log.d("InterstitialAdActivity", "Interstitial ad impression logged!");
        }
      };

      interstitialAd.loadAd(
        interstitialAd.buildLoadAdConfig()
          .withAdListener(interstitialAdListener)
          .build());

      call.resolve();
    } else {
      call.reject("Activity is null");
    }
  }
}
