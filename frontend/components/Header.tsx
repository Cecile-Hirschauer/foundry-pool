import { ConnectButton } from "@rainbow-me/rainbowkit";
import { CSSProperties } from "react";

/**
 * Header is a React functional component that renders the header of the application.
 * It includes a logo and a ConnectButton from RainbowKit for wallet connections.
 *
 * @returns {JSX.Element} The JSX for the header component.
 */
const Header = () => {
  const customButtonStyles: CSSProperties = {
    backgroundColor: "#65a30d", // Corresponds to bg-lime-600
    color: "#111827", // Corresponds to text-gray-900
    padding: "8px 16px",
    borderRadius: "0.375rem", // Corresponds to rounded-md
  };

  return (
    <div className="flex justify-center items-center p-5">
      <div className="grow">
        <h1 className="text-3xl lg:text-4xl font-extrabold text-transparent bg-clip-text bg-gradient-to-br from-lime-100 to-lime-600">
          Foundry Pool
        </h1>
      </div>
      <ConnectButton />
    </div>
  );
};

export default Header;
