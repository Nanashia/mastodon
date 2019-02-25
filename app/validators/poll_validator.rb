# frozen_string_literal: true

class PollValidator < ActiveModel::Validator
  MAX_OPTIONS = 4
  MAX_OPTION_CHARS = 25
  MAX_EXPIRATION = 7.days.freeze
  MIN_EXPIRATION = 1.day.freeze

  def validate(poll)
    current_time = Time.now.utc

    poll.errors.add(:options, I18n.t('polls.errors.too_many_options')) if poll.options.size > MAX_OPTIONS
    poll.errors.add(:options, I18n.t('polls.errors.over_character_limit', max: MAX_OPTION_CHARS)) if poll.options.any? { |option| option.mb_chars.grapheme_length > MAX_OPTION_CHARS }
    poll.errors.add(:expires_at, I18n.t('polls.errors.duration_too_long')) if poll.expires_at - current_time >= MAX_EXPIRATION
    poll.errors.add(:expires_at, I18n.t('polls.errors.duration_too_short')) if poll.expires_at - current_time <= MIN_EXPIRATION
  end
end
