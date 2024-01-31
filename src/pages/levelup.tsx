import type { NextPage } from "next";
import Head from "next/head";
import LevelUp from "../components/LevelUp";
import DappLayout from "../components/layouts/DappLayout";

const Levelup: NextPage = () => {
  return (
    <div>
      <Head>
        <title>Contributors of IT Rebel | Level Up</title>
      </Head>

      <DappLayout>
        <LevelUp />
      </DappLayout>
    </div>
  );
};

export default Levelup;
