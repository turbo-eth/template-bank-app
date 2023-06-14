
# 🏦 Bank - Web3 Savings Network Template

Banks is a template for the upcoming PoolTogether V5 hyperstructure.

The template will include support for depositing and withdrawing into prize pool vaults. Plus allow operators to easily deploy new savings assets/vaults and create custom rewards.

The [Web3 Savings Cards prototype](https://web3savings.network) will also incorporated into the final application template.

### Examples
- [bank.turboeth.xyz](bank.turboeth.xyz)

# Status

The template is being actively developed. Right now the focus is the application scaffolding and layout.

- [ ] Scaffolding & Layout
- [ ] Integrate Smart Contracts
- [ ] Deploy Testnet Version
- [ ] Deploy Product Version

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
[label](README.md)```

#### Build
```bash
pnpm build
```

## 1-Click Deploy to Vercel

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fturbo-eth%template-bank-app&project-name=Bank&repository-name=Bank&demo-title=Bank&env=NEXT_PUBLIC_PROVIDER_PUBLIC&envDescription=How%20to%20get%20these%20env%20variables%3A&envLink=https%3A%2F%2Fgithub.com%2Fturbo-eth%template-bank-app%2Fblob%2Fmain%packages%2FBank-app%2F.env.example)

### Configuration
Since Bank is a TurboRepo application we have to manually set the deployment configuration.

#### Build & Development Settings
- Build Command - `pnpm build`
- Output Directory - `.next`
- Install Command - `pnpm install`

#### Root Directory
- `packages/web-app`
- ☑️ Include source files outside of the Root Directory in the Build Step

#### Environment Variables
The application requires a JSON-RPC provider. The `public` provider can be used for testing, but in production it's recommended to use [Alchemy](https://www.alchemy.com/) or [Infura](https://www.infura.io/)

```
# Public Provider(s) - Useful for testing
NEXT_PUBLIC_PROVIDER_PUBLIC=true

# Alchemy: https://www.alchemy.com
NEXT_PUBLIC_ALCHEMY_API_KEY=

# Infura: https://www.infura.io
NEXT_PUBLIC_INFURA_API_KEY=
```

[Click here for an image preview of the configration](https://user-images.githubusercontent.com/3408362/231420316-ee406a1c-ba4c-46b5-a7d7-571c390956c5.png)

## Architecture

Bank is built using Turborepo - an incremental bundler and build system optimized for JavaScript and TypeScript

# How It's Built
Bank, the TurboETH template, uses a modern Typescript development stack.

### Web3 Core
- [Solbase](https://github.com/Sol-DAO/solbase) - Modern, opinionated, and gas optimized base for smart contract development.
- [TurboETH](https://github.com/turbo-eth/template-web3-app) - Web3 Application Template
- [WAGMI CLI](https://wagmi.sh/cli/getting-started) - Automatic React Hook Generation
- [RainbowKit](https://www.rainbowkit.com/) - Wallet connection manager

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
