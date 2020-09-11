import React, { Component } from "react"
import axios from 'axios';
import queryString from 'query-string';

class Rushings extends Component {

  constructor(props) {
    super(props);

    let params = queryString.parse(this.props.location.search)

    this.state = {
      loading: true,
      rushings: [],
      searchTerm: params.search_term || '',
      sortBy: params.sort_by || '',
      sortDirection: params.sort_direction || '',
      typingTimeout: 0
    }
  }

  loadData = (intialLoad) => {
    var params = {}         
    if (this.state.loading == true){
      axios.get('/api/rushings', {
        params: {
          search_term: this.state.searchTerm,
          sort_by: this.state.sortBy,
          sort_direction: this.state.sortDirection
        }
      })
      .then(res => {
        if (!intialLoad) {
          const url = res.request.responseURL.replace(/^.*\/\/[^\/]+\/api\/rushings/, '')
          this.props.history.push(url);
        }
        this.setState({ rushings: res.data.data, loading: false });
      })
      .catch(err => {
        this.setState({ loading: false });
      });
    }
  };

  componentDidMount() {
    this.loadData(true);
  };

  handleSeachChange = (value) => {
    this.setState({ searchTerm: value });

    if (this.typingTimeout) clearTimeout(this.typingTimeout);
    this.typingTimeout = setTimeout(() => {
      this.setState({loading: true}, () => this.loadData());
    }, 500);
  };

  handleSortChange = (sortBy) => {
    var direction = '';
    if (this.state.sortDirection == '' || this.state.sortBy != sortBy){
      direction = 'desc'
    }
    else {
      direction = this.state.sortDirection == 'desc' ? 'asc' : ''
    }
    this.setState({ sortBy: sortBy, sortDirection: direction, loading: true}, () => this.loadData());  
  };

  render () {
    const csrf_token = document.querySelector('[name=csrf-token]').content
    var sortIconClass = 'fa-sort'
    if (this.state.sortDirection == 'asc'){
      sortIconClass = 'fa-sort-up'
    }
    else if (this.state.sortDirection == 'desc'){
      sortIconClass = 'fa-sort-down'
    }

    return (
      <div className="rushings">
        <div className="d-flex justify-content-between">
          <form className="form-inline" onSubmit={(e) => this.handleSeachChange(event.target.search_term.value)}>
            <div className="form-group">
              <input type="text" 
                     className="form-control" 
                     placeholder="Search by player"
                     name="search_term"
                     value={this.state.searchTerm}
                     onChange={(e) => this.handleSeachChange(e.target.value)}/>
            </div>
          </form> 
          <form action="/api/rushings/download" method="post">
            <input type="hidden" name="authenticity_token" value={csrf_token}/>
            <input type="hidden" name="search_term" value={this.state.searchTerm}/>
            <input type="hidden" name="sort_by" value={this.state.sortBy}/>

            <input type="hidden" name="sort_direction" value={this.state.sortDirection}/>

            <button type="submit" className="btn rushings__download">Download</button>
          </form> 
        </div>
        <div className="table-responsive mt-3">
          <table className="rushings__table table">
            <thead>
              <tr>
                <th scope="col" data-toggle="tooltip" title="Player's name">Player</th>
                <th scope="col" data-toggle="tooltip" title="Player's team abbreviation">Team</th>
                <th scope="col" data-toggle="tooltip" title="Player's position">Pos</th>
                <th scope="col" data-toggle="tooltip" title="Rushing Attempts">Att</th>
                <th scope="col" data-toggle="tooltip" title="Rushing Attempts Per Game Average">Att/G</th>
                <th scope="col" 
                    data-toggle="tooltip" 
                    title="Total Rushing Yards" 
                    onClick={() => this.handleSortChange('yds')}>
                      Yds
                      <span className="float-right">
                        <i className={`fas ${this.state.sortBy == 'yds' ? sortIconClass : 'fa-sort'}`}></i>
                      </span>
                </th>
                <th scope="col" data-toggle="tooltip" title="Rushing Average Yards Per Attempt">Avg</th>
                <th scope="col" data-toggle="tooltip" title="Rushing Yards Per Game">Yds/G</th>
                <th scope="col" 
                    data-toggle="tooltip" 
                    title="Total Rushing Touchdowns" 
                    onClick={() => this.handleSortChange('td')}>
                      TD
                      <span className="float-right">
                        <i className={`fas ${this.state.sortBy == 'td' ? sortIconClass : 'fa-sort'}`}></i>
                      </span>
                </th>
                <th scope="col" 
                    data-toggle="tooltip" 
                    title="Longest Rush -- a T represents a touchdown occurred" 
                    onClick={() => this.handleSortChange('lng_int')}>
                      Lng
                      <span className="float-right">
                        <i className={`fas ${this.state.sortBy == 'lng_int' ? sortIconClass : 'fa-sort'}`}></i>
                      </span>
                </th>
                <th scope="col" data-toggle="tooltip" title="Rushing First Downs">1st</th>
                <th scope="col" data-toggle="tooltip" title="Rushing First Down Percentage">1st%</th>
                <th scope="col" data-toggle="tooltip" title="Rushing 20+ Yards Each">20+</th>
                <th scope="col" data-toggle="tooltip" title="Rushing 40+ Yards Each">40+</th>
                <th scope="col" data-toggle="tooltip" title="Rushing Fumbles">FUM</th>
              </tr>
            </thead>

            <tbody>
              {this.state.rushings.map((rushing, i) => (
                <tr key={i}>
                  {Object.values(rushing).map((value, j) => (
                    <td key={j}>{value}</td>
                  ))}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>  
    );
  };
};

export default Rushings