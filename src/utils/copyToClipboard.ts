export const copyToClipboard = (textToCopy: string, callBack: () => void) => {
  navigator.clipboard.writeText(textToCopy);

  if (callBack) {
    callBack();
  }
};
