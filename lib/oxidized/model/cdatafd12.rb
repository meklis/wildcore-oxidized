class CDataFD12 < Oxidized::Model
  using Refinements

  prompt /^([\w."\ ]+(\(.*?\))?[>#]\s?$)/

  comment '! '

  expect /(--More.*)$/ do |data, re|
    send ' '
    data.sub re, ''
  end

  cfg :telnet do
    username /(>>|User).*?name:/
    password /((>>).*?word:|Password:)/
  end

  cfg :telnet do
    post_login "enable"
    post_login "config"
    pre_logout "exit"
    pre_logout "exit"
    pre_logout "exit"
  end

  cfg :ssh do
      post_login "enable"
      post_login "terminal length 0"
      post_login "config"
      post_login "vty output show-all"
      pre_logout "exit"
      pre_logout "exit"
      pre_logout "exit"
  end

  cmd 'show current-config' do |cfg|
      cfg.gsub! /\r\n/, '\n'
      cfg.cut_both
  end

end