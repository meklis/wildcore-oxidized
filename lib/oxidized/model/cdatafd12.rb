class CDataFD12 < Oxidized::Model
  using Refinements

  prompt /^([\w.-]+(\(.*?\))?[>#]\s?$)/

  comment '! '

  cfg :telnet do
    username />>.*?name:/
    password />>.*?word:/
  end

  cfg :ssh, :telnet do
    post_login "enable"
    post_login "config"
    post_login "vty output show-all"
    pre_logout "exit"
    pre_logout "exit"
    pre_logout "exit"
  end

  cmd 'show current-config' do |cfg|
      cfg.cut_both
  end

end