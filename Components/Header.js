import React from "react";
import { FormattedMessage } from "react-intl";

const Header = ({ balance }) => {
  return (
    <div className="header">
      <h2>
        <FormattedMessage id="header.welcome" />
      </h2>
      <p>
        <FormattedMessage id="header.balance" values={{ balance }} />
      </p>
    </div>
  );
};

export default Header;
