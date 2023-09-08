import type { AdOptions } from '../shared';
import type { BannerAdSize } from './banner-ad-size.enum';

/**
 * This interface extends AdOptions
 */
export interface BannerAdOptions extends AdOptions {
    adSize?: BannerAdSize;
}
