import React, { Component } from 'react';
import File from './File';
import Code from './Code';

class LeftPane extends Component {
  constructor(props) {
    super(props);

    this.state = {
      files: this.props.files,
      selected: {
        method: {},
        loc: null
      },
      changeDupLocs: this.props.changeDupLocs
    }
  }

  changeLeftSelected(props) {
    this.setState({
      selected: {
        method: props.method,
        loc: props.loc
      }
    });
  }

  render() {
    return (
      <div className="left-pane">
        <Code selected={this.state.selected} color="#99ffaf" />
        { this.state.files.map((file) => <File key={ file.loc } file={ file } changeHook={this.changeLeftSelected.bind(this)} changeDupLocs={this.state.changeDupLocs} />) }
      </div>
    );
  }
}

export default LeftPane;
