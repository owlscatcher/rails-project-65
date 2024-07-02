# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def localized_bulletin_state(state)
    I18n.t("activerecord.attributes.bulletin.states.#{state}")
  end
end
