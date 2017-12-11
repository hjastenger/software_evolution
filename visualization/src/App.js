import React, { Component } from 'react';
import LeftPane from './LeftPane';
import RightPane from './RightPane';

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
      files: [
        {
          loc: 'specs/fixtures/complexity/ComplexityUnits.java',
          methods: [
            {
              name: 'onlyIf()',
              fromLine: 20,
              toLine: 23,
              dupLocs: [
                {
                  name: 'onlyIf()',
                  loc: 'specs/fixtures/duplication/Duplication.java',
                  fromLine: 20,
                  toLine: 23
                },
                {
                  name: 'singleCatch()',
                  loc: 'specs/fixtures/duplication/Duplication.java',
                  fromLine: 75,
                  toLine: 81
                }
              ]
            },
            {
              name: 'singleCatch()',
              fromLine: 75,
              toLine: 81
              // dupLocs: ["path/to/file_two.jpg", "path/to/file_three.jpg"]
            },
          ]
        }
      ]
    };
  }

  changeLeftSelected(state) {
    this.setState({
      leftSelected: {
        method: state.method,
        loc: state.loc
      }
    });
  }

  changeRightSelected(state) {
    this.setState({
      rightSelected: {
        method: state.method,
        loc: state.loc
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
