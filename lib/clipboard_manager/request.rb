class ClipboardManager
  def request_yes_or_no
    loop do
      case Clipboard.paste
      when 'y', 'yes'
        Clipboard.clear
        return 'yes'
      when 'n', 'no'
        Clipboard.clear
        return 'no'
      when 'exit'
        exit
      else
        sleep 0.2
      end
    end
  end

  def request(*req_ary)
    loop do
      if req_ary.include?(Clipboard.paste)
        response = Clipboard.paste
        Clipboard.clear
        return response
      end
      sleep 0.2
    end
  end
end
