require "test_helper"

class WaitListTest < Test::Unit::TestCase
  def setup
    Clipboard.clear
    @manager = ClipboardManager.new
    @wait_list = @manager.wait_list
    @sentences = @wait_list.sentences
  end

  test "新規の段階ではリストが空であること" do
    assert_equal [], @sentences
  end

  data(word1: ["サンプル１", "サンプル２"],
       word2: ["テスト３", "テスト２", "テスト１"])
  test "値を渡した順番通りに格納されること" do |data|
    data.each do |word|
      @wait_list.push(word)
    end
    data.zip(@sentences) do |word, sentence|
      assert_equal word, sentence.content
    end
  end

  data(word1: ["サンプル１", "サンプル２"],
       word2: ["テスト３", "テスト２", "テスト１"])
  test "一番先頭の文章がクリップボードにコピーされること" do |data|
    data.each do |word|
      @wait_list.push(word)
    end
    @wait_list.write_to_clipboard
    assert_equal data[0], Clipboard.paste
  end

  test "TODO: 一番先頭がコメントの場合にクリップボードにコピーしようとした時の挙動" do
    omit do
    end
  end

  test "TODO: リストが空の場合にクリップボードにコピーしようとした時の挙動" do
    #TODO: 空の場合は何の動作もしないでも良いかも
    omit do
      p Clipboard.paste
      @wait_list.write_to_clipboard
      p Clipboard.paste
    end
  end
end
