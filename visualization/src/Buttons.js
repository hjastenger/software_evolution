import React, { Component } from 'react';
import fixtures from './json/fixtures.json';
import hsqldb from './json/hsqldb.json';
import smallsql from './json/smallsql.json'

class Buttons extends Component {
  changeData(data) {
    this.props.changeData(data);
  }

  render() {
    return (
      <div className="top-buttons">
        <button onClick={() => { this.changeData(fixtures) }}> Fixtures </button>
        <button onClick={() => { this.changeData(hsqldb) }}> HSQLdb </button>
        <button onClick={() => { this.changeData(smallsql) }}> SmallSQL </button>
      </div>
    );
  }
}

export default Buttons;
