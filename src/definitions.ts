import type { BannerDefinitions } from './banner';
import type { InterstitialDefinitions } from './interstitial';

type MetaAudienceDefinitions = BannerDefinitions &
InterstitialDefinitions;
export interface CapacitorMetaAudiencePlugin extends MetaAudienceDefinitions {
  echo(options: { value: string }): Promise<{ value: string }>;
}
