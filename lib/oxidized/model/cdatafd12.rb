class CDataFD12 < Oxidized::Model
  using Refinements

  prompt /^([\w."\ ]+(\(.*?\))?[>#]\s?$)/

  comment '! '

  expect /--More .*$/ do |data, re|
    send ' '
    data.sub re, ''
  end

  cfg :telnet do
    username /(>>|User).*?name:/
    password /((>>).*?word:|Password:)/
  end

  cfg :ssh, :telnet do
    post_login "enable"
    post_login "config"
    pre_logout "exit"
    pre_logout "exit"
    pre_logout "exit"
  end

  cmd 'show current-config' do |cfg|
      cfg.cut_both
  end

end