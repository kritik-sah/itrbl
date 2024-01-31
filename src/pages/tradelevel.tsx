import type { NextPage } from "next";
import Head from "next/head";
import TradeLevel from "../components/TradeLevel";
import DappLayout from "../components/layouts/DappLayout";

const Tradelevel: NextPage = () => {
  return (
    <div>
      <Head>
        <title>Contributors of IT Rebel | Trade level</title>
      </Head>

      <DappLayout>
        <TradeLevel />
      </DappLayout>
    </div>
  );
};

export default Tradelevel;
