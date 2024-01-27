import Link from "next/link";
import React, { useState } from "react";
import { FaGithub, FaYoutube } from "react-icons/fa";
import { SiOpensea } from "react-icons/si";

const SiteHeader = () => {
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

  const toggleMobileMenu = () => {
    setIsMobileMenuOpen((prev) => !prev);
  };

  return (
    <header className="bg-ui-black/20">
      <div className="mx-auto max-w-screen-xl px-4 sm:px-6 lg:px-8">
        <div className="flex h-16 items-center justify-between">
          <div className="flex-1 md:flex md:items-center md:gap-12">
            <Link href={"/"} className="font-bold text-2xl text-ui-highlight">
              IT Rebel&apos;s
            </Link>
          </div>

          <div className="md:flex md:items-center md:gap-12">
            <nav aria-label="Global" className="hidden md:block">
              <ul className="flex items-center gap-6 text-sm">
                <li>
                  <Link
                    className="text-gray-500 transition hover:text-gray-500/75"
                    href="/mint"
                  >
                    Mint
                  </Link>
                </li>

                <li>
                  <Link
                    className="text-gray-500 transition hover:text-gray-500/75"
                    href="/levelup"
                  >
                    Level Up
                  </Link>
                </li>

                <li>
                  <Link
                    className="text-gray-500 transition hover:text-gray-500/75"
                    href="/tradelevel"
                  >
                    Trade
                  </Link>
                </li>

                <li>
                  <Link
                    className="text-gray-500 transition hover:text-gray-500/75"
                    href="https://snapshot.org/#/itrebel.eth"
                    target="_blank"
                    rel="noopener noreferrer"
                  >
                    IT Rebel DAO
                  </Link>
                </li>
              </ul>
            </nav>

            <div className="flex items-center gap-4">
              <div className="sm:flex sm:gap-4">
                <Link
                  className="rounded-md bg-ui-highlight px-5 py-2.5 text-sm font-medium text-white shadow"
                  href="/mint"
                >
                  Mint NFT
                </Link>

                <div className="hidden sm:flex">
                  <Link
                    className="rounded-md bg-gray-100 px-5 py-2.5 text-sm font-medium text-ui-highlight flex items-center gap-2"
                    href="https://opensea.io/collection/contributors-of-it-rebel"
                    target="_blank"
                    rel="noopener noreferrer"
                  >
                    <SiOpensea className="text-xl" /> OpenSea
                  </Link>
                </div>
              </div>

              <div className="block md:hidden">
                <button
                  onClick={toggleMobileMenu}
                  className="rounded bg-gray-100 p-2 text-gray-600 transition hover:text-gray-600/75"
                >
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    className="h-5 w-5"
                    fill="none"
                    viewBox="0 0 24 24"
                    stroke="currentColor"
                    strokeWidth="2"
                  >
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      d="M4 6h16M4 12h16M4 18h16"
                    />
                  </svg>
                </button>

                {isMobileMenuOpen && (
                  <div className="absolute top-16 left-0 w-full bg-ui-dark/95 py-4 px-2">
                    <ul className="flex flex-col items-start gap-4 text-ui-white">
                      <li className="w-full">
                        <Link
                          className="p-2 flex items-center justify-start hover:bg-ui-stroke/20 w-full"
                          href="/mint"
                        >
                          Mint
                        </Link>
                      </li>
                      <li className="w-full">
                        <Link
                          className="p-2 flex items-center justify-start hover:bg-ui-stroke/20 w-full"
                          href="/levelup"
                        >
                          Level Up
                        </Link>
                      </li>
                      <li className="w-full">
                        <Link
                          className="p-2 flex items-center justify-start hover:bg-ui-stroke/20 w-full"
                          href="/tradelevel"
                        >
                          Trade
                        </Link>
                      </li>
                      <li className="w-full">
                        <a
                          className="p-2 flex items-center justify-start hover:bg-ui-stroke/20 w-full"
                          href="https://snapshot.org/#/itrebel.eth"
                          target="_blank"
                          rel="noopener noreferrer"
                        >
                          IT Rebel DAO
                        </a>
                      </li>
                      <li className="w-full flex items-center justify-center gap-4 p-4">
                        <a
                          className="h-8 w-8 bg-ui-white rounded flex items-center justify-center text-ui-highlight text-xl"
                          href="https://opensea.io/collection/contributors-of-it-rebel"
                          target="_blank"
                          rel="noopener noreferrer"
                        >
                          <SiOpensea />
                        </a>
                        <a
                          className="h-8 w-8 bg-ui-white rounded flex items-center justify-center text-ui-highlight text-xl"
                          href="https://opensea.io/collection/contributors-of-it-rebel"
                          target="_blank"
                          rel="noopener noreferrer"
                        >
                          <FaYoutube />
                        </a>
                        <a
                          className="h-8 w-8 bg-ui-white rounded flex items-center justify-center text-ui-highlight text-xl"
                          href="https://opensea.io/collection/contributors-of-it-rebel"
                          target="_blank"
                          rel="noopener noreferrer"
                        >
                          <FaGithub />
                        </a>
                      </li>
                    </ul>
                  </div>
                )}
              </div>
            </div>
          </div>
        </div>
      </div>
    </header>
  );
};

export default SiteHeader;
