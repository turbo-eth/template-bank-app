'use client'

import { ThemeProvider } from 'next-themes'

import { RainbowKit } from '@/components/providers/rainbow-kit'
import { useIsMounted } from '@/lib/hooks/use-is-mounted'

interface RootProviderProps {
  children: React.ReactNode
}

export default function RootProvider({ children }: RootProviderProps) {
  const isMounted = useIsMounted()
  return (
    <>
      {isMounted && (
        <ThemeProvider>
          <RainbowKit>{children}</RainbowKit>
        </ThemeProvider>
      )}
    </>
  )
}
