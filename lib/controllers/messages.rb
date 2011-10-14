module Messages
  def error(sym, options = {})
    message(:error, sym, options)
  end

  def notice(sym, options = {})
    message(:notice, sym, options)
  end

  def message(type, sym, options = {})
    if options.key?(:now)
      flash.now[type] = message_value(sym, options)
    else
      flash[type] = message_value(sym, options)
    end
  end

  def message_value(key, options = {})
    t("messages.#{key}", options)
  end
end
