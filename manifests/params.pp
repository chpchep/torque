class torque::params {
  # munge options
  $munge_install_ensure   = 'installed'
  $munge_service_ensure   = 'running'
  $munge_service_enabled  = true
  $munge_key_location     = undef #hiera ('torque::munge_key',undef)

  # mom options
  $mom_install_ensure     = 'installed'
  $client_install_ensure  = 'installed'
  $mom_service_ensure     = 'running'
  $mom_service_enable     = true
  $torque_server          = undef #hiera ('torque::torque_server',undef)
  $mom_restricted         = []
  $mom_ideal_load_adj     = 0.2
  $mom_max_load_adj       = 1.2
  $mom_options            = {
    logevent => 255,
  }

  # server options
  $server_install_ensure  = 'installed'
  $server_service_ensure  = 'running'
  $server_service_enable  = true
  $torque_server_name     = $::fqdn
  # the following options are protected from being unset if they don't appear in torque_qmgr_server
  $torque_qmgr_present    = [
    'acl_hosts',
    'node_check_rate',
    'tcp_timeout',
    'next_job_number',
  ]
  $torque_qmgr_server     = [
    # internal defaults, usually not needed
#    "acl_hosts = ${::fqdn}",
#    'node_check_rate = 150',
#    'tcp_timeout = 6',
#    'next_job_number = 0',
    #
    'scheduling = True',
    'acl_host_enable = False',
    "managers = root@${::fqdn}",
    "operators = root@${::fqdn}",
    'default_queue = dteam',
    'log_events = 511',
    'mail_from = adm',
    'mail_domain = never',
    'query_other_jobs = True',
    'scheduler_iteration = 600',
    'default_node = lcgpro',
    'node_pack = False',
    'kill_delay = 10',
    "authorized_users = *@${::fqdn}",
  ]
  $torque_qmgr_qdefaults  = [
    'queue_type = Execution',
    'resources_max.cput = 48:00:00',
    'resources_max.walltime = 72:00:00',
    'enabled = True',
    'started = True',
    'acl_group_enable = True',
  ]
  $torque_qmgr_queues     = {}
  # maui options
  $maui_install_ensure    = 'installed'
  $maui_service_ensure    = 'running'
  $maui_service_enable    = true
  $maui_server            = $::fqdn
  $maui_port              = 40559
  $maui_mode              = 'NORMAL'
  $maui_rmcfgtype         = 'PBS'
  $maui_rmcfgopt          = 'TIMEOUT=90'
  $maui_adminhost         = $::fqdn
  $maui_admin1            = 'root'
  $maui_admin3            = undef
  $maui_generalopt        = {
    'NODESYNCTIME'     => '00:00:30',
    # Set PBS server polling interval. If you have short # queues
    # or/and jobs it is worth to set a short interval. (default 10 seconds)
    'RMPOLLINTERVAL'   => '00:00:30',
    # a max. 10 MByte log file in a logical location
    'LOGFILE'          => '/var/log/maui.log',
    'LOGFILEMAXSIZE'   => 10000000,
    'LOGLEVEL'         => 1,
    'LOGFILEROLEDEPTH' => 10,
    # Set the delay to 5 min before Maui tries to run a job again, in
    # case it failed to run the first time. The default value is 1 hour.
    'DEFERTIME'        => '00:05:00',
  }
  $maui_options           = {}
  $maui_groupcfg          = {}
  $maui_usercfg           = {}
  $maui_srcfg             = {}
}