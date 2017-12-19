import React, { Component } from 'react';
import fixtures from './json/fixtures.json';
import smallsql from './json/smallsql.json'
// import hsqldb from './json/hsqldb.json';

class Buttons extends Component {
  constructor(props) {
    super(props);

    this.state = {
      order: 'asc',
      inLeftPane: this.props.inLeftPane,
      searchInput: '',
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

  searchData() {
    this.props.searchData(this.state.searchInput);
  }

  updateInputValue(evt) {
    this.setState({
      searchInput: evt.target.value
    });
  }

  leftPaneButtons() {
    if(this.state.inLeftPane) {
      return (
        <React.Fragment>
          <button onClick={() => { this.changeData(fixtures) }}> Fixtures </button>
          <button onClick={() => { this.changeData(smallsql) }}> SmallSQL </button>
          <input value={this.state.searchInput} placeholder="zoeken" onChange={(evt) => { this.updateInputValue(evt) }} />
          <button onClick={() => { this.searchData() }}> Search </button>
        </React.Fragment>
      );
    }
  }

  render() {
    return (
      <div className="top-buttons">
        { this.leftPaneButtons() }
        <button onClick={() => { this.sortIt() }}> Sort { this.state.order } </button>
      </div>
    );
  }
}

export default Buttons;
// <button onClick={() => { this.changeData(hsqldb) }}> HSQLdb </button>
