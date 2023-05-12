import * as React from 'react'

import classNames from 'classnames'
import { useAccount } from 'wagmi'

import { contractsCards } from '@/config/contracts-cards'
import { useCardPreview } from '@/lib/blockchain'
import { useLoadContractFromChainId } from '@/lib/hooks/use-load-contract-from-chain-id.ts'

interface CardPreviewRenderProps {
  className?: string
}

export const CardPreviewRender = ({ className }: CardPreviewRenderProps) => {
  const account = useAccount()
  const classes = classNames(className, 'CardPreviewRender')
  const contractAddress = useLoadContractFromChainId(contractsCards)

  const preview = useCardPreview({
    address: contractAddress as `0x${string}`,
    args: [account.address as `0x${string}`],
  })

  if (!preview.data) {
    return null
  }

  return (
    <div className={classes}>
      <img alt="Savings Card" className={classes} src={preview.data} />
    </div>
  )
}
