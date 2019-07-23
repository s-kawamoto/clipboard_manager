class ClipboardManager
  class WaitList
    attr_accessor :sentences

    def initialize
      @sentences = []
      @history = []
    end

    def push(content, type = nil)
      @sentences << self.class::Sentence.new(content, type)
    end

    def shift
      write_to_clipboard
      @history.push(@sentences.shift)
    end

    def restore
      @sentences.unshift(@history.pop)
      write_to_clipboard
    end

    def write_to_clipboard
      #FIXME:wait_listが空の場合、sentenceがコメントの場合の挙動を考える。
      Clipboard.copy(@sentences.first.content)
    end

    class Sentence
      attr_accessor :content, :type
      def initialize(content, type = nil)
        @content = content
        @type = type
      end
    end
  end
end
