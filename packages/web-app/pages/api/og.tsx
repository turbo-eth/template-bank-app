/* eslint-disable @next/next/no-img-element */
import { ImageResponse } from '@vercel/og'
import { NextRequest } from 'next/server'

import { siteConfig } from '@/config/site'

export const config = {
  runtime: 'experimental-edge',
}

export default async function handler(req: NextRequest) {
  return new ImageResponse(
    (
      <div tw="flex p-0">
        <div tw="flex flex-col w-1/2 p-10">
          <h1 tw="opacity-100 text-8xl font-bold">{siteConfig.name}</h1>
          <h3 tw="opacity-100 text-3xl text-gray-500 font-light font-primary">{siteConfig.description}</h3>
        </div>
      </div>
    ),
    {
      width: 1200,
      height: 630,
    }
  )
}
