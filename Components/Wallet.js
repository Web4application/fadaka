import React from "react";
import { FormattedMessage } from "react-intl";
import "./Wallet.css";

const Wallet = ({ address, balance }) => {
  return (
    <div className="wallet">
      <h2>
        <FormattedMessage id="wallet.title" />
      </h2>
      <p>
        <FormattedMessage id="wallet.address" />: {address}
      </p>
      <p>
        <FormattedMessage id="wallet.balance" values={{ balance }} />
      </p>
    </div>
  );
};

export default Wallet;
