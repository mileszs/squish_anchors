module SquishAnchors
  LINK_REGEX_BASE = "<a\\shref=[\"']%s[\"']\\s*>([^<]+)<\\/a>"
  REGEXP_OPTIONS = Regexp::IGNORECASE | Regexp::MULTILINE
  LINK_REGEX = Regexp.new(LINK_REGEX_BASE % ["(.*?)"], REGEXP_OPTIONS)

           
  def squish_anchors
    str = self.dup
    match = LINK_REGEX.match(str)
    if (match)
      while ((matcher = Regexp.new("%s(\\s*)#{LINK_REGEX_BASE.to_s}" % [match[0], match[1]], REGEXP_OPTIONS)) && 
              (next_match = matcher.match(str)))
        str.gsub!(matcher, "<a href=\"#{match[1]}\">#{match[2]}#{next_match[1]}\\1</a>")
        match = LINK_REGEX.match(str)
      end
      str.gsub(/\s+/, ' ')
    else
      str
    end
  end
end
