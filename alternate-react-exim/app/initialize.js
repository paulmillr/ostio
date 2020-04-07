import { render } from 'react-dom';
import React from 'react';
import Routes from 'routes';

require('es6-promise').polyfill();
require('whatwg-fetch');

document.addEventListener('DOMContentLoaded', () => {
  render(Routes, document.getElementById('app'));
});
