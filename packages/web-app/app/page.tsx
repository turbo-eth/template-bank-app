'use client'

import { motion } from 'framer-motion'

import { CardPreviewRender } from '@/components/card-preview-render'
import { FADE_DOWN_ANIMATION_VARIANTS } from '@/config/design'

export default function Home() {
  return (
    <>
      <section className="w-full">
        <div className="container mx-auto grid max-w-screen-lg">
          <motion.div
            className="flex flex-col items-center justify-center"
            initial="hidden"
            whileInView="show"
            animate="show"
            viewport={{ once: true }}
            variants={{
              hidden: {},
              show: {
                transition: {
                  staggerChildren: 0.15,
                },
              },
            }}>
            <CardPreviewRender />
          </motion.div>
        </div>
      </section>
    </>
  )
}
