function awhois --wraps='whois -h whois.isg.apple.com' --description 'alias awhois whois -h whois.isg.apple.com'
  whois -h whois.isg.apple.com $argv
        
end
