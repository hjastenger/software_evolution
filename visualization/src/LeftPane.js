import React, { Component } from 'react';
import File from './File';
import Code from './Code';

class LeftPane extends Component {
  constructor(props) {
    super(props);

    this.renderCode = this.renderCode.bind(this);
    this.renderFiles = this.renderFiles.bind(this);
    this.hideSelected = this.hideSelected.bind(this);

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

  hideSelected() {
    this.setState({
      selected: {
        method: {},
        loc: null
      }
    });
  }

  renderCode() {
    if(this.state.selected) {
      return (
        <Code selected={ this.state.selected }
          hideCallback={ this.hideSelected }
          color="#99ffaf" />
      );
    } else {
      return <div />;
    }
  }

  renderFiles(files) {
    return files.map((file) => {
      return <File key={ file.loc }
      file={ file }
      changeHook={this.changeLeftSelected.bind(this)}
      changeDupLocs={this.props.changeDupLocs} />;
    })
  }

  render() {
    return (
      <div className="left-pane">
        { this.renderCode() }
        { this.renderFiles(this.state.files) }
      </div>
    );
  }
}

export default LeftPane;
