import { registerPlugin } from '@capacitor/core';

import type { CapacitorMetaAudiencePlugin } from './definitions';

const CapacitorMetaAudience = registerPlugin<CapacitorMetaAudiencePlugin>(
  'CapacitorMetaAudience',
  {
    initialize: () => import('./web').then(m => new m.CapacitorMetaAudienceWeb()),
    showBanner: () => import('./web').then(m => new m.CapacitorMetaAudienceWeb()),
    hideBanner: () => import('./web').then(m => new m.CapacitorMetaAudienceWeb()),
    resumeBanner: () => import('./web').then(m => new m.CapacitorMetaAudienceWeb()),
    removeBanner: () => import('./web').then(m => new m.CapacitorMetaAudienceWeb()),
    showInterstitial: () => import('./web').then(m => new m.CapacitorMetaAudienceWeb()),
  },
);

export * from './definitions';
export * from './banner/index';
export * from './shared/index';
export { CapacitorMetaAudience };
