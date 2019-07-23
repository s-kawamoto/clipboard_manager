require "clipboard"

require "clipboard_manager/version"
require "clipboard_manager/request"
require "clipboard_manager/wait_list"
require "clipboard_manager/extract_file"

class ClipboardManager
  attr_accessor :wait_list

  def initialize
    @wait_list = WaitList.new
  end
end
