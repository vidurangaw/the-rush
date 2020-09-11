import React, { Component, Fragment } from "react"
import { Link } from "react-router-dom";
import Rushings from "./Rushings";

export default () => (
  <div className="container">
    <header className="navbar navbar-default navbar-fixed-top">
      <div className="container bg-light">
        <div className="navbar-header">
          <Link to="/"className="navbar-brand p-3">the Rush</Link>
        </div>
      </div>
    </header>

    <div className="container">
      <h1 className='mt-5 text-center'>NFL Player Rushing Stats</h1>
      <Rushings/>
    </div>
  </div>
);