
# 🏦 Bank - Web3 Savings Network Template

Bank uses the [TurboETH](https://github.com/turbo-eth/template-web3-app) and [Solbase](https://github.com/Sol-DAO/solbase) for a simple and gas optimized digital collectable application you can spin up minutes.

### Examples
- [bank.turboeth.xyz](bank.turboeth.xyz)

# Getting Started

*SSH*
```bash
git clone git@github.com:turbo-eth/template-bank-app.git
```

*HTTPS*
```bash
git clone https://github.com/turbo-eth/template-bank-app.git
```

The `pnpm` CLI is the recommended package manager but `npm` and `yarn` should work too.

```bash
pnpm install
```

#### Development
```bash
pnpm dev
```

#### Build
```bash
pnpm build
```

## 1-Click Deploy to Vercel

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fturbo-eth%template-bank-app&project-name=Places&repository-name=places&demo-title=Places&env=NEXT_PUBLIC_PROVIDER_PUBLIC&envDescription=How%20to%20get%20these%20env%20variables%3A&envLink=https%3A%2F%2Fgithub.com%2Fturbo-eth%template-bank-app%2Fblob%2Fmain%packages%2Fplaces-app%2F.env.example)

### Configuration
Since Places is a TurboRepo application we have to manually set the deployment configuration.

#### Build & Development Settings
- Build Command - `pnpm build`
- Output Directory - `.next`
- Install Command - `pnpm install`

#### Root Directory
- `packages/places-app`
- ☑️ Include source files outside of the Root Directory in the Build Step

#### Environment Variables
The application requires a JSON-RPC provider. The `public` provider can be used for testing, but in production it's recommended to use [Alchemy](https://www.alchemy.com/) or [Infura](https://www.infura.io/)

```
# Public Provider(s) - Useful for testing
NEXT_PUBLIC_PROVIDER_PUBLIC=true

# Alchemy: https://www.alchemy.com
NEXT_PUBLIC_ALCHEMY_API_KEYs=

# Infura: https://www.infura.io
NEXT_PUBLIC_INFURA_API_KEY=
```


[Click here for an image preview of the configration](https://user-images.githubusercontent.com/3408362/231420316-ee406a1c-ba4c-46b5-a7d7-571c390956c5.png)

## Architecture

Places is built using Turborepo - an incremental bundler and build system optimized for JavaScript and TypeScript

#### Packages
- [Application](https://github.com/turbo-eth/template-bank-app/blob/main/packages/places-app) - `app/places-app`
- [Smart Contracts](https://github.com/turbo-eth/template-bank-app/blob/main/packages/places-sol) - `app/places-sol`

#### Pages

- [Home](https://github.com/turbo-eth/template-bank-app/blob/main/packages/places-app/app/(general)/page.tsx) - `places-app/app/(general)/page.tsx`
- [Create](https://github.com/turbo-eth/template-bank-app/blob/main/packages/places-app/app/(general)/create/page.tsx) - `places-app/app/(general)/create/page.tsx`

#### Components

- [ButtonPlaceFactoryDeploy](https://github.com/turbo-eth/template-bank-app/blob/main/packages/places-app/components/places-factory-deploy.tsx) - `places-app/components/places-factory-deploy.tsx`
- [ButtonPlaceMint](https://github.com/turbo-eth/template-bank-app/blob/main/packages/places-app/components/button-place-mint.tsx) - `places-app/components/button-place-mint.tsx`
- [CardMintCollectable](https://github.com/turbo-eth/template-bank-app/blob/main/packages/places-app/components/card-mint-collectable.tsx) - `places-app/components/`

- [PlacesFactoryWriteCreatePlace](https://github.com/turbo-eth/template-bank-app/blob/main/packages/places-app/components/places-factory-write-create-place.tsx) - `places-app/components/places-factory-write-create-place.tsx`
- [PlaceFactoryEventPlaceCreated](https://github.com/turbo-eth/template-bank-app/blob/main/packages/places-app/components/places-factory-event-place-created.tsx) - `places-app/components/places-factory-event-place-created.tsx`

#### Smart Contracts

- [Place](https://github.com/turbo-eth/template-bank-app/blob/main/packages/places-sol/contracts/Place.sol) - `places-sol/contracts/Place.sol`
- [PlaceFactory](https://github.com/turbo-eth/template-bank-app/blob/main/packages/places-sol/contracts/PlaceFactory.sol) - `places-sol/contracts/PlaceFactory.sol`

# How It's Built
Places, the TurboETH template, uses a modern Typescript development stack.

### Web3 Core
- [Solbase](https://github.com/Sol-DAO/solbase) - Modern, opinionated, and gas optimized base for smart contract development.
- [TurboETH](https://github.com/turbo-eth/template-web3-app) - Web3 Application Template
- [WAGMI CLI](https://wagmi.sh/cli/getting-started) - Automatic React Hook Generation
- [RainbowKit](https://www.rainbowkit.com/) - Wallet connection manager
- [Sign-In With Ethereum](https://login.xyz/) - Account authentication

### Web2 Frameworks
- [TurboRepo](https://www.turboeth.xyz) - Turborepo is an incremental bundler and build system
- [Vercel](https://vercel.com/) - App Infrastructure

### Developer Experience
- [TypeScript](https://www.typescriptlang.org/) – Static type checker for end-to-end typesafety
- [Prettier](https://prettier.io/) – Opinionated code formatter for consistent code style
- [ESLint](https://eslint.org/) – Pluggable linter for Next.js and TypeScript

### User Interface
- [TailwindCSS](https://tailwindcss.com) – Utility-first CSS framework for rapid UI development
- [Radix](https://www.radix-ui.com/) – Primitives like modal, popover, etc. to build a stellar user experience
- [Framer Motion](https://www.framer.com/motion/) – Motion library for React to animate components with ease
- [Lucide](https://lucide.dev/docs/lucide-react) – Beautifully simple, pixel-perfect icons
