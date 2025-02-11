function sdrwhois --wraps='whois -h sdrwhois.g.apple.com -p 1043' --description 'alias sdrwhois whois -h sdrwhois.g.apple.com -p 1043'
  whois -h sdrwhois.g.apple.com -p 1043 $argv
        
end
