import { WebPlugin } from '@capacitor/core';

import type { CapacitorMetaAudiencePlugin } from './definitions';
import { AdOptions } from './shared';

export class CapacitorMetaAudienceWeb
  extends WebPlugin
  implements CapacitorMetaAudiencePlugin
{
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }

  async showBanner(options: AdOptions): Promise<void> {
    console.log('showBanner', options);
  }

  // Hide the banner, remove it from screen, but can show it later
  async hideBanner(): Promise<void> {
    console.log('hideBanner');
  }

  // Resume the banner, show it after hide
  async resumeBanner(): Promise<void> {
    console.log('resumeBanner');
  }

  // Destroy the banner, remove it from screen.
  async removeBanner(): Promise<void> {
    console.log('removeBanner');
  }

  async showInterstitial(): Promise<void> {
    console.log('showInterstitial');
  }

}
