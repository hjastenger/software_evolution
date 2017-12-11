import React, { Component } from 'react';
import File from './File';
import Code from './Code';

class LeftPane extends Component {
  constructor(props) {
    super(props);

    this.state = {
      files: this.props.state.files,
      changeHook: this.props.changeHook
    }
  }

  render() {
    return (
      <div className="left-pane">
        <Code selected={this.state.selected} />
        { this.state.files.map((file) => <File key={ file.loc } file={ file } changeHook={this.state.changeHook} />) }
      </div>
    );
  }
}

export default LeftPane;
