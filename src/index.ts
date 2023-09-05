import { registerPlugin } from '@capacitor/core';

import type { CapacitorMetaAudiencePlugin } from './definitions';

const CapacitorMetaAudience = registerPlugin<CapacitorMetaAudiencePlugin>(
  'CapacitorMetaAudience',
  {
    web: () => import('./web').then(m => new m.CapacitorMetaAudienceWeb()),
  },
);

export * from './definitions';
export * from './banner/index';
export * from './shared/index';
export { CapacitorMetaAudience };
