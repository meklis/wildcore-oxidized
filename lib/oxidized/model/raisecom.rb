class RAISECOM < Oxidized::Model
  using Refinements

  comment '! '
  prompt /([\w.@-]+[#>]\s?)$/

  cfg :telnet do
    username /(name|login):/
    password /(word:)/
  end

  cmd 'show version' do |cfg|
    cfg.gsub! /\s(System uptime is ).*/, ' \\1 <removed>'
    comment cfg
  end

  cmd 'show running-config' do |cfg|
    cfg.gsub! /\s(^radius-encrypt-key ).*/, ' \\1 <removed>'
    cfg
  end

  cfg :ssh, :telnet do
    post_login 'terminal page-break disable'
    pre_logout 'exit'
  end
end
