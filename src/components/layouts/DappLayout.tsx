import { ReactNode } from "react";
import Footer from "../Footer";
import Header from "../Header";

interface DappLayoutProps {
  children: ReactNode;
}

const DappLayout: React.FC<DappLayoutProps> = ({ children }) => {
  return (
    <>
      <Header />
      <main>{children}</main>
      <Footer />
    </>
  );
};

export default DappLayout;
