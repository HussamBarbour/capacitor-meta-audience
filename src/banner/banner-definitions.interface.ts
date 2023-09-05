import type { BannerAdOptions } from './banner-ad-options.interface';


// This is just to validate that we do not forget to implement any event name

export interface BannerDefinitions {
    /**
    * Show a banner Ad
    *
    * @group Banner
    * @param options AdOptions
    * @since 0.0.1
    */
    showBanner(options: BannerAdOptions): Promise<void>;

    /**
     * Hide the banner, remove it from screen, but can show it later
     *
     * @group Banner
     * @since 0.0.1
     */
    hideBanner(): Promise<void>;

    /**
     * Resume the banner, show it after hide
     *
     * @group Banner
     * @since 0.0.1
     */
    resumeBanner(): Promise<void>;

    /**
     * Destroy the banner, remove it from screen.
     *
     * @group Banner
     * @since 0.0.1
     */
    removeBanner(): Promise<void>;

}
