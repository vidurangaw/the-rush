import React, { Component, Fragment } from "react"
import { Link } from "react-router-dom";
import Rushings from "./Rushings";

export default () => (
  <Fragment>
    <header className="navbar navbar-default navbar-fixed-top">
      <div className="container bg-dark">
        <div className="navbar-header">
          <Link to="/"className="navbar-brand text-white">the Rush</Link>
        </div>
      </div>
    </header>

    <div className="container">
      <h1 className='mt-3 text-center'>Player Rushings</h1>
    </div>
  </Fragment>
);