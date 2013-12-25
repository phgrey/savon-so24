class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :delivery_location, class_name:'Location'
  belongs_to :invoice_location, class_name:'Location'
  has_many :lines
  attr_accessible :comment, :external_id, :number

  so24 :invoice

  def company
    user && user.company
  end

  def export
    location = user.locations.first
    self.class.remote.create({
      company_id:user.external_id.to_i,
      company_name: 'GETTEXT',
      delivery_name: company.title,
      addresses:{address:[location.for_so24, location.for_so24('Invoice')]},  #CHECKIT: another format inside
      order_status: 'Web',
      invoice_id: 0,
      date_ordered: created_at.strftime('%Y-%m-%dT00:00:00'),
      date_invoiced: created_at.strftime('%Y-%m-%dT00:00:00'),
      payment_time: 0,
      payment_time_specified: false,
      reference_number: 0,
      project_id:0,
      our_reference:0,
      your_reference: user.external_id.to_i,
      total_sum:0,
      total_tax:0,
      invoice_tile:'',
      invoice_text:'',
      #paid: '0001-01-01\T00:00:00',  #CHECKIT: presence
      type_of_sale: 'Credit',
      inc_vat: false, #CHECKIT:capitalizing????
      show_inc_vat: 'none',
      round_factor: 1,
      round_type: 'none',
      comissions:{comission_item:{
          recipient_id:0,
          recipient_name:'___',
          recipient_type:'Customer',
          amount:0,
          percentage:0,
          default_field:'Amount'
      }},
      invoice_rows:{invoice_row_item:lines.map{|l|{
        product_no: l.product.code,
        product_name: 'GETTEXT',
        price: 9999,
        in_price: 9999,
        discount:0,
        quantitty: l.count,
        type:'Normal',
        is_structure_product: false,
        price_calc: 'Fixed',
        main_product_id:0
      }}},
      to_factoring: 'Auto',
      currency: '',
      currency_rate: 0,
      external_status: 0,
      active: true,
      payment_method_id: 1,
      payment_amount:0,
      invoice_reference: 0,
      ref_order_id: 0,
      credit_note: false,
      sys_expand_structure: true,
      sys_use_system_discount: true,
    })
  end
end
