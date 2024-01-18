import { ConnectButton } from "@rainbow-me/rainbowkit";
import React from "react";

const Header = () => {
  return (
    <header className="w-full p-4">
      <div className="flex flex-col md:flex-row justify-center md:justify-between items-center gap-4 bg-ui-stroke/50 border border-ui-white/30 p-5 rounded-full bg-opacity-70 backdrop-filter backdrop-blur-lg">
        <p className="font-bold text-2xl text-ui-highlight">ETH to Blast L2</p>
        <ConnectButton />
      </div>
    </header>
  );
};

export default Header;
