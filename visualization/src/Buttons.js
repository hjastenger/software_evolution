import React, { Component } from 'react';
import fixtures from './json/fixtures.json';
import smallsql from './json/smallsql.json'
// import hsqldb from './json/hsqldb.json';

class Buttons extends Component {
  constructor() {
    super();

    this.state = {
      order: 'asc'
    }
  }

  changeData(data) {
    this.props.changeData(data);
  }

  sortIt() {
    this.props.sortData(this.state.order);
    this.setState({
      order: this.state.order === 'asc' ? 'desc' : 'asc'
    });
  }

  render() {
    return (
      <div className="top-buttons">
        <button onClick={() => { this.changeData(fixtures) }}> Fixtures </button>
        <button onClick={() => { this.changeData(smallsql) }}> SmallSQL </button>
        <button onClick={() => { this.sortIt() }}> Sort { this.state.order } </button>
      </div>
    );
  }
}

export default Buttons;
// <button onClick={() => { this.changeData(hsqldb) }}> HSQLdb </button>
