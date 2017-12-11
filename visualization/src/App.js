import React, { Component } from 'react';
import LeftPane from './LeftPane';
import RightPane from './RightPane';

class App extends Component {
  constructor() {
    super();

    this.state = {
      selected: {
        method: {},
        loc: null
      },
      files: [
        {
          // TODO: Remove "content" as this should be read from file
          loc: 'public/specs/fixtures/complexity/ComplexityUnits.java',
          content: 'def henk; binding.pry; end',
          methods: [
            {
              name: 'one()',
              fromLine: 0,
              toLine: 10
              // dupLocs: ["path/to/file_two.jpg", "path/to/file_three.jpg"]
            },
            {
              name: 'two()',
              fromLine: 0,
              toLine: 10
              // dupLocs: ["path/to/file_two.jpg", "path/to/file_three.jpg"]
            },
          ]
        }
      ]
    };
  }

  changeSelected(state) {
    this.setState({
      selected: {
        method: state.method,
        loc: state.loc
      }
    });
  }

  render() {
    return (
      <div className="container">
        <LeftPane state={this.state} changeHook={this.changeSelected.bind(this)} />
        <div className="divider" />
        <RightPane />
      </div>
    );
  }
}

export default App;
