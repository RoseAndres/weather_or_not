class ApplicationController < ActionController::Base
  def t(key)
    I18n.t("controllers.#{controller_name}.#{key}")
  end
end
