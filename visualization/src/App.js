import React, { Component } from 'react';
import LeftPane from './LeftPane';
import RightPane from './RightPane';

class App extends Component {
  render() {
    return (
      <div className="container">
        <LeftPane />
        <div className="divider" />
        <RightPane />
      </div>
    );
  }
}

export default App;
