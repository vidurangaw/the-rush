// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import "../stylesheets/application.scss";

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")

import $ from 'jquery';
import Popper from 'popper.js';
import 'bootstrap/dist/js/bootstrap.bundle.min';

import React from "react";
import { render } from "react-dom";
import App from "../App";

// React
import axios from 'axios'
if (document.getElementsByName('csrf-token').length > 0){
  axios.defaults.headers.common['X-CSRF-Token'] = document.getElementsByName('csrf-token')[0].content;
  axios.defaults.headers.common['Accept'] = 'application/json';
}

document.addEventListener("DOMContentLoaded", () => {
  render(
    <App />,
    document.body.appendChild(document.createElement("div"))
  );
});


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

