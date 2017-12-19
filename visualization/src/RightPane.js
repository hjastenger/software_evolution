import React, { Component } from 'react';
import Card from './Card';
import Code from './Code';
import Buttons from './Buttons';
import uuidv4 from 'uuid/v4';

class RightPane extends Component {
  constructor(props) {
    super(props);

    this.renderCode = this.renderCode.bind(this);
    this.renderCards = this.renderCards.bind(this);
    this.hideSelected = this.hideSelected.bind(this);

    this.state = {
      dupLocs: [],
      selected: {
        lines: [],
        loc: null
      }
    }
  }

  componentWillReceiveProps(newProps) {
    this.setState({
      dupLocs: newProps.dupLocs
    });
  }

  changeRightSelected(props) {
    this.setState({
      selected: {
        lines: props.lines,
        loc: props.loc
      }
    });
  }

  sortData(direction) {
    let sorted = this.state.dupLocs.sort((a, b) => {
      if(direction === 'asc') {
        return a.location <= b.location;
      } else {
        return a.location > b.location;
      }
    });

    this.setState({
      dupLocs: sorted
    });
  }

  isNotEmpty(obj) {
    return Object.keys(obj).length > 0 && obj.constructor === Object;
  }

  hideSelected() {
    this.setState({
      selected: {
        method: {},
        loc: null
    }});
  }

  renderCode() {
    if(this.isNotEmpty(this.state.selected)) {
      return (
        <Code selected={ this.state.selected }
          hideCallback={ this.hideSelected }
          color="#ff788b" />
      );
    } else {
      return <div />;
    }
  }

  renderCards(dupLocs) {
    return dupLocs.map((duplicate) => {
      return <Card
        key={ uuidv4() }
        lines={ duplicate.lines }
        loc={ duplicate.location }
        changeHook={ this.changeRightSelected.bind(this) }
      />
    });
  }

  render() {
    return (
      <div className="right-pane">
        <Buttons inLeftPane={false} sortData={this.sortData.bind(this)} />
        { this.renderCode() }
        <h2 className='duplication-header'>Duplication</h2>
        { this.renderCards(this.state.dupLocs) }
      </div>
    );
  }
}

export default RightPane;
