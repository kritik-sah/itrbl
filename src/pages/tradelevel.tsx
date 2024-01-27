import type { NextPage } from "next";
import Head from "next/head";
import TradeLevel from "../components/TradeLevel";
import DappLayout from "../components/layouts/DappLayout";

const Tradelevel: NextPage = () => {
  return (
    <div>
      <Head>
        <title>Contributors of IT Rebel | Trade level</title>
        <meta
          content="Want to transfer your eth tokens to Blast L2 chain, We can help you."
          name="description"
        />
        <link href="/favicon.ico" rel="icon" />
      </Head>

      <DappLayout>
        <TradeLevel />
      </DappLayout>
    </div>
  );
};

export default Tradelevel;
