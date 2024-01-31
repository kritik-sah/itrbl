import type { NextPage } from "next";
import Head from "next/head";
import MintNft from "../components/Mint";
import DappLayout from "../components/layouts/DappLayout";

const Mint: NextPage = () => {
  return (
    <div>
      <Head>
        <title>Contributors of IT Rebel | Mint Now</title>
      </Head>

      <DappLayout>
        <MintNft />
      </DappLayout>
    </div>
  );
};

export default Mint;
