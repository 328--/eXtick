require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  setup do
    @no_name_ticket_params = {"event_name"=>"", "datetime(1i)"=>"2014", "datetime(2i)"=>"11", "datetime(3i)"=>"7", "datetime(4i)"=>"07", "datetime(5i)"=>"38", "place"=>"", "price"=>"", "note"=>"", "user_id"=>"99"}
  end

  test "should validate a event name" do
    ticket = Ticket.new(@no_name_ticket_params)
    assert !ticket.save
  end
end
