# seee https://github.com/GregSutcliffe/puppet-modules/blob/production/modules/ssh/lib/puppet/parser/functions/ssh_keygen.rb
# Forked from https://github.com/fup/puppet-ssh @ 59684a8ae174
#
# Takes a Hash of config arguments:
#   Required parameters:
#     :name   (the name of the key - e.g 'my_ssh_key')
#   Optional parameters:
#     :type   (the key type - default: 'rsa')
#     :dir    (the subdir of /etc/puppet/ to store the key in - default: 'ssh')
#     :size   (the key size - default 2048)
#     :public (if specified, reads the public key instead of the private key)
#
require 'fileutils'
module Puppet::Parser::Functions
  newfunction(:ssh_keygen, :type => :rvalue) do |args|
    unless args.first.class == Hash then
      raise Puppet::ParseError, "ssh_keygen(): config argument must be a Hash"
    end

    config = args.first

    config = {
      'dir'    => 'ssh',
      'type'   => 'rsa',
      'size'   => 2048,
      'public' => false,
    }.merge(config)

    config['size'] = 1024 if config['type'] == 'dsa' and config['size'] > 1024
	
    fullpath = "/etc/puppet/#{config['dir']}"
    # Make sure to write out a directory to init if necessary
    begin
      if !File.directory? fullpath
        FileUtils.mkdir_p fullpath
      end
    rescue => e
      raise Puppet::ParseError, "ssh_keygen(): Unable to setup ssh keystore directory (#{e}) #{%x[whoami]}"
    end

    # Do my keys exist? Well, keygen if they don't!
    begin
      unless File.exists?("#{fullpath}/#{config['name']}_#{config['size']}") then
        %x[/usr/bin/ssh-keygen -t #{config['type']} -b #{config['size']} -P '' -f #{fullpath}/#{config['name']}_#{config['size']}]
      end
    rescue => e
      raise Puppet::ParseError, "ssh_keygen(): Unable to generate ssh key (#{e})"
    end

    # Return ssh key content based on request
    begin
      case config['public']
      when false
        request = 'private'
        return File.open("#{fullpath}/#{config['name']}_#{config['size']}").read
      else
        request = 'public'
        pub_key = File.open("#{fullpath}/#{config['name']}_#{config['size']}.pub").read
        foo = pub_key.scan(/^(.* .*) (.*)$/)[0][0]
        return foo
      end
    rescue => e
      raise Puppet::ParseError, "ssh_keygen(): Unable to read ssh #{request.to_s} key (#{e})"
    end
  end
end
