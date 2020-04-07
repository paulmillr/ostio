import React from 'react';

const defaultUrl = "https://a248.e.akamai.net/assets.github.com/images/gravatars/gravatar-140.png";

export default ({ url, className}) => {
  return <img className={"avatar " + (className || '')} src={url || defaultUrl} />;
};
