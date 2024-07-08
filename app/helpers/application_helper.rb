# frozen_string_literal: true

module ApplicationHelper
  def localized_bulletin_state(state)
    I18n.t("activerecord.attributes.bulletin.states.#{state}")
  end
end
