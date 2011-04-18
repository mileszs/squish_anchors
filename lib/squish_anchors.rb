module SquishAnchors
  def squish_anchors
    str = self.dup
    match = /<a\shref=["|'](.*?)["|']>([^<]+)<\/a>/.match(str)
    if (match)
      while (next_match = /#{match[0]}(\s*)<a\shref=["|']#{match[1]}["|']>([^<]+)<\/a>/.match(str))
        str.gsub!(/#{match[0]}\s*<a\shref=["|']#{match[1]}["|']>([^<]+)<\/a>/, "<a href=\"#{match[1]}\">#{match[2]}#{next_match[1]}\\1</a>") 
        match = /<a\shref=["|'](.*?)["|']>([^<]+)<\/a>/.match(str)
      end
      str.gsub(/\s+/, ' ')
    else
      str
    end
  end
end
