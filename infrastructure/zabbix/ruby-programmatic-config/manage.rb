require './client.rb'

EXAMPLE_HOSTGROUP_NAME = 'lck-hostgroup'
EXAMPLE_TEMPLATE_NAME = 'lck-ping-template'
EXAMPLE_APPLICATION_NAME = 'lck-status'
EXAMPLE_ITEM_NAME = 'lck-ping'
EXAMPLE_TRIGGER_NAME = 'lck-ping-status'
EXAMPLE_HOST_NAME = 'codingkata.tardate.com'

def client
  @client ||= get_client
end

def hostgroup(action = nil, id = nil)
  case action
  when 'get'
    result = client.hostgroup.get(groupids: id)
  when 'create'
    result = client.hostgroup.get(filter: { name: EXAMPLE_HOSTGROUP_NAME }).first
    result ||= begin
      client.hostgroup.create(name: EXAMPLE_HOSTGROUP_NAME)
      client.hostgroup.get(filter: { name: EXAMPLE_HOSTGROUP_NAME }).first
    end
  when 'delete'
    result = client.hostgroup.get(filter: { name: EXAMPLE_HOSTGROUP_NAME }).first
    if result
      puts "deleting .."
      client.hostgroup.delete(Array(result['groupid']))
    else
      puts "no hostgroup found to delete"
    end
  else
    result = client.hostgroup.get
  end
  puts result
  result
end

def get_example_host_keys
  { host: EXAMPLE_HOST_NAME }
end

def host(action = nil, id = nil)
  case action
  when 'get'
    result = client.host.get(hostids: id, selectInterfaces: 'extend')
  when 'create'
    filter_keys = get_example_host_keys
    result = client.host.get(filter: filter_keys).first
    result ||= begin
      belongs_to_hostgroup = hostgroup('create')
      belongs_to_template = template('create')
      attributes = {
        interfaces: [
          { type: 1, main: 1, useip: 0, ip: '', dns: EXAMPLE_HOST_NAME, port: 443 }
        ],
        groups: [
          { groupid: belongs_to_hostgroup['groupid'] }
        ],
        templates: [
          { templateid: belongs_to_template['templateid'] }
        ]
      }
      client.host.create(filter_keys.merge(attributes))
      client.host.get(filter: filter_keys).first
    end
  when 'delete'
    result = client.host.get(filter: get_example_host_keys).first
    if result
      puts "deleting .."
      client.host.delete(Array(result['hostid']))
    else
      puts "no template found to delete"
    end
  else
    result = client.host.get
  end
  puts result
  result
end

def get_example_template_keys
  { host: EXAMPLE_TEMPLATE_NAME }
end

def template(action = nil, id = nil)
  case action
  when 'get'
    result = client.template.get(templateids: id, selectItems: ['itemid'], selectTriggers: ['triggerid'], selectApplications: ['applicationid'])
  when 'create'
    filter_keys = get_example_template_keys
    result = client.template.get(filter: filter_keys).first
    result ||= begin
      belongs_to_hostgroup = hostgroup('create')
      attributes = { groups: { groupid: belongs_to_hostgroup['groupid'] } }
      client.template.create(filter_keys.merge(attributes))
      client.template.get(filter: filter_keys).first
    end
  when 'delete'
    result = client.template.get(filter: get_example_template_keys).first
    if result
      puts "deleting .."
      client.template.delete(Array(result['templateid']))
    else
      puts "no template found to delete"
    end
  else
    result = client.template.get
  end
  puts result
  result
end

def get_example_application_keys
  belongs_to_template = template('create')
  { name: EXAMPLE_APPLICATION_NAME, hostid: belongs_to_template['templateid'] }
end

def application(action = nil, id = nil)
  case action
  when 'get'
    result = client.application.get(applicationids: id)
  when 'create'
    filter_keys = get_example_application_keys
    result = client.application.get(filter: filter_keys).first
    result ||= begin
      client.application.create(filter_keys)
      client.application.get(filter: filter_keys).first
    end
  when 'delete'
    result = client.application.get(filter: get_example_application_keys).first
    if result
      puts "deleting .."
      client.application.delete(Array(result['applicationid']))
    else
      puts "no application found to delete"
    end
  else
    result = client.application.get
  end
  puts result
  result
end

def get_example_item_keys
  belongs_to_template = template('create')
  { name: EXAMPLE_ITEM_NAME, hostid: belongs_to_template['templateid'] }
end

def item(action = nil, id = nil)
  case action
  when 'get'
    result = client.item.get(itemids: id, selectApplications: ['applicationid'])
  when 'create'
    filter_keys = get_example_item_keys
    result = client.item.get(filter: filter_keys).first
    result ||= begin
      belongs_to_application = application('create')
      attributes = {
        'type' => 3, # simple check;
        'key_' => 'icmpping',
        'value_type' => 3, # numeric unsigned type
        'valuemapid' => 1,
        'delay' => '30s', # Update interval
        'interfaceid' => 0,  # Not required for template items.
        'applications' => Array(belongs_to_application['applicationid'])
      }
      client.item.create(filter_keys.merge(attributes))
      client.item.get(filter: filter_keys).first
    end
  when 'delete'
    result = client.item.get(filter: get_example_item_keys).first
    if result
      puts "deleting .."
      client.item.delete(Array(result['itemid']))
    else
      puts "no item found to delete"
    end
  else
    result = client.item.get
  end
  puts result
  result
end

def get_example_trigger_keys
  belongs_to_template = template('create')
  { description: EXAMPLE_TRIGGER_NAME, hostid: belongs_to_template['templateid'] }
end

def trigger(action = nil, id = nil)
  case action
  when 'get'
    result = client.trigger.get(triggerids: id, expandExpression: true)
  when 'create'
    filter_keys = get_example_trigger_keys
    result = client.trigger.get(filter: filter_keys).first
    result ||= begin
      attributes = {
        'expression' => "{#{EXAMPLE_TEMPLATE_NAME}:icmpping.max(#3)}=0",
        'comments' => 'Last three attempts returned timeout. Please check device connectivity.',
        'priority' => 4
      }
      client.trigger.create(filter_keys.merge(attributes))
      client.trigger.get(filter: filter_keys).first
    end
  when 'delete'
    result = client.trigger.get(filter: get_example_trigger_keys).first
    if result
      puts "deleting .."
      client.trigger.delete(Array(result['triggerid']))
    else
      puts "no trigger found to delete"
    end
  else
    result = client.trigger.get
  end
  puts result
  result
end

entity = ARGV.size > 0 ?  ARGV[0] : 'host'
action = ARGV.size > 1 ?  ARGV[1] : 'list'
id = ARGV.size > 2 ?  ARGV[2] : nil
send entity, action, id
