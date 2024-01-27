import React, { useEffect, useState } from "react";

interface NumberInputProps {
  label: string;
  onChange: (count: number) => void;
}

const NumberInput: React.FC<NumberInputProps> = ({ label, onChange }) => {
  const [count, setCount] = useState(0);

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const value = Number(e.target.value);
    value >= 0 && setCount(value);
  };

  useEffect(() => {
    onChange(count);
  }, [count, onChange]);

  return (
    <div className="w-full max-w-screen-sm flex items-center justify-between gap-4 h-12 px-4 border border-dashed border-ui-white/10 bg-ui-transparent">
      <span className="text-sm text-ui-white">{label}</span>
      <div className="flex items-center justify-end gap-2">
        <input
          type="number"
          value={count}
          onChange={handleInputChange}
          className="text-ui-white text-sm bg-ui-transparent border-none focus:outline-none"
        />
      </div>
    </div>
  );
};

export default NumberInput;
