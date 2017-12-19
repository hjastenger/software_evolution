import React, { Component } from 'react';
import Pattern from './Pattern';
import Buttons from './Buttons';
import uuidv4 from 'uuid/v4';

class LeftPane extends Component {
  constructor(props) {
    super(props);

    this.renderFiles = this.renderFiles.bind(this);
    this.hideSelected = this.hideSelected.bind(this);

    this.state = {
      files: [],
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

  changeData(data) {
    this.setState({
      files: data.files
    });
  }

  sortData(direction) {
    let sorted = this.state.files.sort(function (a, b) {
      if(direction === 'asc') {
        return a.matches - b.matches;
      } else {
        return b.matches - a.matches;
      }
    });

    this.setState({
      files: sorted
    });
  }

  renderFiles(files) {
    return files.map((pattern) => {
      return <Pattern key={ uuidv4() }
        pattern={ pattern }
        changeHook={this.changeLeftSelected.bind(this)}
        changeDupLocs={this.props.changeDupLocs} />;
    })
  }

  render() {
    return (
      <div className="left-pane">
        <Buttons changeData={this.changeData.bind(this)} sortData={this.sortData.bind(this)} />
        { this.renderFiles(this.state.files) }
      </div>
    );
  }
}

export default LeftPane;
