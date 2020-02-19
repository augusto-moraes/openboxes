import React, { Component } from "react";
import { defaults } from "react-chartjs-2";
import { connect } from "react-redux";
import { SortableContainer } from "react-sortable-hoc";
import "react-table/react-table.css";
import {
  addToIndicators,
  fetchIndicators,
  reorderIndicators
} from "../../actions";
import GraphCard from "./GraphCard";
import NumberCard from "./NumberCard";
import "./tablero.scss";
import { numberData } from "../../../assets/dataFormat/numberData";

// Disable charts legends by default.
defaults.global.legend = false;

const SortableCards = SortableContainer(({ data }) => (
  <div className="cardComponent">
    {data.map((value, index) => (
      <GraphCard
        key={`item-${value.id}`}
        index={index}
        cardTitle={value.title}
        cardType={value.type}
        data={value.data}
      />
    ))}
  </div>
));

const NumberCardsRow = ({ data }) => (
  <div className="cardComponent">
    {data.map((value, index) => (
      <NumberCard
        key={`item-${value.id}`}
        index={index}
        cardTitle={value.title}
        cardNumber={value.number}
        cardSubtitle={value.subtitle}
      />
    ))}
  </div>
);

const ArchiveIndicator = ({ hideArchive }) => (
  <div className={hideArchive ? "archiveDiv hideArchive" : "archiveDiv"}>
    <span>
      Archive indicator <i className="fa fa-archive"></i>
    </span>
  </div>
);

class Tablero extends Component {
  dataFetched = false;
  state = {
    isDragging: false
  };

  constructor(props) {
    super(props);
  }

  componentDidMount() {
    this.fetchData();
  }

  fetchData() {
    this.props.fetchIndicators();
  }

  sortStartHandle = () => {
    this.setState({ isDragging: true });
  };
  sortEndHandle = ({ oldIndex, newIndex }, e) => {
    if (e.clientY > 850) {
      e.target.id = "archive";
    }
    this.props.reorderIndicators({ oldIndex, newIndex }, e);
    this.setState({ isDragging: false });
  };

  render() {
    return (
      <div className="cardsContainer">
        <NumberCardsRow data={numberData} />
        <SortableCards
          data={this.props.indicatorsData}
          onSortStart={this.sortStartHandle}
          onSortEnd={this.sortEndHandle}
          axis="xy"
          useDragHandle
        />
        <ArchiveIndicator hideArchive={!this.state.isDragging} />
        <div className="unarchive">
          <span>Unarchive indicator (2) </span>
          <i className="fa fa-archive"></i>
        </div>
      </div>
    );
  }
}

const mapStateToProps = state => ({
  indicatorsData: state.indicators.data
});

export default connect(mapStateToProps, {
  fetchIndicators,
  addToIndicators,
  reorderIndicators
})(Tablero);