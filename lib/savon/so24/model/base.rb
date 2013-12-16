module Savon::So24
  module Model
    class Base
  extend Operations

  class_attribute :id_number, instance_writer:false
  self.id_number = :number


  def self.reconnect
    clean_headers
    global(:headers, { 'cookie' => Auth.connect})
  end

  def self.clean_headers
    client.globals[:headers].present? &&  client.globals[:headers].delete('cookie')
  end

  def self.request(operation, *args)
    #we will re-set this header every time just to be sure it is set
    global(:headers, { 'cookie' => Auth.cookie})
    begin
      super
    rescue Savon::SOAPFault => ex
      if ex.is_auth_not_logged?
        reconnect && super
      else
        raise ex
      end
    end
  end




  class_operations  :create_from_data, :get_data, :get_all, :get_data_array, :delete, :update_from_data

  def self.find id
    id.is_a?(Array) ? by_ids(id) : get_data(entity_handle:{id_number => id})
  end

  def data
    self.class.find external_id
  end

  def import!
    from_so24 self.class.find external_id
  end

  #def from_so24 hash
  #  self.class.from_so24 hash
  #end

  def self.all
    by_handles get_all
  end

  def self.ids_to_handles ids
    { self_handle => ids.map{|id|{id_number => id}}}
  end

  def self.by_ids ids
    by_handles ids_to_handles ids
  end

  def self.by_handles handles
    get_data_array(entity_handles: handles)[(snake_name+'_data').to_sym]
  end

  def self.self_handle
    (snake_name+'_handle').to_sym
  end

  def self.delete id
    super self_handle => {id_number => id}
  end

  def delete!
    check_external_id! 'delete'
    self.class.delete external_id
    update_attribute :external_id, 0
  end

  def self.create data
    create_from_data(data:data)[id_number]
  end

  def create! force = false
    throw Exception.new "Can not create #{self.class.name} (id=#{id}) with external_id" if external_id? && !force
    self.external_id = self.class.create for_so24
    save
    external_id
  end

  def self.update data
    update_from_data data:data
  end

  def update!
    check_external_id! 'update'
    self.class.update for_so24.merge self_handle => {id_number => external_id}
  end

  def export
    external_id? ? update! : create!
  end

  def self.id_handle id
    {handle:{id_number => id}, id_number => id}
  end

  def external_id?
    external_id.to_i > 0
  end

  def check_external_id! action = ''
    throw Exception.new "Can not #{action} #{self.class.name} (id=#{id}) without external_id" unless external_id?
  end
end
end
end