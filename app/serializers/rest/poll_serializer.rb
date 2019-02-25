# frozen_string_literal: true

class REST::PollSerializer < ActiveModel::Serializer
  attributes :id, :expires_at, :multiple, :votes_count

  has_many :dynamic_options, key: :options

  attribute :voted, if: :current_user?

  def id
    object.id.to_s
  end

  def dynamic_options
    if object.expired? || (instance_options[:include_results] && object.results_due?)
      object.loaded_options
    else
      object.unloaded_options
    end
  end

  def voted
    object.votes.where(account: current_user.account).exists?
  end

  def current_user?
    !current_user.nil?
  end

  class OptionSerializer < ActiveModel::Serializer
    attributes :title, :votes_count
  end
end
