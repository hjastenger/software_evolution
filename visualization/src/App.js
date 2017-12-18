import React, { Component } from 'react';
import LeftPane from './LeftPane';
import RightPane from './RightPane';

class App extends Component {
  constructor() {
    super();

    this.state = {
      dupLocs: [],
    };
  }

  changeDupLocs(dupLocs) {
    this.setState({ dupLocs });
  }

  render() {
    return (
      <div className="container">
        <LeftPane files={this.state.files} changeDupLocs={this.changeDupLocs.bind(this)}/>
        <div className="divider" />
        <RightPane dupLocs={this.state.dupLocs} />
      </div>
    );
  }
}

export default App;
