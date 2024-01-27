import Link from "next/link";
import React from "react";
import { FaDiscord } from "react-icons/fa";
import { HiOutlineExternalLink } from "react-icons/hi";
import { HiOutlineChevronRight } from "react-icons/hi2";

const Hero = () => {
  return (
    <>
      {/* Hero */}
      <div className="w-full h-full">
        <div className="max-w-[85rem] mx-auto px-4 sm:px-6 lg:px-8 pt-24 pb-10">
          {/* Announcement Banner */}
          <div className="flex justify-center">
            <a
              className="inline-flex items-center gap-x-2 bg-ui-dark/20 border border-ui-stroke/70 text-sm p-1 ps-3 rounded-full transition hover:border-ui-stroke/50 bg-ui-stroke-800 border-ui-stroke/60 hover:borderui-stroke/80 text-ui-white/70 focus:outline-none focus:ring-1 focus:ring-ui-stroke/80"
              href="https://discord.gg/4D3ThMNXEt"
              target="_blank"
              rel="noopener noreferrer"
            >
              Join us on Discord - One way rebel&apos;s
              <span className="py-1.5 px-2.5 inline-flex justify-center items-center gap-x-2 rounded-full font-semibold text-sm text-ui-white/80 bg-ui-stroke/60">
                <FaDiscord />
              </span>
            </a>
          </div>
          {/* End Announcement Banner */}
          {/* Title */}
          <div className="mt-5 max-w-2xl text-center mx-auto">
            <h1 className="block font-bold text-ui-white/80 text-4xl md:text-5xl lg:text-6xl">
              Let&apos;s Build{" "}
              <span className="bg-clip-text bg-gradient-to-tl from-ui-primary to-ui-highlight text-transparent">
                Together
              </span>
            </h1>
          </div>
          {/* End Title */}
          <div className="mt-5 max-w-3xl text-center mx-auto">
            <p className="text-lg text-ui-white/80">
              Dive into the decentralized universe with our unique on-chain
              evolving NFTs. Mint your ITRBL token, discover your class, unlock
              attacks, and trade levels with contributors.
            </p>
          </div>
          {/* Buttons */}
          <div className="mt-8 gap-3 flex justify-center">
            <Link
              className="inline-flex justify-center items-center gap-x-3 text-center bg-gradient-to-tl from-ui-primary to-ui-highlight hover:from-ui-primary/90 hover:to-ui-highlight/90 border border-transparent text-ui-white/90 text-sm font-medium rounded-md focus:outline-none focus:ring-1 focus:ring-ui-stroke/80 py-3 px-4"
              href="/mint"
            >
              Get started
              <HiOutlineChevronRight />
            </Link>
            <a
              className="relative group p-2 ps-3 inline-flex items-center gap-x-2 text-sm font-mono rounded-lg border border-ui-stroke/70 bg-ui-dark/20 text-ui-white/80 shadow-sm hover:bg-ui-stroke/50 disabled:opacity-50 disabled:pointer-events-none hover:bg-ui-stroke focus:outline-none focus:ring-1"
              href="https://polygonscan.com/token/0xda024eac8df62910b468e7ef80fb6709cb1a95a1#code"
              target="_blank"
              rel="noopener noreferrer"
            >
              Smart Contract
              <span className="flex justify-center items-center bg-ui-stroke/70 rounded-md w-7 h-7 text-ui-white/40">
                <HiOutlineExternalLink />
              </span>
            </a>
          </div>
          {/* End Buttons */}
          {/* <div className="mt-5 flex justify-center items-center gap-x-1 sm:gap-x-3">
            <span className="text-sm text-ui-stroke/80 text-ui-stroke/40">
              Package Manager:
            </span>
            <span className="text-sm font-bold text-ui-stroke-900 text-ui-dark/20">
              npm
            </span>
            <svg
              className="h-5 w-5 text-ui-stroke/50 text-ui-stroke/80"
              width={16}
              height={16}
              viewBox="0 0 16 16"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
              aria-hidden="true"
            >
              <path
                d="M6 13L10 3"
                stroke="currentColor"
                strokeLinecap="round"
              />
            </svg>
            <a
              className="inline-flex items-center gap-x-1.5 text-sm text-blue-600 decoration-2 hover:underline font-medium"
              href="#"
            >
              Installation Guide
              <svg
                className="flex-shrink-0 w-4 h-4"
                width={16}
                height={16}
                viewBox="0 0 16 16"
                fill="none"
              >
                <path
                  d="M5.27921 2L10.9257 7.64645C11.1209 7.84171 11.1209 8.15829 10.9257 8.35355L5.27921 14"
                  stroke="currentColor"
                  strokeWidth={2}
                  strokeLinecap="round"
                />
              </svg>
            </a>
          </div> */}
        </div>
      </div>
      {/* End Hero */}
    </>
  );
};

export default Hero;
