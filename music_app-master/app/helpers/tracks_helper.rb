module TracksHelper
  def ugly_lyrics(lyrics)
    lines = lyrics.split("\n").map { |line| '&#9835'.html_safe + ' ' + line }
    lines.delete_if { |line| line == '&#9835'.html_safe + ' ' + "\r"}
    output = <<-HTML
      <pre>#{lines.join("\n").html_safe}</pre>
    HTML
    output.html_safe
  end
end
