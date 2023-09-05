import type { AdOptions } from '../shared';

export interface InterstitialDefinitions {
    /**
     * Show interstitial ad when it’s ready
     *
     * @group Interstitial
     * @since 0.0.1
     */
    showInterstitial(options: AdOptions): Promise<void>;

}
