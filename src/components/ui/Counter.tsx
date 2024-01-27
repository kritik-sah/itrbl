import React, { useEffect, useState } from "react";
import { HiMiniMinus, HiMiniPlus } from "react-icons/hi2";

interface CounterProps {
  label: string;
  onChange: (count: number) => void;
}

const Counter: React.FC<CounterProps> = ({ label, onChange }) => {
  const [count, setCount] = useState(1);

  useEffect(() => {
    onChange(count);
  }, [count, onChange]);

  return (
    <div className="w-full max-w-screen-sm flex items-center justify-between gap-4 h-12 px-4 border border-dashed  border-ui-white/10 bg-ui-transparent">
      <span className="text-sm text-ui-white">{label}</span>
      <div className="flex items-center justify-end gap-2">
        <button
          onClick={() => setCount((prev) => prev - 1)}
          disabled={count <= 1}
        >
          <HiMiniMinus
            className={count > 1 ? "text-ui-primary" : "text-ui-white/30"}
          />
        </button>
        <span className="text-ui-white text-sm">{count}</span>
        <button onClick={() => setCount((prev) => prev + 1)}>
          <HiMiniPlus className={"text-ui-primary"} />
        </button>
      </div>
    </div>
  );
};

export default Counter;
