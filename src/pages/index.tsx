import type { NextPage } from "next";
import Head from "next/head";
import Hero from "../components/Hero";
import SiteHeader from "../components/SiteHeader";

const Home: NextPage = () => {
  return (
    <div>
      <Head>
        <title>Contributors of IT Rebel | ITRBL</title>
        <meta
          content="Want to transfer your eth tokens to Blast L2 chain, We can help you."
          name="description"
        />
        <link href="/favicon.ico" rel="icon" />
      </Head>

      <main>
        <SiteHeader />
        <Hero />
      </main>
    </div>
  );
};

export default Home;
