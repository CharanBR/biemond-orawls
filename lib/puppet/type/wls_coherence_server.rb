require File.dirname(__FILE__) + '/../../orawls_core'


module Puppet
  Type.newtype(:wls_coherence_server) do
    include EasyType
    include Utils::WlsAccess
    extend Utils::TitleParser

    desc 'This resource allows you to manage a coherence server in an WebLogic domain.'

    ensurable

    set_command(:wlst)

    to_get_raw_resources do
      Puppet.debug "index #{name}"
      environment = { 'action' => 'index', 'type' => 'wls_coherence_server' }
      wlst template('puppet:///modules/orawls/providers/wls_coherence_server/index.py.erb', binding), environment
    end

    on_create  do | command_builder |
      wlst_action = 'create'
      Puppet.info "create #{name} "
      template('puppet:///modules/orawls/providers/wls_coherence_server/create_modify.py.erb', binding)
    end

    on_modify  do | command_builder |
      wlst_action = 'modify'
      Puppet.info "modify #{name} "
      template('puppet:///modules/orawls/providers/wls_coherence_server/create_modify.py.erb', binding)
    end

    on_destroy  do | command_builder |
      Puppet.info "destroy #{name} "
      template('puppet:///modules/orawls/providers/wls_coherence_server/destroy.py.erb', binding)
    end

    parameter :domain
    parameter :name
    parameter :coherence_server_name
    property  :machine
    #property :autorestart
    #property :restartdelay
    #property :restartinterval
    #property :restartmax
    property :unicastaddress
    property :unicastport
    property :classpath

    add_title_attributes(:coherence_server_name) do
      /^((.*?\/)?(.*)?)$/
    end

  end
end
