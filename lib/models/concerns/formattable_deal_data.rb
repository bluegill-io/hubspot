module FormattableDealData
  extend ActiveSupport::Concern
  
  def formatted_close_date
    DateTime.strptime(close_date, '%Q').strftime("%m/%d/%Y") if close_date.present?
  end

  def formatted_project_start_date
    format_date(project_start_date) if project_start_date
  end

  def formatted_project_end_date
    format_date(project_end_date) if project_end_date
  end

  def human_deal_stage
    deal_stage.human_readable
  end

  def formatted_floors
    floors.to_i if floors
  end

  def formatted_rooms
    rooms.to_i if rooms
  end

  def formatted_margin_bid
    margin_bid.to_f if margin_bid
  end

  def formatted_margin_close
    margin_close.to_f if margin_close
  end

  def formatted_amount
    amount.gsub!('$', '') if amount
  end

  def formatted_contract_amount
    final_contract_amount.gsub!('$', '') if final_contract_amount
  end

  private 

  def format_date(d)
    date_format =  d.split('/').last.length == 4 ? '%m/%d/%Y' : '%m/%d/%y'
    DateTime.strptime(d, date_format).strftime("%m/%d/%Y")
  end
end