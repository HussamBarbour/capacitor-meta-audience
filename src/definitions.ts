import type { BannerAdOptions, BannerDefinitions } from './banner';
import type { InterstitialDefinitions } from './interstitial';
import type { AdOptions } from './shared';

type MetaAudienceDefinitions = BannerDefinitions &
InterstitialDefinitions;
export interface CapacitorMetaAudiencePlugin extends MetaAudienceDefinitions {
  showBanner(options: BannerAdOptions): Promise<void>;
  hideBanner(): Promise<void>;
  resumeBanner(): Promise<void>;
  removeBanner(): Promise<void>;
  showInterstitial(options: AdOptions): Promise<void>;
}
