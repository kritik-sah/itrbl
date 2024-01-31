import { ConnectButton } from "@rainbow-me/rainbowkit";
import Link from "next/link";
import React from "react";

const Header = () => {
  return (
    <header className="w-full">
      <div className="flex flex-col md:flex-row justify-center md:justify-between items-center gap-4 bg-ui-black/20 shadow-sm shadow-ui-stroke p-5 bg-opacity-70 backdrop-filter backdrop-blur-lg">
        <Link href={"/"} className="font-bold text-2xl text-ui-highlight">
          IT Rebel&apos;s
        </Link>
        <ConnectButton />
      </div>
      <div className="bg-ui-highlight flex w-full overflow-hidden items-center justify-start gap-4">
        <ul className="flex flex-shrink-0 items-center gap-4 text-sm p-3">
          <li>
            <Link
              className="text-ui-white transition hover:text-ui-white/75"
              href="/mint"
            >
              Mint
            </Link>
          </li>

          <li>
            <Link
              className="text-ui-white transition hover:text-ui-white/75"
              href="/levelup"
            >
              Level Up
            </Link>
          </li>

          <li>
            <Link
              className="text-ui-white transition hover:text-ui-white/75"
              href="/tradelevel"
            >
              Trade
            </Link>
          </li>
        </ul>
        <div className="relative flex flex-shrink-0 flex-grow bg-ui-highlight text-ui-white overflow-hidden">
          <p className="animate-marquee whitespace-nowrap w-full">
            Public mint will start from 10th Feb 2024. and If you want to take
            part in pre public mint (1st Feb) you must hold a{" "}
            <a
              href="https://opensea.io/collection/founders-of-zo-world"
              target="_blank"
              rel="noopener noreferrer"
            >
              &quot;Zo World Founders&quot;
            </a>{" "}
            NFT ~
          </p>
        </div>
      </div>
    </header>
  );
};

export default Header;
