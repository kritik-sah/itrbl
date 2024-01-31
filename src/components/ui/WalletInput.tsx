import React, { useEffect, useState } from "react";
import Zo from "../icon/Zo";

interface WalletInputProps {
  label: string;
  value: string;
  isFounder: boolean;
  onChange: (count: string) => void;
}

const WalletInput: React.FC<WalletInputProps> = ({
  label,
  value,
  isFounder,
  onChange,
}) => {
  return (
    <div className="w-full flex items-center justify-start gap-4 h-12 px-4 border border-dashed border-ui-white/10 bg-ui-transparent">
      <span className="text-sm text-ui-white shrink-0">{label}</span>
      <div className="flex items-center justify-start gap-2 flex-shrink-0 flex-grow">
        <input
          type="text"
          value={value}
          onChange={(e) => onChange(e.target.value)}
          className="text-ui-white w-20 lg:w-full text-sm bg-ui-transparent border-none focus:outline-none"
        />
        {isFounder ? <Zo /> : null}
      </div>
    </div>
  );
};

export default WalletInput;
