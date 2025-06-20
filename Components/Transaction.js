import React from "react";
import { FormattedMessage } from "react-intl";
import "./Transaction.css";

const Transaction = ({ sender, receiver, amount }) => {
  return (
    <div className="transaction">
      <p>
        <FormattedMessage id="transaction.sender" />: {sender}
      </p>
      <p>
        <FormattedMessage id="transaction.receiver" />: {receiver}
      </p>
      <p>
        <FormattedMessage id="transaction.amount" values={{ amount }} />
      </p>
    </div>
  );
};

export default Transaction;
