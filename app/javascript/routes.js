import React from "react";
import { BrowserRouter as Router, Route, Switch, Redirect } from "react-router-dom";
import Home from "./components/Home";

export default (
  <Router>
    <Switch>
      <Route path="/" exact component={Home}/>
      <Redirect from="/reload" to="/" />
    </Switch>
    
  </Router>
);