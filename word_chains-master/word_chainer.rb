require 'byebug'
require 'set'
class WordChainer
  def initialize(dictionary_file_name)
    @dictionary = Set.new(File.readlines(dictionary_file_name).map { |word| word.chomp })
    @temp_dict = @dictionary
  end

  def run(source, target)
    @temp_dict = @dictionary.select { |cur_word| cur_word.length == source.length }
    @current_words = [source]
    @all_seen_words = {source => []}

    until @current_words.empty?
      explore_current_words(target)
      break if @all_seen_words.include?(target)
    end

    build_path(target)
  end

  private

  def build_path(target)
    path = [target]
    parent = @all_seen_words[path.last]
    # debugger
    until parent.empty?
      # debugger if parent == true
      # debugger
      puts path
      path << parent
      parent = @all_seen_words[path.last]
    end
    path.reverse
  end

  def explore_current_words(target)
    new_current_words = []

    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        # debugger
        if @all_seen_words[adjacent_word]
          next
        else
          new_current_words << adjacent_word
          @all_seen_words[adjacent_word] = current_word
          # debugger
          return true if adjacent_word == target
        end
      end
    end

    puts "======================================"
    puts "new_current_words:"
    new_current_words.each do |word|
      puts "#{word} came from #{@all_seen_words[word]}"
    end
    puts "======================================"
    @current_words = new_current_words
  end

  def adjacent_words(word)
    @temp_dict.select { |cur_word| WordChainer.adjacent_word?(word, cur_word)}
  end

  def self.adjacent_word?(word1, word2)
    count = 0
    word1.length.times do |i|
      count += 1 if word1[i] != word2[i]
      return false if count > 1
    end
    return true if count == 1
    false
  end
end
