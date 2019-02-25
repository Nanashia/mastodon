import React from 'react';
import ImmutablePropTypes from 'react-immutable-proptypes';
import { FormattedMessage } from 'react-intl';
import classNames from 'classnames';

export default class Poll extends React.PureComponent {

  static propTypes = {
    poll: ImmutablePropTypes.map.isRequired,
  };

  renderOption (option) {
    const percent = option.get('votes_count') / this.props.poll.get('votes_count');
    const leading = this.props.poll.get('options').every(other => other.get('title') !== option.get('title') && option.get('votes_count') > other.get('votes'));

    return (
      <li key={option.get('title')}>
        <span className={classNames('poll__chart', { leading })} style={{ width: `${percent}%` }} />
        <span className='poll__text'>{option.get('title')}</span>
      </li>
    );
  }

  render () {
    const { poll } = this.props;

    return (
      <div className='poll'>
        <ul>
          {poll.get('options').map(option => this.renderOption(option))}
        </ul>

        <div className='poll__footer'>
          <FormattedMessage id='poll.total_votes' defaultMessage='{count, plural, =0 {No votes} one {# vote} other {# votes}}' values={{ count: poll.get('votes_count') }} />
        </div>
      </div>
    );
  }

}
