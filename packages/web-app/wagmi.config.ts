import { defineConfig } from '@wagmi/cli'
import { hardhat, react } from '@wagmi/cli/plugins'

export default defineConfig({
  out: 'lib/blockchain.ts',
  plugins: [
    react(),
    hardhat({
      project: '../smart-contracts',
    }),
  ],
})
