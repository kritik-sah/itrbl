import { Head, Html, Main, NextScript } from "next/document";

export default function Document() {
  return (
    <Html lang="en">
      <Head>
        <meta property="og:title" content="Contributors of IT Rebel" />
        <meta
          property="og:description"
          content="Dive into the decentralized universe with our unique on-chain evolving NFTs. Mint your ITRBL token, discover your class, unlock attacks, and trade levels with contributors."
        />
        <meta property="og:image" content="/images/preview.png" />
        <meta name="twitter:title" content="Title" />
        <meta
          name="twitter:description"
          content="Dive into the decentralized universe with our unique on-chain evolving NFTs. Mint your ITRBL token, discover your class, unlock attacks, and trade levels with contributors."
        />
        <meta name="twitter:image" content="/images/preview.png" />
        <meta name="twitter:card" content="summary_large_image" />
        <link rel="icon" href="/images/itrebels-circle.png" />
      </Head>
      <body>
        <Main />
        <NextScript />
      </body>
    </Html>
  );
}
