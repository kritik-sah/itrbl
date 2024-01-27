import { ConnectButton } from "@rainbow-me/rainbowkit";
import React, { ReactNode } from "react";
import { useAccount, useBalance } from "wagmi";

interface ContainerProps {
  children: ReactNode;
}

const Container: React.FC<ContainerProps> = ({ children }: ContainerProps) => {
  const { address, isConnecting, isDisconnected } = useAccount();
  return (
    <div className="flex items-center justify-center flex-grow flex-shrink-0 min-h-[75vh] p-4">
      <div className="border-2 border-dashed border-spacing-6-6 border-ui-white/10 p-4 w-full md:w-auto">
        <div className="bg-ui-stroke/50 p-5 bg-opacity-70 backdrop-filter backdrop-blur-lg">
          {isConnecting ? (
            <div className="text-ui-highlight">Connecting...</div>
          ) : isDisconnected ? (
            <div className="space-y-4">
              <div className="">
                <h3 className="text-ui-white">Welcome</h3>
                <p className="text-ui-white/60">
                  Connect to your wallet to get started.
                </p>
              </div>
              <div className="flex items-center justify-center">
                <ConnectButton />
              </div>
            </div>
          ) : address ? (
            children
          ) : (
            <div className="text-ui-highlight">Something went wrong!!!</div>
          )}
        </div>
      </div>
    </div>
  );
};

export default Container;
