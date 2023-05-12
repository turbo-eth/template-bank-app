// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
// Site
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
interface SiteConfig {
  name: string
  title: string
  emoji: string
  description: string
  localeDefault: string
  author: string
  links: {
    twitter: string
    github: string
  }
}

export const SITE_CANONICAL = 'https://bank.turboeth.xyz'

export const siteConfig: SiteConfig = {
  name: 'bank',
  title: 'bank - web3 savings network',
  emoji: '🏦',
  description: 'A better way to save.',
  localeDefault: 'en',
  author: 'Kames Geraghty',
  links: {
    twitter: 'https://twitter.com/KamesGeraghty',
    github: 'https://github.com/turbo-eth/template-bank-app',
  },
}
