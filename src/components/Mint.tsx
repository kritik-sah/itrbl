import Image from "next/image";
import React, { useEffect, useState } from "react";
import {
  useContractRead,
  useContractWrite,
  useWaitForTransaction,
} from "wagmi";
import itrblAbi from "../libs/abi.json";
import zoAbi from "../libs/zoAbi.json";

import { FaExternalLinkAlt } from "react-icons/fa";
import { toast } from "react-toastify";
import { Address, parseEther, parseGwei } from "viem";
import { useAccount, useBalance } from "wagmi";
import Container from "./ui/Container";
import WalletInput from "./ui/WalletInput";

const ZoFounderNFTcontract = "0xF9e631014Ce1759d9B76Ce074D496c3da633BA12";
const publicMintDate = new Date("10 feb 2024");

const MintNft = () => {
  const [collectionStats, setCollectionStats] = useState<any>();
  const [isPermitedToMint, setIsPermitedToMint] = useState<boolean>(false);
  const { address } = useAccount();
  const { data: balanceData, refetch: refetchBalance } = useBalance({
    address,
  });
  const [sendToAddress, setSendToAddress] = useState<any>(address);

  const contractAddress: Address = `0x${process.env.NEXT_PUBLIC_CONTRACT_ADDRESS}`;
  const { data: mintData, write: mint } = useContractWrite({
    address: contractAddress,
    abi: itrblAbi,
    functionName: "safeMint",
    gas: BigInt(3137928),
    maxFeePerGas: parseGwei("120"),
    onError(error) {
      toast.error(error.message);
    },
  });

  const { isLoading: isTxnProcessing } = useWaitForTransaction({
    hash: mintData?.hash,
    onSuccess() {
      toast.success("NFT minted");
      totalSupply.refetch();
      yourHolding.refetch();
      refetchBalance();
    },
  });

  const mintValue = useContractRead({
    address: contractAddress,
    abi: itrblAbi,
    functionName: "mintValue",
  });

  const maxSupply = useContractRead({
    address: contractAddress,
    abi: itrblAbi,
    functionName: "maxSupply",
  });
  const totalSupply = useContractRead({
    address: contractAddress,
    abi: itrblAbi,
    functionName: "totalSupply",
  });
  const yourHolding = useContractRead({
    address: contractAddress,
    abi: itrblAbi,
    functionName: "balanceOf",
    args: [address],
  });
  const yourZoHolding = useContractRead({
    address: ZoFounderNFTcontract,
    abi: zoAbi,
    functionName: "balanceOf",
    args: [address],
    chainId: 1,
  });
  const sendigToZoHolding = useContractRead({
    address: ZoFounderNFTcontract,
    abi: zoAbi,
    functionName: "balanceOf",
    args: [sendToAddress],
    chainId: 1,
  });

  function checkPermisions() {
    if (
      Number(yourZoHolding?.data) > 0 ||
      Number(sendigToZoHolding?.data) > 0
    ) {
      console.log("yourZoHolding?.data", yourZoHolding?.data);
      return true;
    }
    if (new Date() >= publicMintDate) {
      return true;
    } else {
      return false;
    }
  }

  useEffect(() => {
    const options = {
      method: "GET",
      headers: {
        accept: "application/json",
        "x-api-key": process.env.NEXT_PUBLIC_OPENSEA_API_KEY!,
      },
    };

    fetch(
      "https://api.opensea.io/api/v2/collections/contributors-of-it-rebel/stats",
      options
    )
      .then((response) => response.json())
      .then((response) => {
        console.log(response);
        setCollectionStats(response);
      })
      .catch((err) => console.error(err));
  }, []);

  useEffect(() => {
    if (address) {
      const permit = checkPermisions();
      console.log("Permit", permit, address, sendToAddress);
      setIsPermitedToMint(permit);
    }
  }, [address, yourZoHolding]);

  const handleMintClick = () => {
    // Add your logic for handling the "Send" button click
    if (address && isPermitedToMint && typeof mintValue?.data === "bigint") {
      mint({
        args: [sendToAddress],
        to: sendToAddress,
        value: mintValue?.data,
      });
    }
  };

  return (
    <Container>
      <div className="flex flex-col md:flex-row gap-6 mb-4">
        <div className="flex items-center justify-center">
          <Image
            src="/images/mystery-box.png"
            alt="Unlock you ITRBL NFT now!!!"
            height="300"
            width="251"
          />
        </div>

        <div className="space-y-4">
          <div className="mt-2 grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 justify-center items-center gap-4">
            {/* Total Supply */}
            <div className="flex h-20 min-w-40 flex-col items-center justify-center rounded-md border border-dashed border-ui-white/10 transition-colors duration-100 ease-in-out hover:border-gray-400/80">
              <div className="flex flex-row items-center justify-center">
                <span className="font-bold text-ui-highlight">
                  {typeof maxSupply?.data === "bigint"
                    ? Number(maxSupply?.data)
                    : 0}
                </span>
              </div>
              <div className="mt-2 text-sm text-gray-400">Max Supply</div>
            </div>

            <div className="flex h-20 min-w-40 flex-col items-center justify-center rounded-md border border-dashed border-ui-white/10 transition-colors duration-100 ease-in-out hover:border-gray-400/80">
              <div className="flex flex-row items-center justify-center">
                <span className="font-bold text-ui-highlight">
                  {typeof totalSupply?.data === "bigint"
                    ? Number(totalSupply?.data)
                    : 0}
                </span>
              </div>
              <div className="mt-2 text-sm text-gray-400">Total Supply</div>
            </div>

            <div className="flex h-20 min-w-40 flex-col items-center justify-center rounded-md border border-dashed border-ui-white/10 transition-colors duration-100 ease-in-out hover:border-gray-400/80">
              <div className="flex flex-row items-center justify-center">
                <span className="font-bold text-ui-highlight">
                  {typeof yourHolding?.data === "bigint"
                    ? Number(yourHolding?.data)
                    : 0}
                </span>
              </div>
              <div className="mt-2 text-sm text-gray-400">Your Holding</div>
            </div>

            <div className="flex h-20 min-w-40 flex-col items-center justify-center rounded-md border border-dashed border-ui-white/10 transition-colors duration-100 ease-in-out hover:border-gray-400/80">
              <div className="flex flex-row items-center justify-center">
                <span className="font-bold text-ui-highlight">
                  {`${collectionStats?.total?.floor_price} ${collectionStats?.total?.floor_price_symbol}`}
                </span>
              </div>
              <div className="mt-2 text-sm text-gray-400">Floor Price</div>
            </div>

            <div className="flex h-20 min-w-40 flex-col items-center justify-center rounded-md border border-dashed border-ui-white/10 transition-colors duration-100 ease-in-out hover:border-gray-400/80">
              <div className="flex flex-row items-center justify-center">
                <span className="font-bold text-ui-highlight">
                  {collectionStats?.total?.market_cap}
                </span>
              </div>
              <div className="mt-2 text-sm text-gray-400">Market Cap</div>
            </div>

            <div className="flex h-20 min-w-40 flex-col items-center justify-center rounded-md border border-dashed border-ui-white/10 transition-colors duration-100 ease-in-out hover:border-gray-400/80">
              <div className="flex flex-row items-center justify-center">
                <span className="font-bold text-ui-highlight">
                  {collectionStats?.total?.num_owners}
                </span>
              </div>
              <div className="mt-2 text-sm text-gray-400">
                Unique Owner&lsquo;s
              </div>
            </div>
          </div>
          <div className="flex flex-col items-start justify-between gap-2 text-ui-white">
            <p>
              Current Balance:{" "}
              <span className="text-ui-highlight">
                {Number(balanceData?.formatted)?.toFixed(4)}
                {` $${balanceData?.symbol}`}
              </span>
            </p>
            <p>
              Zo World Founder Member:{" "}
              <span className="text-ui-highlight">
                {Number(yourZoHolding?.data) > 0
                  ? `Zo Zo Zo...bro!`
                  : "oops!!! wait a minute, Who are you?"}
              </span>
            </p>
          </div>
        </div>
      </div>
      <div className="flex flex-col items-start justify-between gap-2 text-ui-white w-full">
        <WalletInput
          label="Send to :"
          value={sendToAddress}
          isFounder={Number(sendigToZoHolding?.data) > 0}
          onChange={setSendToAddress}
        />
        <button
          className={`bg-ui-highlight text-ui-white font-bold uppercase p-3 w-full flex items-center justify-center disabled:opacity-50 disabled:cursor-not-allowed`}
          onClick={handleMintClick}
          disabled={
            !isPermitedToMint ||
            balanceData?.value! < Number(mintValue.data) ||
            isTxnProcessing
          }
        >
          {isPermitedToMint
            ? isTxnProcessing
              ? "minting..."
              : `MINT for ${(Number(mintValue.data) / 10 ** 18).toFixed(
                  0
                )} $MATIC`
            : "Public mint is not yet started"}
        </button>
        {balanceData?.value! < Number(mintValue.data) ? (
          <span className="text-ui-white/40 text-sm flex items-center justify-start gap-1">
            You don&lsquo;t have enough matic
            <a
              className="text-ui-highlight text-sm"
              href="https://quickswap.exchange/#/swap?swapIndex=0&currency0=ETH"
              target="_blank"
              rel="noopener noreferrer"
            >
              swap
            </a>
            <FaExternalLinkAlt className="text-xs text-ui-highlight/70" />
          </span>
        ) : null}
      </div>
    </Container>
  );
};

export default MintNft;
