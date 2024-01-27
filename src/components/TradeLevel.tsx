import { ConnectButton } from "@rainbow-me/rainbowkit";
import Image from "next/image";
import React, { useEffect, useState } from "react";
import { FaExternalLinkAlt } from "react-icons/fa";
import { toast } from "react-toastify";
import { parseEther, parseGwei } from "viem";
import {
  Address,
  useAccount,
  useBalance,
  useContractRead,
  useContractWrite,
  usePrepareContractWrite,
  useWaitForTransaction,
} from "wagmi";
import itrblAbi from "../libs/abi.json";
import Container from "./ui/Container";
import Counter from "./ui/Counter";
import NumberInput from "./ui/NumberInput";
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from "./ui/Select";

const TradeLevel = () => {
  const [userHolding, setUserHolding] = useState<any>();
  const [selectedNFT, setSelectedNFT] = useState<number | null>(null);
  const [toNFT, setToNFT] = useState<number | null>(null);
  const [levelAmount, setLevelAmount] = useState(1);
  const { address, isConnecting, isDisconnected } = useAccount();
  const { data: balanceData, refetch: refetchBalance } = useBalance({
    address,
  });

  const contractAddress: Address = `0x${process.env.NEXT_PUBLIC_CONTRACT_ADDRESS}`;

  const totalSupply = useContractRead({
    address: contractAddress,
    abi: itrblAbi,
    functionName: "totalSupply",
  });

  const level = useContractRead({
    address: contractAddress,
    abi: itrblAbi,
    functionName: "getLevels",
    args: [Number(selectedNFT)],
  });

  const { write: tradeLevels } = useContractWrite({
    address: contractAddress,
    abi: itrblAbi,
    functionName: "tradeLevels",
    gas: BigInt(3558325),
    args: [selectedNFT, toNFT, levelAmount],
    onError(error) {
      toast.error(error.message);
    },
    onSuccess() {
      toast.success("trade initiated");
      level.refetch();
      totalSupply.refetch();
      refetchBalance();
    },
  });

  useEffect(() => {
    const options = {
      method: "GET",
      headers: {
        accept: "application/json",
        "x-api-key": process.env.NEXT_PUBLIC_OPENSEA_API_KEY!,
      },
    };

    fetch(
      "https://testnets-api.opensea.io/api/v2/chain/mumbai/account/0x0DB63C9613b3BECf644A298AfECBa450795f612B/nfts?collection=contributors-of-it-rebel-5&limit=200",
      options
    )
      .then((response) => response.json())
      .then((response) => {
        setUserHolding(response.nfts);
        console.log(response.nfts);
      })
      .catch((err) => console.error(err));
  }, []);

  const handleLevelUpClick = () => {
    // Add your logic for handling the "Send" button click
    if (address && toNFT && levelAmount) {
      tradeLevels();
    }
  };

  const getNftImage = (identifier: string) => {
    // Find the NFT with the specified identifier
    const nft = userHolding?.find((nft: any) => nft.identifier === identifier);

    // Check if the NFT with the given identifier exists
    if (nft) {
      return nft.image_url;
    } else {
      // Return a default image URL or handle the case where the NFT is not found
      return "default_image_url"; // Replace with your default image URL
    }
  };

  return (
    <Container>
      <div className="flex flex-col md:flex-row gap-6">
        <div className="flex items-center justify-center">
          <Image
            src={
              selectedNFT !== null
                ? getNftImage(selectedNFT.toString())
                : "/images/mystery-box.png"
            }
            alt="Unlock you ITRBL NFT now!!!"
            height="300"
            width="251"
          />
        </div>
        <div className="flex flex-col flex-shrink-0">
          <div className="w-full space-y-4 flex-grow">
            <Select onValueChange={(e) => setSelectedNFT(Number(e))}>
              <SelectTrigger className="w-full max-w-screen-sm">
                <SelectValue placeholder="Please select your nft..." />
              </SelectTrigger>
              <SelectContent className="bg-ui-dark/90">
                {userHolding?.map((nft: any) => (
                  <SelectItem
                    key={nft.identifier}
                    value={nft.identifier}
                    className="w-full"
                  >
                    <div className="flex items-center justify-start space-x-2">
                      <div className="flex-shrink-0">
                        <Image
                          src={nft?.image_url}
                          alt={nft?.name}
                          height="30"
                          width="30"
                        />
                      </div>
                      <div className="flex flex-col gap-0 items-start justify-center">
                        <div className="text-sm font-medium text-ui-white truncate">
                          {nft.name}
                        </div>
                        <div className="text-xs text-ui-primary truncate">
                          {nft?.traits
                            ? `level : ${
                                nft?.traits?.find(
                                  (trait: any) => trait?.trait_type === "level"
                                )?.value
                              }`
                            : nft.description}
                        </div>
                      </div>
                    </div>
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
            <NumberInput label="NFT ID :" onChange={setToNFT} />
            <Counter label="Send" onChange={setLevelAmount} />
          </div>
          <div className="w-full space-y-4">
            <div className="flex flex-col items-start justify-between gap-2 text-ui-white">
              <p>
                Current Balance:{" "}
                <span className="text-ui-highlight">
                  {Number(balanceData?.formatted)?.toFixed(4)}
                  {` $${balanceData?.symbol}`}
                </span>
              </p>
            </div>
            <button
              className={`bg-ui-highlight text-ui-white font-bold uppercase p-3 w-full flex items-center justify-center disabled:opacity-50 disabled:cursor-not-allowed`}
              onClick={handleLevelUpClick}
              disabled={
                Number(toNFT) >= Number(totalSupply.data) ||
                Number(level?.data) < levelAmount ||
                selectedNFT === null
              }
            >
              {false
                ? "yes ser, great going..."
                : `Send ${levelAmount} level to "REBEL #${toNFT}"`}
            </button>
          </div>
        </div>
      </div>
    </Container>
  );
};

export default TradeLevel;
