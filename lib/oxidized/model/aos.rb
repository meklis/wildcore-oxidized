class AOS < Oxidized::Model
  using Refinements

  # Alcatel-Lucent Operating System
  # used in OmniSwitch

  comment  '! '

  expect /More: <space> .*$/ do |data, re|
    send ' '
    data.sub re, ''
  end

  cmd :all do |cfg|
    cfg.cut_both
  end

  cmd 'show system' do |cfg|
    cfg = cfg.each_line.find { |line| line.match 'Description' }
    comment cfg.to_s.strip
  end

  cmd 'show chassis' do |cfg|
    comment cfg
  end

  cmd 'show hardware info' do |cfg|
    comment cfg
  end

  cmd 'show license info' do |cfg|
    comment cfg
  end

  cmd 'show license file' do |cfg|
    comment cfg
  end

  cmd 'show configuration snapshot' do |cfg|
    cfg
  end

  cmd 'show current-config' do |cfg|
      cfg.cut_both
  end

  cfg :telnet do
    username /(login|ame):/
    password /ord:/
  end

  cfg :telnet, :ssh do
    post_login "terminal datadump"
    pre_logout 'exit'
  end
end
