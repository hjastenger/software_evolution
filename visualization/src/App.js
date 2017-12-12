import React, { Component } from 'react';
import LeftPane from './LeftPane';
import RightPane from './RightPane';
import data from './json/test.json';

class App extends Component {
  constructor() {
    super();

    this.state = {
      leftSelected: {
        method: {},
        loc: null
      },
      rightSelected: {
        method: {},
        loc: null
      },
      files: data.files
    };
  }

  changeLeftSelected(props) {
    this.setState({
      leftSelected: {
        method: props.method,
        loc: props.loc
      }
    });
  }

  changeRightSelected(props) {
    this.setState({
      rightSelected: {
        method: props.method,
        loc: props.loc
      }
    });
  }

  render() {
    return (
      <div className="container">
        <LeftPane state={this.state} changeHook={this.changeLeftSelected.bind(this)} />
        <div className="divider" />
        <RightPane dupLocs={this.state.leftSelected.method.dupLocs} changeHook={this.changeRightSelected.bind(this)}/>
      </div>
    );
  }
}

export default App;
