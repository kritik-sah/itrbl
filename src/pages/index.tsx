import type { NextPage } from "next";
import Head from "next/head";
import CollectionInfo from "../components/CollectionInfo";
import Hero from "../components/Hero";
import SiteHeader from "../components/SiteHeader";

const Home: NextPage = () => {
  return (
    <div>
      <Head>
        <title>Contributors of IT Rebel | ITRBL</title>
      </Head>

      <main>
        <SiteHeader />
        <Hero />
        {/* <CollectionInfo /> */}
      </main>
    </div>
  );
};

export default Home;
