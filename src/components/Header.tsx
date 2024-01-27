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
      <div className="bg-ui-highlight flex items-center justify-start gap-4">
        <ul className="flex items-center gap-4 text-sm p-3">
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
      </div>
    </header>
  );
};

export default Header;
