class ClipboardManager
  def extract_file(file_path)
    quote_sentences = []
    quote_flag = false
    File.foreach(file_path) do |clip|
      clip.chomp!
      case clip
      when /^\s*#/
        # コメント
        @wait_list.push(clip, 'comment')
        next
      when /^\s*$/
        # 空行は無視する
        next
      when /^"/
        quote_flag = true
        quote_sentences << clip.sub(/"/,'')
        next
      when /"$/
        if quote_flag
          quote_flag = false
          quote_sentences << clip.sub(/"/, '')
          clip = quote_sentences.join
          @wait_list.push(clip)
          quote_sentences = []
        end
      end

      # ダブルクォートが3行以上続いた場合
      if quote_flag
        quote_sentences << clip
        next
      end

      @wait_list.push(clip)
    end
  end
end
